# What does it do?
This repos is related to a Ruby on rails template, it add dependencies and configuration to make your rails api projet ready to code. No additional configuration is required

**build with ruby `3.0.2` and rails `7.0.4`**

## What are the pre-configured dependencies?
- [Devise-jwt](https://github.com/waiting-for-dev/devise-jwt) for api authentification based on Jwt token
- [Pundit](https://github.com/varvet/pundit) to manage authorizations
- [Rack-cors](https://github.com/cyu/rack-cors) to avoid cors error (development setup only)
- [Annotate](https://github.com/ctran/annotate_models) to add sql column on models, specs and factories
- [Letter Opener](https://github.com/ryanb/letter_opener) to preview mail in development
- [Rubocop Rails](https://github.com/rubocop/rubocop-rails) linter and config for rails project
- [FactoryBot Rails](https://github.com/thoughtbot/factory_bot_rails) great spec fixtures with config
- [Rspec Rails](https://github.com/rspec/rspec-rails) great testing framework with config
- [Webmock](https://github.com/bblimke/webmock) to mock api requests during test
- [Siplecov](https://github.com/simplecov-ruby/simplecov) for spec coverage metrics
- [Faker](https://github.com/faker-ruby/faker) for random test data
- [Byebug](https://github.com/deivid-rodriguez/byebug) for debug breaking point (because I prefer it to the official debugger)


# Usage
```shell
git clone git@github.com:Eth3rnit3/rails_api_template.git
rails new my_app -T --database=postgresql --api -m ./rails_api_template/template.rb
```