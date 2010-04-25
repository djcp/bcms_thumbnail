require 'mini_magick'
require 'uri'
module ActionView
  module Helpers
    module_function

    def thumbnail(attachment_obj,geometry = '100x100')
      if ! attachment_obj.blank? && attachment_obj.respond_to?('attachment') && ['jpg','png','gif','bmp'].include?(attachment_obj.attachment.file_extension.downcase)
        thumbnail_location = "/bcms_thumbnail_cache/#{geometry}/#{attachment_obj.attachment.file_location.gsub(/[\\\/]/,'-')}.jpg"
        if ! File.exists?("#{RAILS_ROOT}/public#{thumbnail_location}")
          if ! File.exists?("#{RAILS_ROOT}/public/bcms_thumbnail_cache/#{geometry}")
            FileUtils.mkdir_p("#{RAILS_ROOT}/public/bcms_thumbnail_cache/#{geometry}")
            FileUtils.chmod 0755, "#{RAILS_ROOT}/public/bcms_thumbnail_cache/"
            FileUtils.chmod 0755, "#{RAILS_ROOT}/public/bcms_thumbnail_cache/#{geometry}"
          end
          image = MiniMagick::Image.from_file("#{RAILS_ROOT}/tmp/uploads/#{attachment_obj.attachment.file_location}")
          image.resize geometry
          image.write("#{RAILS_ROOT}/public#{thumbnail_location}")
          FileUtils.chmod 0644, "#{RAILS_ROOT}/public#{thumbnail_location}"
          URI::escape(thumbnail_location)
        else
          URI::escape(thumbnail_location)
        end
      else
        logger.warn("bcms_thumbnail: Either the attachment object doesn't accept attachments, you passed us a blank object, or the attachment type can't be thumbnailed.")
        '/image-not-found'
      end
    end
  end
end
