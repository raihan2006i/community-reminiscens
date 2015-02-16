class Api::V1::Kb::MultimediaController < Api::V1::BaseController
  # First we need to authorize_user_access
  before_filter :authorize_user_access
  # Then we will check access_granted? and will response accordingly
  before_filter :restrict_api_access

  authorize_resource :multimedia

  respond_to :json

  resource_description do
    short 'api.docs.resources.multimedia.short_desc'
    path '/v1/kb/multimedia'
    formats ['json']
    api_versions '1'
  end

  def_param_group :common do
    param :query, :string, desc: 'api.docs.resources.multimedia.common.params.query', required: false
    param :type, %w(all image video), desc: 'api.docs.resources.multimedia.common.params.type', required: false
  end

  def_param_group :pagination do
    param :page, :number, desc: 'api.docs.resources.common.params.page', required: false
    param :per_page, :number, desc: 'api.docs.resources.common.params.per_page', required: false
  end

  api :GET, '/v1/kb/multimedia/local_search', 'api.docs.resources.multimedia.local_search.short_desc'
  param_group :common
  param_group :pagination
  error code: 400, desc: I18n.t('api.docs.resources.common.errors.bad_request')
  def local_search
    @multimedia = Multimedia
    if params[:query].present?
      @multimedia = @multimedia.local_search(params[:query])
    end
    if params[:type].present? && params[:type] != 'all'
      @multimedia = @multimedia.filter_by_type(params[:type])
    end
    @multimedia = @multimedia.paginate(page: params[:page] || 1, per_page: params[:per_page] || 10)
  end

  api :GET, '/v1/kb/multimedia/thirdparty_search', 'api.docs.resources.multimedia.thirdparty_search.short_desc'
  param_group :common
  param_group :pagination
  error code: 400, desc: I18n.t('api.docs.resources.common.errors.bad_request')
  def thirdparty_search
    @multimedia = Multimedia
    if params[:query].present?
      @multimedia = @multimedia.thirdparty_search(params[:query])
    end
    if params[:type].present? && params[:type] != 'all'
      @multimedia = @multimedia.filter_by_type(params[:type])
    end
    @multimedia = @multimedia.paginate(page: params[:page] || 1, per_page: params[:per_page] || 10)
  end
end