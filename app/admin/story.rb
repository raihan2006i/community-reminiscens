ActiveAdmin.register Story do
  controller do
    def create
      @story = Story.new permitted_params[:story]
      @story.creator = current_admin_user
      @story.story_fragments.each{|f| f.creator ||= @story.creator }
      @story.attachments.each{|a| a.creator ||= @story.creator }
      @story.comments.each{|c| c.commenter ||= @story.creator }
      create!
    end
  end

  filter :title
  filter :teller
  filter :telling_date
  filter :created_at
  filter :theme
  filter :context

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :title
      f.input :teller
      f.input :theme
      f.input :context
      f.input :telling_date
      f.input :other_theme
      f.input :other_context
    end

    f.inputs 'Fragments' do
      f.has_many :story_fragments, id: 'fragments' do |fragment_builder|
        fragment_builder.input :content, as: :text
        fragment_builder.input :_destroy, as: :boolean, label: 'Remove'
      end
    end

    f.inputs 'Attachments' do
      f.has_many :attachments, id: 'attachments' do |attachment_builder|
        attachment_builder.input :media, as: :file, hint: link_to(attachment_builder.object.file_name, attachment_builder.object.url, target: '_blank', download: attachment_builder.object.url)
        attachment_builder.input :_destroy, as: :boolean, label: 'Remove'
      end
    end

    f.inputs 'Comments' do
      f.has_many :comments, id: 'comments' do |comment_builder|
        comment_builder.input :comment, as: :text
        comment_builder.input :_destroy, as: :boolean, label: 'Remove'
      end
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :title
    column :teller
    column :telling_date
    column :creator
    column :theme
    column :context
    column :created_at
    actions defaults: true do |story|
      links = ''.html_safe
      links += link_to I18n.t('activerecord.models.story_fragment'), admin_story_story_fragments_path(story, locale: I18n.locale), class: 'member_link view_link'
      links += link_to I18n.t('activerecord.models.comment'), admin_story_comments_path(story, locale: I18n.locale), class: 'member_link view_link'
      links += link_to I18n.t('activerecord.models.attachment'), admin_story_attachments_path(story, locale: I18n.locale), class: 'member_link view_link'
      links
    end
  end

  menu priority: 8, url: -> { admin_stories_path(locale: I18n.locale) }
  permit_params :teller_id, :theme_id, :context_id, :telling_date, :other_theme, :other_context, story_fragments_attributes: [:id, :content, :_destroy], attachments_attributes: [:id, :media, :_destroy], comments_attributes: [:id, :comment, :_destroy]

  show do
    panel I18n.t('active_admin.details', model: I18n.t('activerecord.model.story')) do
      attributes_table_for resource do
        row :id
        row :teller
        row :telling_date
        row :theme
        row :context
        row :creator
        row :created_at
        row :updated_at
      end
    end
  end

  sidebar 'Story Details', only: [:show, :edit] do
    ul do
      li link_to 'Fragments', admin_story_story_fragments_path(story)
      li link_to 'Comments', admin_story_comments_path(story)
      li link_to 'Attachments', admin_story_attachments_path(story)
    end
  end
end