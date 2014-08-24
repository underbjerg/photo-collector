# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
#Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
#Rails.application.config.assets.precompile += %w( plupload/js/plupload.full.min.js )

#Rails.application.config.assets.precompile += %w( plupload/js/plupload.full.min.js )
#Rails.application.config.assets.precompile += %w( plupload/js/jquery.plupload.queue/jquery.plupload.queue.js )

#Rails.application.config.assets.precompile += %w( plupload/js/jquery.plupload.queue/css/jquery.plupload.queue.css )
#Rails.application.config.assets.precompile += %w( masonry.pkgd.min.js )
#Rails.application.config.assets.precompile += %w( imagesloaded.pkgd.min.js )


Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'fonts')
Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|ttf)$/
