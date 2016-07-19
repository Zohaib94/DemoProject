module MoviesHelper

  def escape_script_tags(embed_url)
    if embed_url.include?('<script>') && embed_url.include?('</script>')
      safe_url = html_escape(embed_url)
    else
      embed_url
    end
  end

  def index_action?(action)
    action == 'index'
  end

end
