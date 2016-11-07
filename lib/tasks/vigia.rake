namespace :spec do
  desc 'Run Vigia tests'
  task :vigia => :environment do

    # start rails server by the easiest way
    system("bundle exec rails s -e #{ Rails.env } -d")
    # give some time to the server
    sleep 10

    Vigia.configure do |config|
      config.adapter     = Vigia::Adapters::Raml
      config.source_file = "#{ Rails.root }/api.raml"
      config.host        = 'http://localhost:3000'
    end

    Vigia.rspec!
  end
end
