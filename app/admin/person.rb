ActiveAdmin.register Person do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  permit_params :first_name,
                :last_name,
                :title,
                :birthday,
                :address,
                :city,
                :country,
                :phone,
                :mobile,
                :user_id
end
