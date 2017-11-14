ENV['RACK_ENV'] = 'TEST' # hat is it? what does it do?


require 'capybara'
require 'capybara/rspec'
require 'rspec'
require 'simplecov'
require 'simplecov-console'
require './app/models/link'
require './app/app.rb'
require 'database_cleaner'
require 'dm-transactions'


Capybara.app = App

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::Console,
  # Want a nice code coverage website? Uncomment this next line!
  # SimpleCov::Formatter::HTMLFormatter
])
SimpleCov.start

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.before(:suite) do
    if config.use_transactional_fixtures?
      raise(<<-MSG)
       Delete line `config.use_transactional_fixtures = true` from rails_helper.rb
       (or set it to false) to prevent uncommitted transactions being used in
       JavaScript-dependent specs.

       During testing, the app-under-test that the browser driver connects to
       uses a different database connection to the database connection used by
       the spec. The app's database connection would not be able to access
       uncommitted transaction data setup over the spec's database connection.
       MSG
     end
     DatabaseCleaner.clean_with(:truncation)
  end
  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, type: :feature) do
    driver_shares_db_connection_with_specs = Capybara.current_driver == :rack_test

    if !driver_shares_db_connection_with_specs
      DatabaseCleaner.strategy = :truncation
    end
  end

  config.before(:each) do
    DatabaseCleaner.clean
  end

  config.after(:suite) do
    puts
    puts "\e[33mHave you considered running rubocop? It will help you improve your code!\e[0m"
    puts "\e[33mTry it now! Just run: rubocop\e[0m"
  end
end
