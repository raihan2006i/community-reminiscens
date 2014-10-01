ActiveAdmin.register Group do
  permit_params :name, :creator_id, :manager_id
end
