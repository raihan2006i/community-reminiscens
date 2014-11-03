ActiveAdmin.register Person, as: 'Caregiver' do
  controller do
    def create
      user_attributes = permitted_params[:person].extract!(:email, :password, :password_confirmation).permit(:email, :password, :password_confirmation)
      @caregiver = Person.create_caregiver(permitted_params[:person], user_attributes)
      respond_with(@caregiver, location: admin_caregivers_path)
    end

    def edit
      resource.email = resource.user.email
    end

    def find_resource
      Person.caregivers.find(params[:id])
    end

    def update
      user_attributes = permitted_params[:person].extract!(:email, :password, :password_confirmation).permit(:email, :password, :password_confirmation)
      @caregiver = Person.update_caregiver(resource, permitted_params[:person], user_attributes)
      respond_with(@caregiver, location: admin_caregiver_path(@caregiver))
    end
  end

  def scoped_collection
    Person.caregivers.includes(:user)
  end

  filter :first_name
  filter :last_name
  filter :user_email, as: :string, label: 'Email'
  filter :city
  filter :country, as: :select, collection: ::ActionView::Helpers::FormOptionsHelper::COUNTRIES

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :title
      f.input :birthday
      f.input :address
      f.input :city
      f.input :country
      f.input :phone
      f.input :mobile
      f.input :email, required: true
      f.input :password, required: f.object.new_record?
      f.input :password_confirmation, required: f.object.new_record?
    end
    f.actions
  end

  index do
    selectable_column
    column :first_name
    column :last_name
    column 'Email', sortable: 'users.email' do |caregiver|
      caregiver.user.email
    end
    column :created_at
    column :updated_at
    actions
  end

  permit_params :first_name, :last_name, :title, :birthday, :address, :city, :country, :phone, :mobile, :email, :password, :password_confirmation

  scope_to do
    Person.caregivers
  end

  show do
    panel 'Caregiver Details' do
      attributes_table_for resource do
        row :id
        row :title
        row :first_name
        row :last_name
        row(:email){ resource.user.email }
        row :address
        row :city
        row :country
        row :phone
        row :mobile
        row :created_at
        row :updated_at
        row('Current sign in at') { resource.user.current_sign_in_at }
        row('Last sign in at') { resource.user.last_sign_in_at }
        row('Current sign in ip'){ resource.user.current_sign_in_ip }
        row('Last sign in ip') { resource.user.last_sign_in_ip }
      end
    end
  end
end