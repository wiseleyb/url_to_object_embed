module UrlToObjectEmbed

  class Generic < UrlToObjectEmbedBase

    def self.get_object_html(url, options = {})
      if url.include?("youtube")
        YouTube.get_object_html(url, options)
      elsif url.include?("vimeo")
        Vimeo.get_object_html(url, options)
      else
        url
      end
    end
    
  end
  
end