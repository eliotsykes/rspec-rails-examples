namespace :doc do
  desc "Print HTTP status codes with associated symbols"
  task :status_codes do
    Rack::Utils::SYMBOL_TO_STATUS_CODE.each do |symbol, status_code|
      puts "#{status_code}   :#{symbol}"
    end
  end
end

# Output from `bin/rake doc:status_codes`
# ---------------------------------------
# 100   :continue
# 101   :switching_protocols
# 102   :processing
# 200   :ok
# 201   :created
# 202   :accepted
# 203   :non_authoritative_information
# 204   :no_content
# 205   :reset_content
# 206   :partial_content
# 207   :multi_status
# 208   :already_reported
# 226   :im_used
# 300   :multiple_choices
# 301   :moved_permanently
# 302   :found
# 303   :see_other
# 304   :not_modified
# 305   :use_proxy
# 307   :temporary_redirect
# 308   :permanent_redirect
# 400   :bad_request
# 401   :unauthorized
# 402   :payment_required
# 403   :forbidden
# 404   :not_found
# 405   :method_not_allowed
# 406   :not_acceptable
# 407   :proxy_authentication_required
# 408   :request_timeout
# 409   :conflict
# 410   :gone
# 411   :length_required
# 412   :precondition_failed
# 413   :payload_too_large
# 414   :uri_too_long
# 415   :unsupported_media_type
# 416   :range_not_satisfiable
# 417   :expectation_failed
# 422   :unprocessable_entity
# 423   :locked
# 424   :failed_dependency
# 426   :upgrade_required
# 428   :precondition_required
# 429   :too_many_requests
# 431   :request_header_fields_too_large
# 500   :internal_server_error
# 501   :not_implemented
# 502   :bad_gateway
# 503   :service_unavailable
# 504   :gateway_timeout
# 505   :http_version_not_supported
# 506   :variant_also_negotiates
# 507   :insufficient_storage
# 508   :loop_detected
# 510   :not_extended
# 511   :network_authentication_required


