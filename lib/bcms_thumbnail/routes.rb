module Cms::Routes
  def routes_for_bcms_thumbnail
    namespace(:cms) do |cms|
      #cms.content_blocks :thumbnails
    end  
  end
end
