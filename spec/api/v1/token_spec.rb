require 'rails_helper'

describe '/api/v1/token' do

  context 'POST' do

    context 'with correct credentials' do

      it 'issues opaque (via encryption) and tamper-resistant (via signing) access token' do
        user = create(:user)
        parameters = { user: { email: user.email, password: user.password } }.to_json

        post '/api/v1/token', parameters, json_request_headers

        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(json.keys).to eq [:access_token]
        expect(json[:access_token]).to be_encrypted_to_hide_token_construction(user.access_tokens.last.unencrypted)
        expect(json[:access_token]).to be_signed_to_resist_tampering
      end

      def be_encrypted_to_hide_token_construction(unencrypted_token)
        satisfy('be encrypted to hide token construction') do |actual_token|
          !actual_token.include?(unencrypted_token) &&
            decrypt_and_verify(actual_token) == unencrypted_token
        end
      end

      def be_signed_to_resist_tampering
        satisfy('be signed to resist tampering') do |token|
          signature_regex = /--[0-9a-z]{40}\z/
          signed = signature_regex =~ token
          token_with_wrong_signature = token.next
          signed && invalid_signature?(token_with_wrong_signature)
        end
      end

      def invalid_signature?(token)
        return false if decrypt_and_verify(token)
      rescue ActiveSupport::MessageVerifier::InvalidSignature
        true
      end

      def decrypt_and_verify(value)
        encryptor = controller.request.cookie_jar.encrypted.instance_variable_get :@encryptor
        encryptor.decrypt_and_verify(value)
      end

      it 'does not respond with cookies (no Set-Cookie header)' do
        user = create(:user)
        parameters = { user: { email: user.email, password: user.password } }.to_json

        post '/api/v1/token', parameters, json_request_headers

        expect(response.headers).not_to have_key 'Set-Cookie'
        expect(response).to have_http_status(:created)
        expect(json.keys).to eq [:access_token]
      end

    end

    context 'with incorrect credentials' do

      it 'responds with 401 Unauthorized for incorrect password' do
        user = create(:user)
        parameters_with_incorrect_password = {
          user: { email: user.email, password: "not #{user.password}" }
        }.to_json

        respond_without_detailed_exceptions do
          post '/api/v1/token', parameters_with_incorrect_password, json_request_headers
        end

        expect(response).to have_http_status(:unauthorized)
        expect(response.content_type).to eq('application/json')
        expect(json).to eq(status: '401', error: 'Unauthorized')
        expect(AccessToken.count).to eq 0
      end

      it 'responds with 401 Unauthorized for unknown email' do
        user = create(:user)
        parameters_with_unknown_email = {
          user: { email: "not.#{user.email}", password: user.password }
        }.to_json

        respond_without_detailed_exceptions do
          post '/api/v1/token', parameters_with_unknown_email, json_request_headers
        end

        expect(response).to have_http_status(:unauthorized)
        expect(response.content_type).to eq('application/json')
        expect(json).to eq(status: '401', error: 'Unauthorized')
        expect(AccessToken.count).to eq 0
      end

      it 'locks user when potential brute force password attack detected after 10 attempts' do
        user = create(:user)

        respond_without_detailed_exceptions do
          10.times do
            expect(user.reload.access_locked?).to eq(false)

            parameters_with_guessed_password = {
              user: { email: user.email, password: SecureRandom.hex }
            }.to_json

            post '/api/v1/token', parameters_with_guessed_password, json_request_headers

            expect(response).to have_http_status(:unauthorized)
            expect(response.content_type).to eq('application/json')
            expect(json).to eq(status: '401', error: 'Unauthorized')
          end

          expect(user.reload.access_locked?).to eq(true)

          parameters_with_correct_password = {
            user: { email: user.email, password: user.password }
          }.to_json

          post '/api/v1/token', parameters_with_correct_password, json_request_headers
        end

        expect(user.reload.failed_attempts).to eq(10)
        expect(user.reload.access_locked?).to eq(true)

        expect(response).to have_http_status(:unauthorized)
        expect(response.content_type).to eq('application/json')
        expect(json).to eq(status: '401', error: 'Unauthorized')
      end

      it 'resets previously failed attempts when unlocked user authenticates successfully' do
        user = create(:user)

        respond_without_detailed_exceptions do
          9.times do
            expect(user.reload.access_locked?).to eq(false)

            parameters_with_guessed_password = {
              user: {
                email: user.email,
                password: SecureRandom.hex
              }
            }.to_json

            post '/api/v1/token', parameters_with_guessed_password, json_request_headers

            expect(response).to have_http_status(:unauthorized)
            expect(response.content_type).to eq('application/json')
            expect(json).to eq(status: '401', error: 'Unauthorized')
          end

          expect(user.reload.access_locked?).to eq(false)
          expect(user.reload.failed_attempts).to eq(9)
          expect(AccessToken.count).to eq 0

          parameters_with_correct_password = {
            user: {
              email: user.email,
              password: user.password
            }
          }.to_json

          post '/api/v1/token', parameters_with_correct_password, json_request_headers
        end

        expect(user.reload.failed_attempts).to eq(0)
        expect(user.reload.access_locked?).to eq(false)

        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(json.keys).to eq [:access_token]
        expect(AccessToken.count).to eq 1
      end

    end

    it 'does not expose format as URL parameter' do
      user = create(:user)
      parameters = { user: { email: user.email, password: user.password } }.to_json

      respond_without_detailed_exceptions do
        post '/api/v1/token.json', parameters, json_request_headers
      end

      expect(response).to have_http_status(:not_found)
      expect(response.content_type).to eq('application/json')
      expect(json).to eq(status: '404', error: 'Not Found')
    end

    context 'with omitted parameters' do

      # https://github.com/eliotsykes/rspec-rails-examples/issues/76
      it 'responds to no params with 400 Bad Request' do
        no_parameters = {}.to_json

        respond_without_detailed_exceptions do
          post '/api/v1/token', no_parameters, json_request_headers
        end

        expect(response).to have_http_status(:bad_request)
        expect(response.content_type).to eq('application/json')
        expect(json).to eq(status: '400', error: 'Bad Request')
      end

      it 'responds to omitted password with 400 Bad Request' do
        user = create(:user)
        parameters_without_password = { user: { email: user.email } }.to_json

        respond_without_detailed_exceptions do
          post '/api/v1/token', parameters_without_password, json_request_headers
        end

        expect(response).to have_http_status(:bad_request)
        expect(response.content_type).to eq('application/json')
        expect(json).to eq(status: '400', error: 'Bad Request')
      end

      it 'responds to omitted email with 400 Bad Request' do
        user = create(:user)
        parameters_without_email = { user: { password: user.password } }.to_json

        respond_without_detailed_exceptions do
          post '/api/v1/token', parameters_without_email, json_request_headers
        end

        expect(response).to have_http_status(:bad_request)
        expect(response.content_type).to eq('application/json')
        expect(json).to eq(status: '400', error: 'Bad Request')
      end

    end

    context 'with non-JSON MIME type request' do
      it 'responds to wrong Content-Type header with 415 Unsupported Media Type' do
        user = create(:user)
        parameters = { user: { email: user.email, password: user.password } }.to_json
        headers = json_request_headers.merge 'Content-Type' => 'text/html; charset=utf-8'

        respond_without_detailed_exceptions do
          post '/api/v1/token', parameters, headers
        end

        expect(response).to have_http_status(:unsupported_media_type)
        expect(response.content_type).to eq('application/json')
        expect(json).to eq(status: '415', error: 'Unsupported Media Type')
      end

      it 'responds to wrong Accept header with 406 Not Acceptable' do
        user = create(:user)
        parameters = { user: { email: user.email, password: user.password } }.to_json
        headers = json_request_headers.merge 'Accept' => 'text/html'

        respond_without_detailed_exceptions do
          post '/api/v1/token', parameters, headers
        end

        expect(response).to have_http_status(:not_acceptable)
        expect(response.content_type).to eq('text/html')
        expect(response.body).to be_empty
      end

      it 'responds to params not formatted as JSON with 400 Bad Request' do
        user = create(:user)
        parameters_without_to_json = { user: { email: user.email, password: user.password } }

        respond_without_detailed_exceptions do
          post '/api/v1/token', parameters_without_to_json, json_request_headers
        end

        expect(response).to have_http_status(:bad_request)
        expect(response.content_type).to eq('application/json')
        expect(json).to eq(status: '400', error: 'Bad Request')
      end
    end
  end
end
