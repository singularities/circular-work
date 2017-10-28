if ENV['DEFAULT_HOST']
  Rails.application.routes.default_url_options[:host] = ENV['DEFAULT_HOST']
  Rails.application.config.action_mailer.asset_host = ENV['DEFAULT_HOST']
end

