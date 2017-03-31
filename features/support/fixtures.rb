# From https://github.com/cucumber/cucumber/wiki/Fixtures

# Sets up the Rails environment for Cucumber
#require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')
#require 'cucumber/rails/world'
Cucumber::Rails::World.use_transactional_fixtures

module FixtureAccess

  def self.extended(base)

    #Seed the DB
    ActiveRecord::FixtureSet.reset_cache

    fixtures_folder = File.join(Rails.root, 'spec', 'fixtures')
    fixtures = Dir[File.join(fixtures_folder, '*.yml')].map {|f| File.basename(f, '.yml') }

    ActiveRecord::FixtureSet.create_fixtures(fixtures_folder, fixtures)

    (class << base; self; end).class_eval do
      @@fixture_cache = {}
      fixtures.each do |table_name|
        table_name = table_name.to_s.tr('.', '_')
        define_method(table_name) do |*fixture_symbols|
          @@fixture_cache[table_name] ||= {}

          instances = fixture_symbols.map do |fixture_symbol|
            if fix = ActiveRecord::FixtureSet.cached_fixtures(ActiveRecord::Base.connection, table_name).first.fixtures[fixture_symbol.to_s]
              @@fixture_cache[table_name][fixture_symbol] ||= fix.find  # find model.find's the instance
            else
              raise StandardError, "No fixture with name '#{fixture_symbol}' found for table '#{table_name}'"
            end
          end
          instances.size == 1 ? instances.first : instances
        end
      end
    end
  end
end

World(FixtureAccess)
