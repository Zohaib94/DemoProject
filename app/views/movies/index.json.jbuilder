json.array!(@movies) do |movie|
  json.extract! movie, :id, :title, :release_date, :genre, :duration, :description, :trailer_url, :featured, :approved
  json.url movie_url(movie, format: :json)
end
