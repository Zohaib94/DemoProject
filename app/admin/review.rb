ActiveAdmin.register Review do

  permit_params :user_id, :movie_id, :comment

  index do
    column :id
    column :comment
    column :movie
    column :user
    column :report_count
    column 'Reported By' do |review|
      review.reporters
    end
    actions
  end

  config.per_page = 5

end
