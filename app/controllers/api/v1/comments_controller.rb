class Api::V1::CommentsController < Api::V1::BaseController
  # First we need to authorize_user_access
  before_filter :authorize_user_access
  # Then we will check access_granted? and will response accordingly
  before_filter :restrict_api_access

  before_action :set_commentable
  before_action :set_comment, only: [:show, :update, :destroy]

  authorize_resource :commentable
  authorize_resource :comment, through: :commentable

  # respond_to :json

  resource_description do
    short 'api.docs.resources.comments.short_desc'
    path '/v1/comments'
    formats ['json']
    api_versions '1'
  end

  def_param_group :create_comment do
    param :comment, :string, desc: 'api.docs.resources.comments.common.params.comment', required: true
  end

  def_param_group :update_comment do
    param :comment, :string, desc: 'api.docs.resources.comments.common.params.comment', required: false
  end

  def_param_group :pagination do
    param :page, :number, desc: 'api.docs.resources.common.params.page', required: false
    param :per_page, :number, desc: 'api.docs.resources.common.params.per_page', required: false
  end

  api :GET, '/v1/stories/:story_id/comments', 'api.docs.resources.story_comments.index.short_desc'
  param_group :pagination
  error code: 400, desc: I18n.t('api.docs.resources.common.errors.bad_request')
  def index
    @comments = @commentable.comments.recent.paginate(page: params[:page] || 1, per_page: params[:per_page] || 10)
  end

  api :GET, '/v1/stories/:story_id/comments/:id', 'api.docs.resources.story_comments.show.short_desc'
  def show
  end

  api :POST, '/v1/stories/:story_id/comments', 'api.docs.resources.story_comments.create.short_desc'
  param_group :create_comment
  error code: 400, desc: I18n.t('api.docs.resources.common.errors.bad_request')
  error code: 404, desc: I18n.t('api.docs.resources.common.errors.not_found')
  error code: 422, desc: I18n.t('api.docs.resources.common.errors.invalid_resource')
  def create
    @comment = @commentable.comments.build(permitted_create_params)
    @comment.person = current_user.try(:caregiver)
    if @comment.save
      render action: :show
    else
      render_error!('invalid_resource', I18n.t('api.errors.invalid_resource'), 422 , :unprocessable_entity, @comment.errors)
    end
  end

  api :PUT, '/v1/stories/:story_id/comments/:id', 'api.docs.resources.story_comments.update.short_desc'
  param_group :update_comment
  error code: 400, desc: I18n.t('api.docs.resources.common.errors.bad_request')
  error code: 404, desc: I18n.t('api.docs.resources.common.errors.not_found')
  error code: 422, desc: I18n.t('api.docs.resources.common.errors.invalid_resource')
  def update
    if @comment.update_attributes(permitted_update_params)
      render action: :show
    else
      render_error!('invalid_resource', I18n.t('api.errors.invalid_resource'), 422 , :unprocessable_entity, @comment.errors)
    end
  end

  api :DELETE, '/v1/stories/:story_id/comments/:id', 'api.docs.resources.story_comments.destroy.short_desc'
  error code: 404, desc: I18n.t('api.docs.resources.common.errors.not_found')
  error code: 422, desc: I18n.t('api.docs.resources.common.errors.invalid_resource')
  def destroy
    if @comment.destroy
      render nothing: true, status: :ok
    else
      render_error!('invalid_resource', I18n.t('api.errors.invalid_resource'), 422 , :unprocessable_entity, @comment.errors)
    end
  end

  private
  def set_commentable
    # For now we only support commenting on Story
    if params[:story_id].present?
      @commentable = Story.find(params[:story_id])
    end
  end

  def set_comment
    @comment = @commentable.comments.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def permitted_create_params
    params.permit(:comment)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def permitted_update_params
    params.permit(:comment)
  end
end