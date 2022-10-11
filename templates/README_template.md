# Templetized from @eth3rnit3 rails api template
https://github.com/Eth3rnit3/rails_api_template

## Dependencies
- [Devise-jwt](https://github.com/waiting-for-dev/devise-jwt)
- [Pundit](https://github.com/varvet/pundit)
- [Rack-cors](https://github.com/cyu/rack-cors)
- [Annotate](https://github.com/ctran/annotate_models)
- [Letter Opener](https://github.com/ryanb/letter_opener)
- [Rubocop Rails](https://github.com/rubocop/rubocop-rails)
- [FactoryBot Rails](https://github.com/thoughtbot/factory_bot_rails)
- [Rspec Rails](https://github.com/rspec/rspec-rails)
- [Database Cleaner](https://github.com/DatabaseCleaner/database_cleaner)
- [Webmock](https://github.com/bblimke/webmock)
- [Siplecov](https://github.com/simplecov-ruby/simplecov)
- [Faker](https://github.com/faker-ruby/faker)
- [Byebug](https://github.com/deivid-rodriguez/byebug)


# Usage
## Start server
```shell
rails s
```

## Call public api
```shell
curl -X GET http://localhost:3000/health

# {"message":"public"}
```

## Auth
### Sign up
```shell
curl -XPOST -H "Content-Type: application/json" -d '{ "user": { "email": "user@email.com", "password": "mypassword" } }' http://localhost:3000/users

# {"message":"Signed up."}
```

### Sign in
```shell
curl -v -XPOST -H "Content-Type: application/json" -d '{ "user": { "email": "user@email.com", "password": "mypassword" } }' http://localhost:3000/users/sign_in

# ...
# < Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyIiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNjY1NTI0MzI5LCJleHAiOjE2NjY4MjAzMjksImp0aSI6IjJhY2VjODZlLTJmY2UtNDJhZC04YzZmLWJmM2JjYTIzOWMyNCJ9.X8nCad7gEspNOdNJ5jBHNl9D_z_nc3Dv8YN0Jl5FvX0
# ...

# {"message":"Logged."}
```

## Call private api
### Auth error
```shell
curl -X GET http://localhost:3000/api/health

# {"error":"You need to sign in or sign up before continuing."}
```

### Auth success
```shell
curl -X GET http://localhost:3000/api/health -H "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyIiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNjY1NTI0MzI5LCJleHAiOjE2NjY4MjAzMjksImp0aSI6IjJhY2VjODZlLTJmY2UtNDJhZC04YzZmLWJmM2JjYTIzOWMyNCJ9.X8nCad7gEspNOdNJ5jBHNl9D_z_nc3Dv8YN0Jl5FvX0"

# {"message":"private"}
```

## Rspec
### Api/Response
In spec files with controllers type, you can simply use `json` helper
```ruby
RSpec.describe MyController, type: :controller do
  it 'returns data' do
    get :index

    expect(json[:data]).not_to be_blank
  end
end
````

### Authentification
In spec files with controllers type, you can simply use `sign_in` helper
```ruby
RSpec.describe MyController, type: :controller do
  let(:user) { create(:user) }

  before { sign_in(user) }

  it 'returns success' do
    get :index

    expect(response).to be_sucessfull
  end
end
```