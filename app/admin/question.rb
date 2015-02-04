ActiveAdmin.register Question do
  controller do
    def create
      @question = Question.new permitted_params[:question]
      @question.creator = current_admin_user
      create!
    end
  end

  filter :content
  filter :theme

  form do |f|
    f.inputs do
      f.input :content
      f.input :theme
    end
    f.translated_inputs 'Translated fields', switch_locale: true do |t|
      t.input :content
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :content
    column :theme
    column :learned_theme do |question|
      THEMES_BAYES_TRAINER.classify(question.content)
    end
    column :creator
    column :created_at
    translation_status
    actions defaults: false do |question|
      links = ''.html_safe
      links += link_to I18n.t('active_admin.view'), admin_question_path(question, locale: I18n.locale), class: 'member_link view_link'
      links += link_to I18n.t('active_admin.edit'), edit_admin_question_path(question, locale: I18n.locale), class: 'member_link view_link'
      links += link_to I18n.t('active_admin.delete'), admin_question_path(question, locale: I18n.locale), :method => :delete, :confirm => I18n.t('active_admin.delete_confirmation'), class: 'member_link view_link'
      links
    end
  end

  menu url: -> { admin_questions_path(locale: I18n.locale) }
  permit_params :content, :theme_id, :source, translations_attributes: [:id, :locale, :content, :_destroy]

  show do
    panel I18n.t('active_admin.details', model: I18n.t('activerecord.model.question')) do
      attributes_table_for resource do
        row :id
        row :content
        row :theme
        row(:source) { resource.source.humanize }
        row :creator
        row :created_at
        row :updated_at
      end
    end
  end
end
