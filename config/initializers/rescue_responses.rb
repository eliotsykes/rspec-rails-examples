class UnauthorizedAccess < ActionController::ActionControllerError
end

class UnsupportedMediaType < ActionController::ActionControllerError
end

ActionDispatch::ExceptionWrapper.rescue_responses.merge!(
  'UnauthorizedAccess' => :unauthorized,
  'UnsupportedMediaType' => :unsupported_media_type
)
