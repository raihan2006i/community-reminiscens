class Api::V1::SessionsController < Api::V1::BaseController
  # First we need to authorize_user_access
  # before_filter :authorize_user_access
  # Then we will check access_granted? and will response accordingly
  # before_filter :restrict_api_access

  before_action :set_session, only: [:show, :update, :destroy, :start]

  # authorize_resource

  respond_to :json

  resource_description do
    short 'api.docs.resources.sessions.short_desc'
    path '/v1/sessions'
    formats ['json']
    api_versions '1'
  end

  def_param_group :common do

  end

  def_param_group :create_session do
    param :title, :string, desc: 'api.docs.resources.sessions.create.params.title', required: true
    param :start_at, :string, desc: 'api.docs.resources.sessions.create.params.start_at', required: true
    param :end_at, :string, desc: 'api.docs.resources.sessions.create.params.end_at', required: true
    param_group :common
  end

  def_param_group :update_session do
    param :title, :string, desc: 'api.docs.resources.sessions.update.params.title', required: false
    param :start_at, :string, desc: 'api.docs.resources.sessions.update.params.start_at', required: false
    param :end_at, :string, desc: 'api.docs.resources.sessions.update.params.end_at', required: false
    param :status, [Session::STATUS_NOT_STARTED, Session::STATUS_ONGOING, Session::STATUS_FINISHED], desc: 'api.docs.resources.sessions.update.params.status', required: false
    param_group :common
  end

  def_param_group :pagination do
    param :page, :number, desc: 'api.docs.resources.common.params.page', required: false
    param :per_page, :number, desc: 'api.docs.resources.common.params.per_page', required: false
  end

  api :GET, '/v1/sessions', 'api.docs.resources.sessions.index.short_desc'
  param_group :pagination
  error code: 400, desc: I18n.t('api.docs.resources.common.errors.bad_request')
  def index
    @sessions = Session.includes(:creator).paginate(page: params[:page] || 1, per_page: params[:per_page] || 10)
  end

  api :GET, '/v1/sessions/:id', 'api.docs.resources.sessions.show.short_desc'
  def show
  end

  api :POST, '/v1/sessions', 'api.docs.resources.sessions.create.short_desc'
  param_group :create_session
  error code: 400, desc: I18n.t('api.docs.resources.common.errors.bad_request')
  error code: 404, desc: I18n.t('api.docs.resources.common.errors.not_found')
  error code: 422, desc: I18n.t('api.docs.resources.common.errors.invalid_resource')
  def create
    @session = Session.new(permitted_create_params)
    @session.creator = current_user.try(:caregiver)
    if @session.save
      render action: :show
    else
      render_error!('invalid_resource', I18n.t('api.errors.invalid_resource'), 422 , :unprocessable_entity, @session.errors)
    end
  end

  api :POST, '/v1/sessions/:session_id/start', 'api.docs.resources.sessions.start.short_desc'
  def start
    @session.start!
    render action: :show
  end

  api :PUT, '/v1/sessions/:id', 'api.docs.resources.sessions.update.short_desc'
  param_group :update_session
  error code: 400, desc: I18n.t('api.docs.resources.common.errors.bad_request')
  error code: 404, desc: I18n.t('api.docs.resources.common.errors.not_found')
  error code: 422, desc: I18n.t('api.docs.resources.common.errors.invalid_resource')
  def update
    if @session.update_attributes(permitted_update_params)
      render action: :show
    else
      render_error!('invalid_resource', I18n.t('api.errors.invalid_resource'), 422 , :unprocessable_entity, @session.errors)
    end
  end

  api :DELETE, '/v1/sessions/:id', 'api.docs.resources.sessions.destroy.short_desc'
  error code: 404, desc: I18n.t('api.docs.resources.common.errors.not_found')
  error code: 422, desc: I18n.t('api.docs.resources.common.errors.invalid_resource')
  def destroy
    if @session.destroy
      render nothing: true, status: :ok
    else
      render_error!('invalid_resource', I18n.t('api.errors.invalid_resource'), 422 , :unprocessable_entity, @session.errors)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_session
      @session = Session.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def permitted_create_params
      params.permit(:title, :start_at, :end_at)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def permitted_update_params
      params.permit(:title, :start_at, :end_at, :status)
    end
end