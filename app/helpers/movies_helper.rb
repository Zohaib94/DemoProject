module MoviesHelper

  def escape_script_tags(embed_url)
    (embed_url.include?('<script>') && embed_url.include?('</script>')) ? html_escape(embed_url) : embed_url
  end

  def index_action?(action)
    action == 'index'
  end

end
