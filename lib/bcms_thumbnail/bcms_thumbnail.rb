require 'mini_magick'
require 'uri'
module ActionView
  module Helpers
    module_function

    def thumbnail(attachment_obj,geometry = '100x100')
      thumbnail_engine(attachment_obj,geometry,false)
    end

    def thumbnail_square(attachment_obj,geometry = '100')
      fixed_geometry = geometry
      if geometry.match(/\D/)
        fixed_geometry = geometry.split(/\D/)[0]
      end
      thumbnail_engine(attachment_obj,geometry,true)
    end

    def thumbnail_engine(attachment_obj,geometry = '100x100',square = false)
      if ! attachment_obj.blank? && attachment_obj.respond_to?('attachment') && ['jpg','png','gif','bmp'].include?(attachment_obj.attachment.file_extension.downcase)
        thumbnail_location = "/bcms_thumbnail_cache/#{geometry}/#{attachment_obj.attachment.file_location.gsub(/[\\\/]/,'-')}#{(square) ? '-square' : ''}.jpg"
        if ! File.exists?("#{RAILS_ROOT}/public#{thumbnail_location}")
          if ! File.exists?("#{RAILS_ROOT}/public/bcms_thumbnail_cache/#{geometry}")
            FileUtils.mkdir_p("#{RAILS_ROOT}/public/bcms_thumbnail_cache/#{geometry}")
            FileUtils.chmod 0755, "#{RAILS_ROOT}/public/bcms_thumbnail_cache/"
            FileUtils.chmod 0755, "#{RAILS_ROOT}/public/bcms_thumbnail_cache/#{geometry}"
          end
          image = MiniMagick::Image.from_file("#{RAILS_ROOT}/tmp/uploads/#{attachment_obj.attachment.file_location}")
          if square
            if image[:width] < image[:height]
              remove = ((image[:height] - image[:width])/2).round
              image.shave "0x#{remove}"
            elsif image[:width] > image[:height]
              remove = ((image[:width] - image[:height])/2).round
              image.shave "#{remove}x0"
            end
            image.resize "#{geometry}x#{geometry}"
          else
            image.resize geometry
          end
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
