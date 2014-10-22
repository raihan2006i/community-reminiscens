attributes :id, :first_name, :last_name, :title, :birthday, :address, :city, :country, :phone, :mobile, :created_at, :updated_at
node(:email) { |caregiver| caregiver.user.email }