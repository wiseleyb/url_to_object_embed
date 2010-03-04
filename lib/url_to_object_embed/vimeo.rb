module UrlToObjectEmbed

  class Vimeo < UrlToObjectEmbedBase

    #fixed aspec ratio: default is 400x225 - but i brough the default width inline with YouTube
    SIZES = {:small => [320,180],
             :medium => [425,239],
             :large => [480,270],
             :xlarge => [640,360]
            }
    
    # TODO - support the rest of vimeo - this only supports size and video id
    def self.get_object_html(url, options = {})
      id = url.split("/").last
      options[:size] ||= :medium 

      res = template
      res.gsub!("[SIZEW]", SIZES[options[:size]][0].to_s)
      res.gsub!("[SIZEH]", SIZES[options[:size]][1].to_s)
      res.gsub!("[ID]", id)
      return res
    end
    
    
    def self.template
      %(
      <object width="[SIZEW]" height="[SIZEH]">
        <param name="allowfullscreen" value="true" />
        <param name="allowscriptaccess" value="always" />
        <param name="movie" value="http://vimeo.com/moogaloop.swf?clip_id=[ID]&amp;server=vimeo.com&amp;fullscreen=1" />
        <embed src="http://vimeo.com/moogaloop.swf?clip_id=[ID]&amp;server=vimeo.com&amp;fullscreen=1" type="application/x-shockwave-flash" allowfullscreen="true" allowscriptaccess="always" width="[SIZEW]" height="[SIZEH]"></embed>
      </object>
      )
    end
    
      
  end

end

# http://vimeo.com/9806792
# <object width="400" height="225"><param name="allowfullscreen" value="true" /><param name="allowscriptaccess" value="always" /><param name="movie" value="http://vimeo.com/moogaloop.swf?clip_id=9806792&amp;server=vimeo.com&amp;show_title=1&amp;show_byline=1&amp;show_portrait=0&amp;color=&amp;fullscreen=1" /><embed src="http://vimeo.com/moogaloop.swf?clip_id=9806792&amp;server=vimeo.com&amp;show_title=1&amp;show_byline=1&amp;show_portrait=0&amp;color=&amp;fullscreen=1" type="application/x-shockwave-flash" allowfullscreen="true" allowscriptaccess="always" width="400" height="225"></embed></object><p><a href="http://vimeo.com/9806792">Tsunami Sunset</a> from <a href="http://vimeo.com/user1595149">Jose</a> on <a href="http://vimeo.com">Vimeo</a>.</p>