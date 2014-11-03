class Api::V1::GroupsController < Api::V1::BaseController
  # First we need to authorize_user_access
  before_filter :authorize_user_access
  # Then we will check access_granted? and will response accordingly
  before_filter :restrict_api_access

  before_action :set_group, only: [:show, :update, :guests, :register_a_person]

  authorize_resource

  respond_to :json

  resource_description do
    short 'api.docs.resources.groups.short_desc'
    path '/v1/groups'
    formats ['json']
    api_versions '1'
  end

  def_param_group :create_group do
    param :name, :string, desc: 'api.docs.resources.groups.common.params.name', required: true
    param :manager_id, :number, desc: 'api.docs.resources.groups.common.params.manager_id', required: true
  end

  def_param_group :update_group do
    param :name, :string, desc: 'api.docs.resources.groups.common.params.name', required: false
    param :manager_id, :number, desc: 'api.docs.resources.groups.common.params.manager_id', required: false
  end

  def_param_group :pagination do
    param :page, :number, desc: 'api.docs.resources.common.params.page', required: false
    param :per_page, :number, desc: 'api.docs.resources.common.params.per_page', required: false
  end

  api :GET, '/v1/groups', 'api.docs.resources.groups.index.short_desc'
  param_group :pagination
  error code: 400, desc: I18n.t('api.docs.resources.common.errors.bad_request')
  def index
    @groups = Group.includes(:manager).paginate(page: params[:page] || 1, per_page: params[:per_page] || 10)
  end

  api :GET, '/v1/groups/:id', 'api.docs.resources.groups.show.short_desc'
  def show
  end

  api :POST, '/v1/groups', 'api.docs.resources.groups.create.short_desc'
  param_group :create_group
  error code: 400, desc: I18n.t('api.docs.resources.common.errors.bad_request')
  error code: 404, desc: I18n.t('api.docs.resources.common.errors.not_found')
  error code: 422, desc: I18n.t('api.docs.resources.common.errors.invalid_resource')
  def create
    @group = Group.new(permitted_create_params)
    @group.creator = current_user.try(:person)
    if @group.save
      render action: :show
    else
      render_error!('invalid_resource', I18n.t('api.errors.invalid_resource'), 422 , :unprocessable_entity, @group.errors)
    end
  end

  api :PUT, '/v1/groups/:id', 'api.docs.resources.groups.update.short_desc'
  param_group :update_group
  error code: 400, desc: I18n.t('api.docs.resources.common.errors.bad_request')
  error code: 404, desc: I18n.t('api.docs.resources.common.errors.not_found')
  error code: 422, desc: I18n.t('api.docs.resources.common.errors.invalid_resource')
  def update
    if @group.update_attributes(permitted_update_params)
      render action: :show
    else
      render_error!('invalid_resource', I18n.t('api.errors.invalid_resource'), 422 , :unprocessable_entity, @group.errors)
    end
  end

  api :GET, '/v1/groups/:id/guests', 'api.docs.resources.groups.guests.short_desc'
  param_group :pagination
  error code: 400, desc: I18n.t('api.docs.resources.common.errors.bad_request')
  def guests
    @guests = @group.guests.paginate(page: params[:page] || 1, per_page: params[:per_page] || 10)
    render 'api/v1/guests/index'
  end

  api :POST, '/v1/groups/:id/guests', 'api.docs.resources.groups.register_a_person.short_desc'
  param :person_id, :number, desc: 'api.docs.resources.groups.register_a_person.params.person_id', required: true
  error code: 400, desc: I18n.t('api.docs.resources.common.errors.bad_request')
  error code: 404, desc: I18n.t('api.docs.resources.common.errors.not_found')
  error code: 422, desc: I18n.t('api.docs.resources.common.errors.invalid_resource')
  def register_a_person
    @guest = Person.find(params[:person_id])
    @guest.group = @group
    if @guest.save
      render 'api/v1/guests/show'
    else
      errors = { person_id: @guest.errors[:base] }.merge!(@guest.errors.to_h.except(:base))
      render_error!('invalid_resource', I18n.t('api.errors.invalid_resource'), 422 , :unprocessable_entity, errors)
    end
  end

  private
  def set_group
    @group = Group.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def permitted_create_params
    params.permit(:name, :manager_id)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def permitted_update_params
    params.permit(:name, :manager_id)
  end
end