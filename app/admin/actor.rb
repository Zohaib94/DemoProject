ActiveAdmin.register Actor do

  form do |f|
    f.inputs "Actor" do
      f.input :first_name
      f.input :last_name
      f.input :gender, as: :select, collection: Actor::GENDERS
      f.input :birth_date, as: :datepicker, start_year: 1900
      f.input :country, as: :string
      f.input :city
      f.input :biography
    end
    f.actions
  end

  config.per_page = 5

  permit_params :first_name, :last_name, :birth_date, :biography, :gender, :country, :city
end
