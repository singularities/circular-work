if ENV['CI']
  # Run Capybara against remote server:
  # test using docker container
  Capybara.run_server = false
  Capybara.app_host = 'http://localhost:8030'
end


