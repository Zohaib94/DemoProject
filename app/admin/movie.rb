ActiveAdmin.register Movie do
  scope :waiting_for_approval

  form html: { enctype: "multipart/form-data" } do |f|
    f.inputs "Movie", multipart: true do
      f.input :title
      f.input :release_date, as: :datepicker, start_year: 1900
      f.input :genre, as: :select, collection: Movie::GENRES
      f.input :duration
      f.input :description
      f.input :trailer_url
      f.input :featured
      f.input :approved
      f.input :actors, as: :select, collection: Actor.all, input_html: { multiple: true }
    end
    f.has_many :attachments, heading: 'Posters', new_record: 'Add Poster' do |attachment|
      attachment.input :image, hint: attachment.template.image_tag(attachment.object.image.url(:thumb)), allow_destroy: true
      attachment.input :_destroy, as: :boolean, required: :false, label: 'Remove Poster'
    end
    f.actions
  end

  index do
    column :title
    column :release_date
    column :genre
    column :duration
    column :description
    column :trailer_url
    column :featured
    column :approved
    column 'Actors' do |movie|
      movie.display_actors
    end
    column 'Posters' do |movie|
      div do
        movie.attachments.each do |attachment|
          div do
            image_tag(attachment.image.url(:thumb))
          end
        end
      end
    end
    actions
  end

  config.per_page = 5

  permit_params :title, :release_date, :genre, :duration, :description, :trailer_url, :featured, :approved, attachments_attributes: [:id, :image, :_destroy], actor_ids: []
end
