class Api::V1::StoryThemesController < Api::V1::BaseController
  before_action :set_story_theme, only: [:show, :update]
  respond_to :json

  resource_description do
    short 'Story Themes'
    path '/v1/story_themes'
    formats ['json']
    api_versions '1'
  end

  api :GET, '/v1/story_themes', 'Returns available story themes'
  param :page, :number, desc: 'Allows for paging through the results. Default is 1', required: false
  param :per_page, :number, desc: 'Limit the number of results returned. Default is 10', required: false
  def index
    @story_themes = StoryTheme.paginate(page: params[:page] || 1, per_page: params[:per_page] || 10)
    respond_with @story_themes
  end

  api :GET, '/v1/story_themes/:id', 'Returns a story theme'
  def show
    respond_with @story_theme
  end

  api :POST, '/v1/story_themes', 'Create a story theme'
  def create
    @story_theme = StoryTheme.new(permitted_create_params)
    if @story_theme.save
      render action: :show
    else
      render_error!('invalid_resource', I18n.t('errors.api.invalid_resource'), 422 , :unprocessable_entity, @story_theme.errors)
    end
  end

  api :PUT, '/v1/story_themes/:id', 'Update a story theme'
  def update
    if @story_theme.update_attributes(permitted_update_params)
      render action: :show
    else
      render_error!('invalid_resource', I18n.t('errors.api.invalid_resource'), 422 , :unprocessable_entity, @story_theme.errors)
    end
  end

  private
  def set_story_theme
    @story_theme = StoryTheme.find(params[:id])
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