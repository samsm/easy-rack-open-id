# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{easy-rack-open-id}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Sam Schenkman-Moore"]
  s.date = %q{2009-12-20}
  s.description = %q{You supply OpenIDs, this keeps anyone but people with access to those ids from getting through. You don't even have to make a form. :)}
  s.email = %q{samsm@samsm.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    ".gitignore",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "config.ru",
     "easy-rack-open-id.gemspec",
     "lib/easy_rack_open_id.rb",
     "lib/easy_rack_open_id_processing.rb",
     "lib/generic_openid_form.html.erb",
     "lib/nice_openid_form.html.erb",
     "lib/nicer_openid_form.html.erb",
     "public/easy-rack-openid-assets/openid-realselector/css/style.css",
     "public/easy-rack-openid-assets/openid-realselector/demo.html",
     "public/easy-rack-openid-assets/openid-realselector/img/balloon.png",
     "public/easy-rack-openid-assets/openid-realselector/img/indicator.gif",
     "public/easy-rack-openid-assets/openid-realselector/img/openid-icons.png",
     "public/easy-rack-openid-assets/openid-realselector/js/jquery.openid.js",
     "public/easy-rack-openid-assets/openid-realselector/js/jquery.openid.min.js",
     "public/easy-rack-openid-assets/openid-selector/css/openid.css",
     "public/easy-rack-openid-assets/openid-selector/demo.html",
     "public/easy-rack-openid-assets/openid-selector/images/aol.gif",
     "public/easy-rack-openid-assets/openid-selector/images/blogger.ico",
     "public/easy-rack-openid-assets/openid-selector/images/claimid.ico",
     "public/easy-rack-openid-assets/openid-selector/images/facebook.gif",
     "public/easy-rack-openid-assets/openid-selector/images/flickr.ico",
     "public/easy-rack-openid-assets/openid-selector/images/google.gif",
     "public/easy-rack-openid-assets/openid-selector/images/livejournal.ico",
     "public/easy-rack-openid-assets/openid-selector/images/myopenid.ico",
     "public/easy-rack-openid-assets/openid-selector/images/openid-inputicon.gif",
     "public/easy-rack-openid-assets/openid-selector/images/openid.gif",
     "public/easy-rack-openid-assets/openid-selector/images/technorati.ico",
     "public/easy-rack-openid-assets/openid-selector/images/verisign.ico",
     "public/easy-rack-openid-assets/openid-selector/images/vidoop.ico",
     "public/easy-rack-openid-assets/openid-selector/images/wordpress.ico",
     "public/easy-rack-openid-assets/openid-selector/images/yahoo.gif",
     "public/easy-rack-openid-assets/openid-selector/js/jquery-1.2.6.min.js",
     "public/easy-rack-openid-assets/openid-selector/js/openid-jquery.js"
  ]
  s.homepage = %q{http://github.com/samsm/Easy-Rack-OpenID}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Super easy OpenID protection for Rack.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<yard>, [">= 0"])
      s.add_runtime_dependency(%q<rack-openid>, [">= 0"])
    else
      s.add_dependency(%q<yard>, [">= 0"])
      s.add_dependency(%q<rack-openid>, [">= 0"])
    end
  else
    s.add_dependency(%q<yard>, [">= 0"])
    s.add_dependency(%q<rack-openid>, [">= 0"])
  end
end

