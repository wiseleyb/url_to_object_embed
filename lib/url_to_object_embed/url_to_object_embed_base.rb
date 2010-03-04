module UrlToObjectEmbed #:nodoc:

  #base class for all implementations
  class UrlToObjectEmbedBase

    SIZES = {:small => [320,265],
             :medium => [425,344],
             :large => [480,385],
             :xlarge => [640,505]
            }
            
    def self.get_object_html(url, options = {})
    end

    def self.template
    end
    
  end

end
