namespace :bcms_thumbnail do
  desc 'Clear cached thumbnails'
  task(:clear => :environment) do
    FileUtils.rm_rf("#{RAILS_ROOT}/public/bcms_thumbnail_cache/")
    puts 'Thumbnail cache cleared. You should clear the page cache now as well, to ensure the thumbnails are regenerated properly'
  end
end
