class Api::V1::SessionHistoriesController < Api::V1::BaseController
  # First we need to authorize_user_access
  before_filter :authorize_user_access
  # Then we will check access_granted? and will response accordingly
  before_filter :restrict_api_access

  before_action :set_session_history, only: [:show, :destroy]

  respond_to :json

  resource_description do
    short 'api.docs.resources.session_histories.short_desc'
    path '/v1/session_histories'
    formats ['json']
    api_versions '1'
  end

  def_param_group :common do

  end
  def_param_group :create_session_history do
    param :session_id, :number, desc: 'api.docs.resources.sessions.common.params.session_id', required: true
    param :slot_id, :number, desc: 'api.docs.resources.slots.common.params.slot_id', required: true
    param :block_id, :number, desc: 'api.docs.resources.blocks.common.params.block_id', required: true
    param_group :common
  end

  def_param_group :pagination do
    param :page, :number, desc: 'api.docs.resources.common.params.page', required: false
    param :per_page, :number, desc: 'api.docs.resources.common.params.per_page', required: false
  end

  api :GET, '/v1/session_histories', 'api.docs.resources.session_histories.index.short_desc'
  param_group :pagination
  error code: 400, desc: I18n.t('api.docs.resources.common.errors.bad_request')
  def index
    @session_histories = SessionHistory.paginate(page: params[:page] || 1, per_page: params[:per_page] || 10)
  end

  api :GET, '/v1/session_histories/:id', 'api.docs.resources.session_histories.show.short_desc'
  def show
  end

  api :POST, '/v1/session_histories', 'api.docs.resources.session_histories.create.short_desc'
  param_group :create_session_history
  error code: 400, desc: I18n.t('api.docs.resources.common.errors.bad_request')
  error code: 404, desc: I18n.t('api.docs.resources.common.errors.not_found')
  error code: 422, desc: I18n.t('api.docs.resources.common.errors.invalid_resource')
  def create
    @session_history = SessionHistory.new(permitted_create_params)
    if @session_history.save
      render action: :show
    else
      render_error!('invalid_resource', I18n.t('api.errors.invalid_resource'), 422 , :unprocessable_entity, @session_history.errors)
    end
  end

  api :DELETE, '/v1/session_history/:id', 'api.docs.resources.slots.destroy.short_desc'
  error code: 404, desc: I18n.t('api.docs.resources.common.errors.not_found')
  error code: 422, desc: I18n.t('api.docs.resources.common.errors.invalid_resource')
  def destroy
    if @session_history.destroy
      render nothing: true, status: :ok
    else
      render_error!('invalid_resource', I18n.t('api.errors.invalid_resource'), 422 , :unprocessable_entity, @session_history.errors)
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_session_history
    @session_history = SessionHistory.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def permitted_create_params
    params.permit(:session_id, :slot_id, :block_id)
  end
end
