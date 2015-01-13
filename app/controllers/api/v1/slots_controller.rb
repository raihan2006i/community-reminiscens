class Api::V1::SlotsController < Api::V1::BaseController
  # First we need to authorize_user_access
  before_filter :authorize_user_access
  # Then we will check access_granted? and will response accordingly
  before_filter :restrict_api_access

  before_action :set_session
  before_action :set_slot, only: [:show, :update, :destroy]

  authorize_resource :session
  authorize_resource :slot, through: :session

  respond_to :json

  resource_description do
    short 'api.docs.resources.slots.short_desc'
    path '/v1/slots'
    formats ['json']
    api_versions '1'
  end

  def_param_group :common do

  end

  def_param_group :create_slot do
    param :title, :string, desc: 'api.docs.resources.slots.common.params.title', required: true
    param :duration, :number, desc: 'api.docs.resources.slots.common.params.duration', required: true
    param_group :common
  end

  def_param_group :update_slot do
    param :title, :string, desc: 'api.docs.resources.slots.common.params.title', required: false
    param :duration, :number, desc: 'api.docs.resources.slots.common.params.duration', required: false
    param_group :common
  end

  def_param_group :pagination do
    param :page, :number, desc: 'api.docs.resources.common.params.page', required: false
    param :per_page, :number, desc: 'api.docs.resources.common.params.per_page', required: false
  end

  api :GET, '/v1/sessions/:session_id/slots', 'api.docs.resources.slots.index.short_desc'
  param_group :pagination
  error code: 400, desc: I18n.t('api.docs.resources.common.errors.bad_request')
  def index
    @slots = @session.slots.includes(:creator).paginate(page: params[:page] || 1, per_page: params[:per_page] || 10)
  end

  api :GET, '/v1/slots/:id', 'api.docs.resources.slots.show.short_desc'
  def show
  end

  api :POST, '/v1/sessions/:session_id/slots', 'api.docs.resources.slots.create.short_desc'
  param_group :create_slot
  error code: 400, desc: I18n.t('api.docs.resources.common.errors.bad_request')
  error code: 404, desc: I18n.t('api.docs.resources.common.errors.not_found')
  error code: 422, desc: I18n.t('api.docs.resources.common.errors.invalid_resource')
  def create
    @slot = @session.slots.build(permitted_create_params)
    @slot.creator = current_user.try(:caregiver)
    if @slot.save
      render action: :show
    else
      render_error!('invalid_resource', I18n.t('api.errors.invalid_resource'), 422 , :unprocessable_entity, @slot.errors)
    end
  end

  api :PUT, '/v1/sessions/:session_id/slots/:id', 'api.docs.resources.slots.update.short_desc'
  param_group :update_slot
  error code: 400, desc: I18n.t('api.docs.resources.common.errors.bad_request')
  error code: 404, desc: I18n.t('api.docs.resources.common.errors.not_found')
  error code: 422, desc: I18n.t('api.docs.resources.common.errors.invalid_resource')
  def update
    if @slot.update_attributes(permitted_update_params)
      render action: :show
    else
      render_error!('invalid_resource', I18n.t('api.errors.invalid_resource'), 422 , :unprocessable_entity, @slot.errors)
    end
  end

  api :DELETE, '/v1/sessions/:session_id/slots/:id', 'api.docs.resources.slots.destroy.short_desc'
  error code: 404, desc: I18n.t('api.docs.resources.common.errors.not_found')
  error code: 422, desc: I18n.t('api.docs.resources.common.errors.invalid_resource')
  def destroy
    if @slot.destroy
      render nothing: true, status: :ok
    else
      render_error!('invalid_resource', I18n.t('api.errors.invalid_resource'), 422 , :unprocessable_entity, @slot.errors)
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_slot
    @slot = @session.slots.find(params[:id])
  end

  def set_session
    @session = Session.find(params[:session_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def permitted_create_params
    params.permit(:title, :duration)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def permitted_update_params
    params.permit(:title, :duration)
  end
end