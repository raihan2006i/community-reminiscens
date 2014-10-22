class Api::V1::GuestsController < Api::V1::BaseController
  # First we need to authorize_user_access
  before_filter :authorize_user_access
  # Then we will check access_granted? and will response accordingly
  before_filter :restrict_api_access

  before_action :set_guest, only: [:show, :update]

  authorize_resource :person

  respond_to :json

  resource_description do
    short 'api.docs.resources.guests.short_desc'
    path '/v1/guests'
    formats ['json']
    api_versions '1'
  end

  def_param_group :common do
    param :title, :string, desc: 'api.docs.resources.guests.common.params.title', required: false
    param :birthday, :string, desc: 'api.docs.resources.guests.common.params.birthday', required: false
    param :address, :string, desc: 'api.docs.resources.guests.common.params.address', required: false
    param :city, :string, desc: 'api.docs.resources.guests.common.params.city', required: false
    param :country, :string, desc: 'api.docs.resources.guests.common.params.country', required: false
    param :phone, :string, desc: 'api.docs.resources.guests.common.params.phone', required: false
    param :mobile, :string, desc: 'api.docs.resources.guests.common.params.mobile', required: false
  end

  def_param_group :create_guest do
    param :first_name, :string, desc: 'api.docs.resources.guests.common.params.first_name', required: true
    param :last_name, :string, desc: 'api.docs.resources.guests.common.params.last_name', required: true
    param_group :common
  end

  def_param_group :update_guest do
    param :first_name, :string, desc: 'api.docs.resources.guests.common.params.first_name', required: false
    param :last_name, :string, desc: 'api.docs.resources.guests.common.params.last_name', required: false
    param_group :common
  end

  def_param_group :pagination do
    param :page, :number, desc: 'api.docs.resources.common.params.page', required: false
    param :per_page, :number, desc: 'api.docs.resources.common.params.per_page', required: false
  end

  api :GET, '/v1/guests', 'api.docs.resources.guests.index.short_desc'
  param_group :pagination
  error code: 400, desc: 'api.docs.resources.common.errors.bad_request'
  def index
    @guests = Person.with_role(:guest).paginate(page: params[:page] || 1, per_page: params[:per_page] || 10)
  end

  api :GET, '/v1/guests/:id', 'api.docs.resources.guests.show.short_desc'
  def show
  end

  api :POST, '/v1/guests', 'api.docs.resources.guests.create.short_desc'
  param_group :create_guest
  error code: 400, desc: I18n.t('api.docs.resources.common.errors.bad_request')
  error code: 404, desc: I18n.t('api.docs.resources.common.errors.not_found')
  error code: 422, desc: I18n.t('api.docs.resources.common.errors.invalid_resource')
  def create
    @guest = Person.create_guest(permitted_create_params)
    if @guest.persisted?
      render action: :show
    else
      render_error!('invalid_resource', I18n.t('api.errors.invalid_resource'), 422 , :unprocessable_entity, @guest.errors)
    end
  end

  api :PUT, '/v1/guests/:id', 'api.docs.resources.guests.update.short_desc'
  param_group :update_guest
  error code: 400, desc: I18n.t('api.docs.resources.common.errors.bad_request')
  error code: 404, desc: I18n.t('api.docs.resources.common.errors.not_found')
  error code: 422, desc: I18n.t('api.docs.resources.common.errors.invalid_resource')
  def update
    if @guest.update_attributes(permitted_update_params)
      render action: :show
    else
      render_error!('invalid_resource', I18n.t('api.errors.invalid_resource'), 422 , :unprocessable_entity, @guest.errors)
    end
  end

  private
  def set_guest
    @guest = Person.with_role(:guest).find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def permitted_create_params
    params.permit(:first_name, :last_name, :title, :birthday, :address, :city, :country, :phone, :mobile)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def permitted_update_params
    params.permit(:first_name, :last_name, :title, :birthday, :address, :city, :country, :phone, :mobile)
  end
end