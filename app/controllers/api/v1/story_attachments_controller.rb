class Api::V1::StoryAttachmentsController < Api::V1::BaseController
  # First we need to authorize_user_access
  before_filter :authorize_user_access
  # Then we will check access_granted? and will response accordingly
  before_filter :restrict_api_access

  before_action :set_story
  before_action :set_attachment, only: [:show, :update, :destroy]

  authorize_resource :story
  authorize_resource :attachment, through: :story

  respond_to :json

  resource_description do
    short 'api.docs.resources.story_attachments.short_desc'
    path '/v1/story_attachments'
    formats ['json']
    api_versions '1'
  end

  def_param_group :common do
  end

  def_param_group :create_attachment do
    param :media, :file, desc: 'api.docs.resources.story_attachments.common.params.media', required: true
    param_group :common
  end

  def_param_group :update_attachment do
    param :media, :file, desc: 'api.docs.resources.story_attachments.common.params.media', required: false
    param_group :common
  end

  def_param_group :pagination do
    param :page, :number, desc: 'api.docs.resources.common.params.page', required: false
    param :per_page, :number, desc: 'api.docs.resources.common.params.per_page', required: false
  end

  api :GET, '/v1/stories/:story_id/story_attachments', 'api.docs.resources.story_attachments.index.short_desc'
  param_group :pagination
  error code: 400, desc: I18n.t('api.docs.resources.common.errors.bad_request')
  def index
    @attachments = @story.attachments.paginate(page: params[:page] || 1, per_page: params[:per_page] || 10)
  end

  api :GET, '/v1/stories/:story_id/story_attachments/:id', 'api.docs.resources.story_attachments.show.short_desc'
  def show
  end

  api :POST, '/v1/stories/:story_id/story_attachments', 'api.docs.resources.story_attachments.create.short_desc'
  param_group :create_attachment
  error code: 400, desc: I18n.t('api.docs.resources.common.errors.bad_request')
  error code: 404, desc: I18n.t('api.docs.resources.common.errors.not_found')
  error code: 422, desc: I18n.t('api.docs.resources.common.errors.invalid_resource')
  def create
    @attachment = @story.attachments.build(permitted_create_params)
    if @attachment.save
      render action: :show
    else
      render_error!('invalid_resource', I18n.t('api.errors.invalid_resource'), 422 , :unprocessable_entity, @attachment.errors)
    end
  end

  api :PUT, '/v1/stories/:story_id/story_attachments/:id', 'api.docs.resources.story_attachments.update.short_desc'
  param_group :update_attachment
  error code: 400, desc: I18n.t('api.docs.resources.common.errors.bad_request')
  error code: 404, desc: I18n.t('api.docs.resources.common.errors.not_found')
  error code: 422, desc: I18n.t('api.docs.resources.common.errors.invalid_resource')
  def update
    if @attachment.update_attributes(permitted_update_params)
      render action: :show
    else
      render_error!('invalid_resource', I18n.t('api.errors.invalid_resource'), 422 , :unprocessable_entity, @attachment.errors)
    end
  end

  api :DELETE, '/v1/stories/:story_id/story_attachments/:id', 'api.docs.resources.story_attachments.destroy.short_desc'
  error code: 404, desc: I18n.t('api.docs.resources.common.errors.not_found')
  error code: 422, desc: I18n.t('api.docs.resources.common.errors.invalid_resource')
  def destroy
    if @attachment.destroy
      render nothing: true, status: :ok
    else
      render_error!('invalid_resource', I18n.t('api.errors.invalid_resource'), 422 , :unprocessable_entity, @attachment.errors)
    end
  end

  private
  def set_story
    @story = Story.find(params[:story_id])
  end

  def set_attachment
    @attachment = @story.attachments.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def permitted_create_params
    params.permit(:media)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def permitted_update_params
    params.permit(:media)
  end
end