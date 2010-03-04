module UrlToObjectEmbed

  class YouTube < UrlToObjectEmbedBase

    SIZES = {:small => [320,265],
             :medium => [425,344],
             :large => [480,385],
             :xlarge => [640,505]
            }
    
    def self.get_object_html(url, options = {})
      url.gsub!("watch?v=","v/")
      params = url.split("/").last.split("&")
      id = params.delete_at(0)
      params.each do |p|
        parr = p.split("=")
        options[:hl] ||= parr.last if parr.first == "hl"
        options[:allow_full_screen] ||= parr.last if parr.first == "fs"
        options[:include_related_videos] ||= parr.last if parr.first == "rel"
        options[:border] ||= parr.last if parr.first == "border"
        options[:color1] ||= parr.last if parr.first == "color1"
        options[:color2] ||= parr.last if parr.first == "color2"
      end

      options[:size] ||= :medium 
      options[:allow_script_access] ||= "always" 
      options[:allow_full_screen] ||= true #url fs=1
      options[:enable_privacy_enhanced_mode] ||= false  #if true youtube.com becomes youtube-nocookie.com
      options[:include_related_videos] ||= false    #url rel=0
      
      options.keys.each do |k|
        options[k] = options[k].to_s
      end
      options[:size] = options[:size].to_sym
      
      #rebuild url
      url = url.split("&").first
      url.gsub!("youtube.com","youtube-nocookie.com") if options[:enable_privacy_enhanced_mode] == "true"
      url << "&hl=#{options[:hl]}" unless options[:hl].blank?
      url << "&rel=#{ tfi(options[:include_related_videos])}"
      url << "&fs=#{ tfi(options[:allow_full_screen])}"
      url << "&border=#{options[:border]}" unless options[:border].blank?
      url << "&color1=#{options[:color1]}" unless options[:color1].blank?
      url << "&color2=#{options[:color2]}" unless options[:color2].blank?
      res = template
      res.gsub!("[SIZEW]", SIZES[options[:size]][0].to_s)
      res.gsub!("[SIZEH]", SIZES[options[:size]][1].to_s)
      res.gsub!("[URL]", url)
      res.gsub!("[allow_full_screen]", tf(options[:allow_full_screen]))
      res.gsub!("[allow_script_access]", tf(options[:allow_script_access]))
      return res
    end
    
    
    def self.template
      %(
      <object width="[SIZEW]" height="[SIZEH]">
        <param name="movie" value="[URL]"></param>
        <param name="allowFullScreen" value="[allow_full_screen]"></param>
        <param name="allowscriptaccess" value="[allow_script_access]"></param>
        <embed src="[URL]" 
          type="application/x-shockwave-flash" 
          allowscriptaccess="[allow_script_access]" 
          allowfullscreen="[allow_full_screen]" 
          width="[SIZEW]" height="[SIZEH]"></embed>
      </object>
      )
    end
    
    private 
    def self.tf(v)
      return "true" if v == true || v == "true" || v == "1"
      return "false"
    end

    def self.tfi(v)
      return "1" if v == true || v == "true" || v == "1"
      return "0"
    end
      
  end

end

# http://www.youtube.com/v/37Ro7irBbSw&hl=en_US&fs=1&rel=0
# http://www.youtube.com/watch?v=37Ro7irBbSw&feature=related
# 
# <object width="445" height="364">
# <param name="movie" value="http://www.youtube-nocookie.com/v/37Ro7irBbSw&hl=en_US&fs=1&border=1"></param>
# <param name="allowFullScreen" value="true"></param>
# <param name="allowscriptaccess" value="always"></param>
# <embed src="http://www.youtube-nocookie.com/v/37Ro7irBbSw&hl=en_US&fs=1&border=1" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="445" height="364"></embed></object>
# 
# 
# <object width="445" height="364"><param name="movie" value="http://www.youtube-nocookie.com/v/37Ro7irBbSw&hl=en_US&fs=1&color1=0xe1600f&color2=0xfebd01&border=1"></param><param name="allowFullScreen" value="true"></param><param name="allowscriptaccess" value="always"></param><embed src="http://www.youtube-nocookie.com/v/37Ro7irBbSw&hl=en_US&fs=1&color1=0xe1600f&color2=0xfebd01&border=1" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="445" height="364"></embed></object>
# 
# 
# <object width="445" height="364"><param name="movie" value="http://www.youtube-nocookie.com/v/37Ro7irBbSw&hl=en_US&fs=1&rel=0&border=1"></param><param name="allowFullScreen" value="true"></param><param name="allowscriptaccess" value="always"></param><embed src="http://www.youtube-nocookie.com/v/37Ro7irBbSw&hl=en_US&fs=1&rel=0&border=1" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="445" height="364"></embed></object>