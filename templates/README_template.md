# Templetized from @eth3rnit3 rails api template
https://github.com/Eth3rnit3/rails_api_template

## Dependencies
- [Devise-jwt](https://github.com/waiting-for-dev/devise-jwt)
- [Rack-cors](https://github.com/cyu/rack-cors)
- [Annotate](https://github.com/ctran/annotate_models)
- [Letter Opener](https://github.com/ryanb/letter_opener)
- [Rubocop Rails](https://github.com/rubocop/rubocop-rails)
- [FactoryBot Rails](https://github.com/thoughtbot/factory_bot_rails)
- [Rspec Rails](https://github.com/rspec/rspec-rails)
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

# {"status":"public"}
```

## Call private api
### Auth error
```shell
curl -X GET http://localhost:3000/api/health

# {"error":"You need to sign in or sign up before continuing."}
```

### Auth success
Generate an valid jwt token
```shell
rails c
```
```ruby
User.last.jwt

# "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNjY0NjU0NDI5LCJleHAiOjE2NjQ2NTgwMjksImp0aSI6IjY1Yjk2NTAzLTBkOWMtNDljMi05NzkyLTc2YjQyMTQ1YThlNCJ9.Ivig6RQJ1iCFLE5WHlVH4MDcIrgEQVJpQt8UxLwJrbw"

exit
```

```shell
curl -X GET http://localhost:3000/api/health -H "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIiwic2NwIjoidXNlciIsImF1ZCI6bnVsbCwiaWF0IjoxNjY0NjU0NDI5LCJleHAiOjE2NjQ2NTgwMjksImp0aSI6IjY1Yjk2NTAzLTBkOWMtNDljMi05NzkyLTc2YjQyMTQ1YThlNCJ9.Ivig6RQJ1iCFLE5WHlVH4MDcIrgEQVJpQt8UxLwJrbw"

# {"status":"private"}
```



