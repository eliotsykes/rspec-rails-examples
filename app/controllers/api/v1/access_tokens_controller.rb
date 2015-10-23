class Api::V1::AccessTokensController < Api::ApiController

  def create
    respond_to_json do
      render json: { access_token: token_guardian.issue_token }, status: :created
    end
  end

  private

  def respond_to_json
    assert_request_content_type Mime::JSON
    respond_to { |format| format.json { yield } }
  end

  def assert_request_content_type(content_type)
    raise UnsupportedMediaType unless request.content_type == content_type
  end
  
  def token_guardian
    @token_guardian ||= TokenGuardian.build(controller: self)
  end

end
