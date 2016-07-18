ActiveAdmin.register ReportedReview do

  permit_params :user_id, :review_id

  filter :review, collection: proc { Review.pluck(:comment, :id) }
  filter :user

  index do
    column :id
    column :user
    column :review
    column :created_at
    column :updated_at
    actions
  end

  form do |f|

    f.inputs 'Reported Review' do
      f.input :user
      f.input :review, as: :select, collection: Review.all.map { |r| [r.comment, r.id] }
    end

    f.submit

  end

end
