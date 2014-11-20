class Api::V1::StoryFragmentsController < Api::V1::BaseController
  # First we need to authorize_user_access
  before_filter :authorize_user_access
  # Then we will check access_granted? and will response accordingly
  before_filter :restrict_api_access

  before_action :set_story
  before_action :set_story_fragment, only: [:show, :update, :destroy]

  authorize_resource :story
  authorize_resource through: :story

  respond_to :json

  resource_description do
    short 'api.docs.resources.story_fragments.short_desc'
    path '/v1/story_fragments'
    formats ['json']
    api_versions '1'
  end

  def_param_group :common do
  end

  def_param_group :create_story_fragment do
    param :content, :string, desc: 'api.docs.resources.story_fragments.common.params.content', required: true
    param_group :common
  end

  def_param_group :update_story_fragment do
    param :content, :string, desc: 'api.docs.resources.story_fragments.common.params.content', required: false
    param_group :common
  end

  def_param_group :pagination do
    param :page, :number, desc: 'api.docs.resources.common.params.page', required: false
    param :per_page, :number, desc: 'api.docs.resources.common.params.per_page', required: false
  end

  api :GET, '/v1/stories/:story_id/story_fragments', 'api.docs.resources.story_fragments.index.short_desc'
  param_group :pagination
  error code: 400, desc: I18n.t('api.docs.resources.common.errors.bad_request')
  def index
    @story_fragments = @story.story_fragments.includes(:creator).paginate(page: params[:page] || 1, per_page: params[:per_page] || 10)
  end

  api :GET, '/v1/stories/:story_id/story_fragments/:id', 'api.docs.resources.story_fragments.show.short_desc'
  def show
  end

  api :POST, '/v1/stories/:story_id/story_fragments', 'api.docs.resources.story_fragments.create.short_desc'
  param_group :create_story_fragment
  error code: 400, desc: I18n.t('api.docs.resources.common.errors.bad_request')
  error code: 404, desc: I18n.t('api.docs.resources.common.errors.not_found')
  error code: 422, desc: I18n.t('api.docs.resources.common.errors.invalid_resource')
  def create
    @story_fragment = @story.story_fragments.new(permitted_create_params)
    @story_fragment.creator = current_user.try(:caregiver)
    if @story_fragment.save
      render action: :show
    else
      render_error!('invalid_resource', I18n.t('api.errors.invalid_resource'), 422 , :unprocessable_entity, @story_fragment.errors)
    end
  end

  api :PUT, '/v1/stories/:story_id/story_fragments/:id', 'api.docs.resources.story_fragments.update.short_desc'
  param_group :update_story_fragment
  error code: 400, desc: I18n.t('api.docs.resources.common.errors.bad_request')
  error code: 404, desc: I18n.t('api.docs.resources.common.errors.not_found')
  error code: 422, desc: I18n.t('api.docs.resources.common.errors.invalid_resource')
  def update
    if @story_fragment.update_attributes(permitted_update_params)
      render action: :show
    else
      render_error!('invalid_resource', I18n.t('api.errors.invalid_resource'), 422 , :unprocessable_entity, @story_fragment.errors)
    end
  end

  api :DELETE, '/v1/stories/:story_id/story_fragments/:id', 'api.docs.resources.story_fragments.destroy.short_desc'
  error code: 404, desc: I18n.t('api.docs.resources.common.errors.not_found')
  error code: 422, desc: I18n.t('api.docs.resources.common.errors.invalid_resource')
  def destroy
    if @story_fragment.destroy
      render nothing: true, status: :ok
    else
      render_error!('invalid_resource', I18n.t('api.errors.invalid_resource'), 422 , :unprocessable_entity, @story_fragment.errors)
    end
  end

  private
  def set_story
    @story = Story.find(params[:story_id])
  end

  def set_story_fragment
    @story_fragment = @story.story_fragments.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def permitted_create_params
    params.permit(:content)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def permitted_update_params
    params.permit(:content)
  end
end