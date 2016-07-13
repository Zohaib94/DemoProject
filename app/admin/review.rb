ActiveAdmin.register Review do
  index do
    column :id
    column :comment
    column :movie
    column :user
    column :report_count
    actions
  end
  permit_params :user_id, :movie_id, :comment

end
