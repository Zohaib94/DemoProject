module RatingsHelper
  def create_star_id_url(rating)
    ['/movies/', params[:id], '/ratings/', rating.id].join
  end
end
