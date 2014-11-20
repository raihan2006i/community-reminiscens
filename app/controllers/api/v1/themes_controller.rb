class Api::V1::ThemesController < Api::V1::BaseController
  # First we need to authorize_user_access
  before_filter :authorize_user_access
  # Then we will check access_granted? and will response accordingly
  before_filter :restrict_api_access

  before_action :set_theme, only: [:show, :update]

  authorize_resource

  respond_to :json

  resource_description do
    short 'api.docs.resources.themes.short_desc'
    path '/v1/themes'
    formats ['json']
    api_versions '1'
  end

  def_param_group :common do
    param :start_age, :number, desc: 'api.docs.resources.themes.common.params.start_age', required: false
    param :end_age, :number, desc: 'api.docs.resources.themes.common.params.end_age', required: false
  end

  def_param_group :create_theme do
    param :name, :string, desc: 'api.docs.resources.themes.common.params.name', required: true
    param_group :common
  end

  def_param_group :update_theme do
    param :name, :string, desc: 'api.docs.resources.themes.common.params.name', required: false
    param_group :common
  end

  def_param_group :pagination do
    param :page, :number, desc: 'api.docs.resources.common.params.page', required: false
    param :per_page, :number, desc: 'api.docs.resources.common.params.per_page', required: false
  end

  api :GET, '/v1/themes', 'api.docs.resources.themes.index.short_desc'
  param_group :pagination
  error code: 400, desc: I18n.t('api.docs.resources.common.errors.bad_request')
  def index
    @themes = Theme.paginate(page: params[:page] || 1, per_page: params[:per_page] || 10)
  end

  api :GET, '/v1/themes/:id', 'api.docs.resources.themes.show.short_desc'
  def show
  end

  api :POST, '/v1/themes', 'api.docs.resources.themes.create.short_desc'
  param_group :create_theme
  error code: 400, desc: I18n.t('api.docs.resources.common.errors.bad_request')
  error code: 404, desc: I18n.t('api.docs.resources.common.errors.not_found')
  error code: 422, desc: I18n.t('api.docs.resources.common.errors.invalid_resource')
  def create
    @theme = Theme.new(permitted_create_params)
    @theme.creator = current_user.try(:caregiver)
    if @theme.save
      render action: :show
    else
      render_error!('invalid_resource', I18n.t('api.errors.invalid_resource'), 422 , :unprocessable_entity, @theme.errors)
    end
  end

  api :PUT, '/v1/themes/:id', 'api.docs.resources.themes.update.short_desc'
  param_group :update_theme
  error code: 400, desc: I18n.t('api.docs.resources.common.errors.bad_request')
  error code: 404, desc: I18n.t('api.docs.resources.common.errors.not_found')
  error code: 422, desc: I18n.t('api.docs.resources.common.errors.invalid_resource')
  def update
    if @theme.update_attributes(permitted_update_params)
      render action: :show
    else
      render_error!('invalid_resource', I18n.t('api.errors.invalid_resource'), 422 , :unprocessable_entity, @theme.errors)
    end
  end

  private
  def set_theme
    @theme = Theme.find(params[:id])
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