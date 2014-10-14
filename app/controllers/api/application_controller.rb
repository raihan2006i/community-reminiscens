class Api::ApplicationController < ActionController::Base
  before_filter :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options={})
    { :locale => I18n.locale }
  end

  def render_error!(error, error_description, code, status, messages = [])
    render json: {
        error: error,
        error_description: error_description,
        code: code,
        messages: messages
    }.to_json, status: status
  end

  # def error(status, code, message)
  #   render json: {error: {code: code, message: message}}.to_json, status: status
  # end
  #
  # def success(message)
  #   render json: {success: {code: 200, message: message}}.to_json, status: :ok
  # end
  #
  # def current_user
  #   @current_user
  # end
  #
  # def access_granted?
  #   @access_granted == true
  # end

  protected
  rescue_from ActiveRecord::RecordNotFound do |e|
    render_error!('not_found', I18n.t('errors.api.not_found'), 404, :not_found)
  end

  rescue_from CanCan::AccessDenied do |e|
    render_error!('forbidden', I18n.t('errors.api.forbidden'), 403, :forbidden)
  end

  rescue_from ArgumentError do |e|
    render_error!('bad_request', I18n.t('errors.api.bad_request'), 400, :bad_request)
  end

  rescue_from Apipie::ParamError do |e|
    render_error!('bad_request', I18n.t('errors.api.bad_request'), 400, :bad_request)
  end

  rescue_from Apipie::ParamInvalid do |e|
    render_error!('bad_request', I18n.t('errors.api.bad_request'), 400, :bad_request)
  end

  rescue_from Apipie::ParamMissing do |e|
    render_error!('bad_request', I18n.t('errors.api.bad_request'), 400, :bad_request)
  end

  # private
  # def restrict_api_access
  #   unless access_granted?
  #     error(:unauthorized, 401, "Unauthorized")
  #   end
  # end
  #
  # def authorize_api_access
  #   authenticate_or_request_with_http_token do |token, options|
  #     @access_granted = false
  #     @api_token = nil
  #     if token.present?
  #       api_token = ApiToken.where(token: token).first
  #
  #       # Notice how we use Devise.secure_compare to compare the token
  #       # in the database with the token given in the params, mitigating
  #       # timing attacks.
  #       if api_token && Devise.secure_compare(api_token.token, token)
  #         @api_token = api_token
  #         @access_granted = true
  #       end
  #     end
  #     true
  #   end
  # end

  # REF https://gist.github.com/josevalim/fb706b1e933ef01e4fb6#file-2_safe_token_authentication-rb-L14
  # def authorize_user_access
  #   authenticate_or_request_with_http_token do |token, options|
  #     @access_granted = false
  #     @current_user = nil
  #     begin
  #       if token.present?
  #         # Token format in http header will be
  #         # id:authentication_token
  #         user_id_and_token = token.split(":")
  #         user_id = user_id_and_token.first
  #         authentication_token = user_id_and_token.last
  #         user = user_id && User.find(user_id)
  #
  #         # Notice how we use Devise.secure_compare to compare the token
  #         # in the database with the token given in the params, mitigating
  #         # timing attacks.
  #         if user && Devise.secure_compare(user.authentication_token, authentication_token)
  #           @current_user = user
  #           @access_granted = true
  #         end
  #       end
  #     rescue => e
  #     end
  #     true
  #   end
  # end
end