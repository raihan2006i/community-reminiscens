ActiveAdmin.register Session do
  controller do
    def create
      @session = Session.new permitted_params[:session]
      @session.creator = current_admin_user
      create!
    end
  end

  filter :title
  filter :start_at
  filter :end_at
  filter :created_at
  filter :status, as: :select, collection: Session::status_options_for_dropdown

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :title
      f.input :start_at
      f.input :end_at
      f.input :status, collection: Session::status_options_for_dropdown
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :title
    column :start_at
    column :end_at
    column :status do |session|
      status_tag session.status.humanize, session.status
    end
    column :creator
    column :created_at
    actions defaults: false do |session|
      link_to('Slots', admin_session_slots_path(session)) + ' ' + link_to('Histories', admin_session_session_histories_path(session))
    end
  end

  show do
    columns do
      column span: 6 do
        panel 'Session Details' do
          attributes_table_for resource do
            row :id
            row :title
            row :start_at
            row :end_at
            row :status do |session|
              status_tag session.status.humanize, session.status
            end
            row :created_at
            row :updated_at
            row :creator
          end
        end
      end
      column span: 6 do
        panel 'Event Messages' do
          render partial: 'event_messages'
        end
      end
    end
    columns do
      column span: 12 do
        panel 'Blocks' do
          collection = resource.blocks.page(params[:blocks_page]).per(10)
          pagination_options = {param_name: 'blocks_page', download_links: false}
          paginated_collection(collection, pagination_options) do
            table_options = { id: 'blocks-table', class: 'index_table' }
            table_for(collection, table_options) do
              column :id
              column :slot
              column(:question) {|block| block.blockable.content}
              column :action do |block|
                link_to 'Live', live_admin_block_path(block), remote: true, method: :put
              end
            end
          end
        end
      end
    end
  end

  menu priority: 9, url: -> { admin_sessions_path(locale: I18n.locale) }
  permit_params :title, :start_at, :end_at, :status
end