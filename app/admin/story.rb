ActiveAdmin.register Story do
  permit_params :teller_id, :theme_id, :context_id, :telling_date, :other_theme, :other_context, fragment_contents: []

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :teller
      f.input :theme
      f.input :context
      f.input :telling_date
      f.input :other_theme
      f.input :other_context
    end
    f.actions
  end
end