ActiveAdmin.register Attachment do
  belongs_to :story, polymorphic: true, optional: true

  controller do
    def create
      @attachment = parent.attachments.new permitted_params[:attachment]
      @attachment.creator = current_admin_user
      create!
    end
  end

  index do
    selectable_column
    id_column
    column :attachable
    column :creator
    column :file_name, sortable: 'media_file_name' do |attachment|
      link_to(attachment.file_name, attachment.url, target: '_blank', download: attachment.url)
    end
    column :content_type, sortable: 'media_content_type' do |attachment|
      attachment.content_type
    end
    column :file_size, sortable: 'media_file_size' do |attachment|
      "#{number_to_human_size attachment.file_size}"
    end
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :media, as: :file, hint: link_to(f.object.file_name, f.object.url, target: '_blank', download: f.object.url)
    end
    f.actions
  end

  menu false
  permit_params :media

  show do
    panel I18n.t('active_admin.details', model: I18n.t('activerecord.model.attachment')) do
      attributes_table_for resource do
        row :id
        row :attachable
        row :creator
        row :file_name do |attachment|
          link_to(attachment.file_name, attachment.url, target: '_blank', download: attachment.url)
        end
        row :content_type do |attachment|
          attachment.content_type
        end
        row :file_size do |attachment|
          "#{number_to_human_size attachment.file_size}"
        end
        row :created_at
        row :updated_at
      end
    end
  end
end