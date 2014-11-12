class Api::V1::StoriesController < Api::V1::BaseController
  # First we need to authorize_user_access
  before_filter :authorize_user_access
  # Then we will check access_granted? and will response accordingly
  before_filter :restrict_api_access

  before_action :set_story, only: [:show, :update]

  authorize_resource

  respond_to :json

  resource_description do
    short 'api.docs.resources.stories.short_desc'
    path '/v1/stories'
    formats ['json']
    api_versions '1'
  end

  def_param_group :common do
    param :story_theme_id, :number, desc: 'api.docs.resources.stories.common.params.story_theme_id', required: false
    param :story_context_id, :number, desc: 'api.docs.resources.stories.common.params.story_context_id', required: false
    param :other_story_theme, :string, desc: 'api.docs.resources.stories.common.params.other_story_theme', required: false
    param :other_story_context, :string, desc: 'api.docs.resources.stories.common.params.other_story_context', required: false
  end

  def_param_group :create_story do
    param :story_fragment, :string, desc: 'api.docs.resources.stories.common.params.story_fragment', required: true
    param :teller_id, :number, desc: 'api.docs.resources.stories.common.params.teller_id', required: true
    param :telling_date, :string, desc: 'api.docs.resources.stories.common.params.telling_date', required: true
    param :attachments, :array, desc: 'api.docs.resources.stories.common.params.attachments', required: false
    param_group :common
  end

  def_param_group :update_story do
    param :teller_id, :number, desc: 'api.docs.resources.stories.common.params.teller_id', required: false
    param :telling_date, :string, desc: 'api.docs.resources.stories.common.params.telling_date', required: false
    param_group :common
  end

  def_param_group :pagination do
    param :page, :number, desc: 'api.docs.resources.common.params.page', required: false
    param :per_page, :number, desc: 'api.docs.resources.common.params.per_page', required: false
  end

  api :GET, '/v1/stories', 'api.docs.resources.stories.index.short_desc'
  param_group :pagination
  error code: 400, desc: I18n.t('api.docs.resources.common.errors.bad_request')
  def index
    @stories = Story.includes(:creator, :story_context, :story_theme, :teller).paginate(page: params[:page] || 1, per_page: params[:per_page] || 10)
  end

  api :GET, '/v1/stories/:id', 'api.docs.resources.stories.show.short_desc'
  def show
  end

  api :POST, '/v1/stories', 'api.docs.resources.stories.create.short_desc'
  param_group :create_story
  error code: 400, desc: I18n.t('api.docs.resources.common.errors.bad_request')
  error code: 404, desc: I18n.t('api.docs.resources.common.errors.not_found')
  error code: 422, desc: I18n.t('api.docs.resources.common.errors.invalid_resource')
  def create
    @story = Story.new(permitted_create_params)
    @story.creator = current_user.try(:caregiver)
    process_attachments(@story, permitted_attachments_params[:attachments])
    if @story.save
      render action: :show
    else
      render_error!('invalid_resource', I18n.t('api.errors.invalid_resource'), 422 , :unprocessable_entity, @story.errors)
    end
  end

  api :PUT, '/v1/stories/:id', 'api.docs.resources.stories.update.short_desc'
  param_group :update_story
  error code: 400, desc: I18n.t('api.docs.resources.common.errors.bad_request')
  error code: 404, desc: I18n.t('api.docs.resources.common.errors.not_found')
  error code: 422, desc: I18n.t('api.docs.resources.common.errors.invalid_resource')
  def update
    if @story.update_attributes(permitted_update_params)
      render action: :show
    else
      render_error!('invalid_resource', I18n.t('api.errors.invalid_resource'), 422 , :unprocessable_entity, @story.errors)
    end
  end

  private
  def set_story
    @story = Story.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def permitted_create_params
    params.permit(:teller_id, :story_theme_id, :story_context_id, :telling_date, :other_story_theme, :other_story_context, :story_fragment)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def permitted_update_params
    params.permit(:teller_id, :story_theme_id, :story_context_id, :telling_date, :other_story_theme, :other_story_context)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def permitted_attachments_params
    params.permit(attachments: [])
  end


  def process_attachments(story, attachments = {})
    if attachments.present?
      attachments.each { |attachment|
        story.attachments.build(media: attachment)
      }
    end
  end
end