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
    f.has_many :attachments, heading: 'Actor Pictures', new_record: 'Add Picture' do |attachment|
      attachment.input :image, hint: attachment.template.image_tag(attachment.object.image.url(:thumb)), allow_destroy: true
      attachment.input :_destroy, as: :boolean, required: :false, label: 'Remove Picture'
    end
    f.actions
  end

  index do
    column :first_name
    column :last_name
    column :birth_date
    column :biography
    column :gender
    column :country
    column :city
    column 'Pictures' do |actor|
      div do
        actor.attachments.each do |attachment|
          div do
            image_tag(attachment.image.url(:thumb))
          end
        end
      end
    end
    actions
  end

  config.per_page = 5

  permit_params :first_name, :last_name, :birth_date, :biography, :gender, :country, :city, attachments_attributes: [:id, :image, :_destroy]
end
