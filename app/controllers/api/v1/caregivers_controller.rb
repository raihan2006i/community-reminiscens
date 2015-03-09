class Api::V1::CaregiversController < Api::V1::BaseController
  # First we need to authorize_user_access
  before_filter :authorize_user_access, except: [ :authorize ]
  # Then we will check access_granted? and will response accordingly
  before_filter :restrict_api_access, except: [ :authorize ]

  before_action :set_caregiver, only: [:show, :update]

  authorize_resource :caregiver

  respond_to :json

  resource_description do
    short 'api.docs.resources.caregivers.short_desc'
    path '/v1/caregivers'
    formats ['json']
    api_versions '1'
  end

  def_param_group :common do
    param :title, :string, desc: 'api.docs.resources.caregivers.common.params.title', required: false
    param :birthday, :string, desc: 'api.docs.resources.caregivers.common.params.birthday', required: false
    param :address, :string, desc: 'api.docs.resources.caregivers.common.params.address', required: false
    param :city, :string, desc: 'api.docs.resources.caregivers.common.params.city', required: false
    param :country, :string, desc: 'api.docs.resources.caregivers.common.params.country', required: false
    param :phone, :string, desc: 'api.docs.resources.caregivers.common.params.phone', required: false
    param :mobile, :string, desc: 'api.docs.resources.caregivers.common.params.mobile', required: false
  end

  def_param_group :create_caregiver do
    param :first_name, :string, desc: 'api.docs.resources.caregivers.common.params.first_name', required: true
    param :last_name, :string, desc: 'api.docs.resources.caregivers.common.params.last_name', required: true
    param :email, :string, desc: 'api.docs.resources.caregivers.common.params.email', required: true
    param :password, :string, desc: 'api.docs.resources.caregivers.common.params.password', required: true
    param :password_confirmation, :string, desc: 'api.docs.resources.caregivers.common.params.password_confirmation', required: true
    param_group :common
  end

  def_param_group :update_caregiver do
    param :first_name, :string, desc: 'api.docs.resources.caregivers.common.params.first_name', required: false
    param :last_name, :string, desc: 'api.docs.resources.caregivers.common.params.last_name', required: false
    param :email, :string, desc: 'api.docs.resources.caregivers.common.params.email', required: false
    param :password, :string, desc: 'api.docs.resources.caregivers.common.params.password', required: false
    param :password_confirmation, :string, desc: 'api.docs.resources.caregivers.common.params.password_confirmation', required: false
    param_group :common
  end

  def_param_group :pagination do
    param :page, :number, desc: 'api.docs.resources.common.params.page', required: false
    param :per_page, :number, desc: 'api.docs.resources.common.params.per_page', required: false
  end

  api :POST, '/v1/caregivers/authorize', 'api.docs.resources.caregivers.authorize.short_desc'
  param :email, :string, desc: 'api.docs.resources.caregivers.authorize.params.email', required: true
  param :password, :string, desc: 'api.docs.resources.caregivers.authorize.params.password', required: true
  error code: 400, desc: 'api.docs.resources.common.errors.bad_request'
  error code: 404, desc: 'api.docs.resources.common.errors.not_found'
  def authorize
    @caregiver = Moderator.authorize!(params[:email], params[:password])
  end

  api :GET, '/v1/caregivers', 'api.docs.resources.caregivers.index.short_desc'
  param_group :pagination
  error code: 400, desc: 'api.docs.resources.common.errors.bad_request'
  def index
    @caregivers = Moderator.includes(:user).paginate(page: params[:page] || 1, per_page: params[:per_page] || 10)
  end

  api :GET, '/v1/caregivers/:id', 'api.docs.resources.caregivers.show.short_desc'
  def show
  end

  api :POST, '/v1/caregivers', 'api.docs.resources.caregivers.create.short_desc'
  param_group :create_caregiver
  error code: 400, desc: I18n.t('api.docs.resources.common.errors.bad_request')
  error code: 404, desc: I18n.t('api.docs.resources.common.errors.not_found')
  error code: 422, desc: I18n.t('api.docs.resources.common.errors.invalid_resource')
  def create
    @caregiver = Moderator.new(permitted_create_params)
    if @caregiver.save
      render action: :show
    else
      render_error!('invalid_resource', I18n.t('api.errors.invalid_resource'), 422 , :unprocessable_entity, @caregiver.errors)
    end
  end

  api :PUT, '/v1/caregivers/:id', 'api.docs.resources.caregivers.update.short_desc'
  param_group :update_caregiver
  error code: 400, desc: I18n.t('api.docs.resources.common.errors.bad_request')
  error code: 404, desc: I18n.t('api.docs.resources.common.errors.not_found')
  error code: 422, desc: I18n.t('api.docs.resources.common.errors.invalid_resource')
  def update
    if @caregiver.update_attributes(permitted_update_params)
      render action: :show
    else
      render_error!('invalid_resource', I18n.t('api.errors.invalid_resource'), 422 , :unprocessable_entity, @caregiver.errors)
    end
  end

  private
  def set_caregiver
    @caregiver = Moderator.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def permitted_create_params
    params.permit(:first_name, :last_name, :title, :birthday, :address, :city, :country, :phone, :mobile, :email, :password, :password_confirmation)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def permitted_update_params
    params.permit(:first_name, :last_name, :title, :birthday, :address, :city, :country, :phone, :mobile, :email)
  end
end