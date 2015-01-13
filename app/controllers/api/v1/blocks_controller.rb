class Api::V1::BlocksController < Api::V1::BaseController
  # First we need to authorize_user_access
  before_filter :authorize_user_access
  # Then we will check access_granted? and will response accordingly
  before_filter :restrict_api_access

  before_action :set_session
  before_action :set_slot
  before_action :set_block, only: [:show, :update, :destroy]

  authorize_resource :session
  authorize_resource :slot, through: :session
  authorize_resource :block, through: :slot

  respond_to :json

  resource_description do
    short 'api.docs.resources.blocks.short_desc'
    path '/v1/blocks'
    formats ['json']
    api_versions '1'
  end

  def_param_group :common do

  end

  def_param_group :create_block do
    param_group :common
  end

  def_param_group :update_block do
    param_group :common
  end

  def_param_group :pagination do
    param :page, :number, desc: 'api.docs.resources.common.params.page', required: false
    param :per_page, :number, desc: 'api.docs.resources.common.params.per_page', required: false
  end

  api :GET, '/v1/sessions/:session_id/slots/:slot_id/blocks', 'api.docs.resources.blocks.index.short_desc'
  param_group :pagination
  error code: 400, desc: I18n.t('api.docs.resources.common.errors.bad_request')
  def index
    @blocks = @slot.blocks.paginate(page: params[:page] || 1, per_page: params[:per_page] || 10)
  end

  api :GET, '/v1/sessions/:session_id/slots/:slot_id/blocks/:id', 'api.docs.resources.blocks.show.short_desc'
  def show
  end

  api :POST, '/v1/sessions/:session_id/slots/:slot_id/blocks', 'api.docs.resources.blocks.create.short_desc'
  param_group :create_block
  error code: 400, desc: I18n.t('api.docs.resources.common.errors.bad_request')
  error code: 404, desc: I18n.t('api.docs.resources.common.errors.not_found')
  error code: 422, desc: I18n.t('api.docs.resources.common.errors.invalid_resource')
  def create
    @block = @slot.blocks.build(permitted_create_params)
    if @block.save
      render action: :show
    else
      render_error!('invalid_resource', I18n.t('api.errors.invalid_resource'), 422 , :unprocessable_entity, @block.errors)
    end
  end

  api :PUT, '/v1/sessions/:session_id/slots/:slot_id/blocks/:id', 'api.docs.resources.slots.update.short_desc'
  param_group :update_block
  error code: 400, desc: I18n.t('api.docs.resources.common.errors.bad_request')
  error code: 404, desc: I18n.t('api.docs.resources.common.errors.not_found')
  error code: 422, desc: I18n.t('api.docs.resources.common.errors.invalid_resource')
  def update
    if @block.update_attributes(permitted_update_params)
      render action: :show
    else
      render_error!('invalid_resource', I18n.t('api.errors.invalid_resource'), 422 , :unprocessable_entity, @block.errors)
    end
  end

  api :DELETE, '/v1/sessions/:session_id/slots/:slot_id/blocks/:id', 'api.docs.resources.slots.destroy.short_desc'
  error code: 404, desc: I18n.t('api.docs.resources.common.errors.not_found')
  error code: 422, desc: I18n.t('api.docs.resources.common.errors.invalid_resource')
  def destroy
    if @block.destroy
      render nothing: true, status: :ok
    else
      render_error!('invalid_resource', I18n.t('api.errors.invalid_resource'), 422 , :unprocessable_entity, @block.errors)
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_session
    @session = Session.find(params[:session_id])
  end

  def set_slot
    @slot = @session.slots.find(params[:slot_id])
  end

  def set_block
    @block = @slot.blocks.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def permitted_create_params
    params.permit(:title, :duration, :blockable_id, :blockable_type)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def permitted_update_params
    params.permit(:title, :duration, :blockable_id, :blockable_type)
  end
end
