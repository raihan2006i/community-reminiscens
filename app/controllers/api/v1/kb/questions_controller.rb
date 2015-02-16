class Api::V1::Kb::QuestionsController < Api::V1::BaseController
  # First we need to authorize_user_access
  before_filter :authorize_user_access
  # Then we will check access_granted? and will response accordingly
  before_filter :restrict_api_access

  authorize_resource :question

  respond_to :json

  resource_description do
    short 'api.docs.resources.questions.short_desc'
    path '/v1/kb/questions'
    formats ['json']
    api_versions '1'
  end

  def_param_group :pagination do
    param :page, :number, desc: 'api.docs.resources.common.params.page', required: false
    param :per_page, :number, desc: 'api.docs.resources.common.params.per_page', required: false
  end

  api :GET, '/v1/kb/questions/search', 'api.docs.resources.questions.search.short_desc'
  param :query, :string, desc: 'api.docs.resources.questions.search.params.query', required: false
  param_group :pagination
  error code: 400, desc: I18n.t('api.docs.resources.common.errors.bad_request')
  def search
    @questions = Question.includes(:theme)
    if params[:query].present?
      @questions = @questions.search(params[:query])
    end
    @questions = @questions.paginate(page: params[:page] || 1, per_page: params[:per_page] || 10)
  end
end