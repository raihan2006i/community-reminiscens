class Api::V1::ContextsController < Api::V1::BaseController
  # First we need to authorize_user_access
  before_filter :authorize_user_access
  # Then we will check access_granted? and will response accordingly
  before_filter :restrict_api_access

  before_action :set_context, only: [:show, :update]

  authorize_resource

  respond_to :json

  resource_description do
    short 'api.docs.resources.contexts.short_desc'
    path '/v1/contexts'
    formats ['json']
    api_versions '1'
  end

  def_param_group :create_context do
    param :name, :string, desc: 'api.docs.resources.contexts.common.params.name', required: true
  end

  def_param_group :update_context do
    param :name, :string, desc: 'api.docs.resources.contexts.common.params.name', required: false
  end

  def_param_group :pagination do
    param :page, :number, desc: 'api.docs.resources.common.params.page', required: false
    param :per_page, :number, desc: 'api.docs.resources.common.params.per_page', required: false
  end

  api :GET, '/v1/contexts', 'api.docs.resources.contexts.index.short_desc'
  param_group :pagination
  error code: 400, desc: I18n.t('api.docs.resources.common.errors.bad_request')
  def index
    @contexts = Context.paginate(page: params[:page] || 1, per_page: params[:per_page] || 10)
  end

  api :GET, '/v1/contexts/:id', 'api.docs.resources.contexts.show.short_desc'
  def show
  end

  api :POST, '/v1/contexts', 'api.docs.resources.contexts.create.short_desc'
  param_group :create_context
  error code: 400, desc: I18n.t('api.docs.resources.common.errors.bad_request')
  error code: 404, desc: I18n.t('api.docs.resources.common.errors.not_found')
  error code: 422, desc: I18n.t('api.docs.resources.common.errors.invalid_resource')
  def create
    @context = Context.new(permitted_create_params)
    @context.creator = current_user.try(:caregiver)
    if @context.save
      render action: :show
    else
      render_error!('invalid_resource', I18n.t('api.errors.invalid_resource'), 422 , :unprocessable_entity, @context.errors)
    end
  end

  api :PUT, '/v1/contexts/:id', 'api.docs.resources.contexts.update.short_desc'
  param_group :update_context
  error code: 400, desc: I18n.t('api.docs.resources.common.errors.bad_request')
  error code: 404, desc: I18n.t('api.docs.resources.common.errors.not_found')
  error code: 422, desc: I18n.t('api.docs.resources.common.errors.invalid_resource')
  def update
    if @context.update_attributes(permitted_update_params)
      render action: :show
    else
      render_error!('invalid_resource', I18n.t('api.errors.invalid_resource'), 422 , :unprocessable_entity, @context.errors)
    end
  end

  private
  def set_context
    @context = Context.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def permitted_create_params
    params.permit(:name, :start_age, :end_age)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def permitted_update_params
    params.permit(:name, :start_age, :end_age)
  end
end
