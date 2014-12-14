ActiveAdmin.register AdminUser do
  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions defaults: false do |admin_user|
      links = ''.html_safe
      links += link_to I18n.t('active_admin.view'), admin_admin_user_path(admin_user, locale: I18n.locale), class: 'member_link view_link'
      links += link_to I18n.t('active_admin.edit'), edit_admin_admin_user_path(admin_user, locale: I18n.locale), class: 'member_link view_link'
      links += link_to I18n.t('active_admin.delete'), admin_admin_user_path(admin_user, locale: I18n.locale), :method => :delete, :confirm => I18n.t('active_admin.delete_confirmation'), class: 'member_link view_link'
      links
    end
  end

  menu priority: 2, url: -> { admin_admin_users_path(locale: I18n.locale) }
  permit_params :email, :password, :password_confirmation

end
