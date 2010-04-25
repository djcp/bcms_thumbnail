SPEC = Gem::Specification.new do |spec| 
  spec.name = "bcms_thumbnail"
  spec.rubyforge_project = spec.name
  spec.version = "1.0.2"
  spec.summary = "A thumbnailing view helper module for BrowserCMS"
  spec.author = "Dan Collis-Puro" 
  spec.email = "dan@collispuro.com" 
  spec.homepage = "http://github.com/djcp/bcms_thumbnail" 
  spec.files += Dir["app/**/*"]
  spec.files += Dir["db/migrate/*.rb"]
  spec.files -= Dir["db/migrate/*_browsercms_*.rb"]
  spec.files -= Dir["db/migrate/*_load_seed_data.rb"]
  spec.files += Dir["lib/bcms_thumbnail.rb"]
  spec.files += Dir["lib/bcms_thumbnail/*"]
  spec.files += Dir["rails/init.rb"]
  spec.files += Dir["lib/tasks/*.rake"]
  spec.files += Dir["public/bcms/thumbnail/**/*"]
  spec.has_rdoc = true
  spec.extra_rdoc_files = ["README"]
  if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    spec.add_dependency("mini_magick", [">= 1.2.5"])
  end
end
