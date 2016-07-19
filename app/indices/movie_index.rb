ThinkingSphinx::Index.define :movie, with: :active_record do
  indexes title, sortable: true
  indexes genre
  indexes release_date, sortable: true
  indexes [actors.first_name, actors.last_name], as: :actor_name

  has updated_at, type: :timestamp
  has approved
end
