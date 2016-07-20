ThinkingSphinx::Index.define :movie, with: :active_record do
  indexes title, sortable: true
  indexes genre
  indexes description
  indexes [actors.first_name, actors.last_name], as: :actor_name

  has release_date
  has updated_at, type: :timestamp
  has approved
end
