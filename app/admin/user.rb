ActiveAdmin.register User do

  form html: { enctype: "multipart/form-data" } do |f|
    f.inputs "User", multipart: true do
      f.input :first_name
      f.input :last_name
      f.input :gender, as: :select, collection: User::GENDERS
      f.input :birth_date, as: :datepicker, start_year: 1900
      f.input :email
      f.input :password


      f.object.build_attachment unless f.object.attachment
      f.inputs 'Attachment', for: [:attachment, f.object.attachment] do |a|
        a.input :image, as: :file, hint: a.template.image_tag(a.object.image.url(:thumb))
      end
    end

    f.actions
  end

  index do
    column :first_name
    column :last_name
    column :gender
    column :birth_date
    column :email
    column 'Profile Picture' do |user|
      image_tag(user.attachment.image.url(:thumb)) if user.attachment
    end
    column :last_sign_in_at
    column :last_sign_in_ip
    column :current_sign_in_at
    column :current_sign_in_ip
    column :confirmed_at
    column :confirmation_sent_at
    column :unconfirmed_email
    actions
  end

  config.per_page = 5

  permit_params :first_name, :last_name, :gender, :birth_date, :email, :password, attachment_attributes: [:id, :image, :_destroy]
end
