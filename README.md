# BlackAndWhite
[![Build Status](https://travis-ci.org/wizardone/black_and_white.svg?branch=master)](https://travis-ci.org/wizardone/black_and_white)
[![codecov](https://codecov.io/gh/wizardone/black_and_white/branch/master/graph/badge.svg)](https://codecov.io/gh/wizardone/black_and_white)


### A/B Testing made easy

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'black_and_white', '~> 0.2.0'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install black_and_white

## Usage
Black And White is meant to work with Rails for the moment. It has
support for ActiveRecord and Mongoid. In order to
use it first run:
```ruby
rails g black_and_white:config
```
this will create a `black_and_white.rb` config file in
`config/initializers` with some default values. The file looks like this:
```ruby
BlackAndWhite.configure do |config|
  config.bw_class = 'User'
  config.bw_class_table = :users
  config.bw_main_table = :ab_tests
  config.bw_join_table = :ab_tests_users
end

BlackAndWhite::Hooks.init
```
The `Hooks` class requires all the necessary files for the detected
orm. If you are using `ActiveRecord` you need to generate the
corresponding migrations with:

```ruby
rails g black_and_white:migrations
```
Review them and then feel free to migrate. Keep in mind that they give
you only some very basic columns. You can add as much as you want and
extend the logic

### For ActiveRecord
Include the black_and_white module for activerecord interactions. The base class may have multiple a/b tests:
```ruby
class User < ActiveRecord::Base
  include BlackAndWhite::ActiveRecord
end
```
### For Mongoid
Include the black_and_white module for activerecord interactions. The base class may have multiple a/b tests:
```ruby
class User
  include Mongoid::Document
  include BlackAndWhite::Mongoid
end
```

To create a new A/B test you can run:
```ruby
BlackAndWhite.create(name: 'My Test', active: true)
```
By default all created tests are inactive.
To add existing users (or any other object) to the A/B Test you can call:
```ruby
user.ab_participate!('My Test')
user.ab_tests.size
=> 1
user.ab_participates?('My Test')
=> true
```
You can also supply an additional block which is evaluated:
```ruby
user.ab_participate!('My Test') do |user|
  user.admin? # returns true, user is added to the ab test
end
```
A couple of additional options are supported as well:

`join_inactive` => Join an a/b test, even if it is inactive
```ruby
user.ab_participate!('My Inactive test', join_inactive: true)
```
`raise_on_missing` => raises a custom error message if the given a/b test does not exist
```ruby
user.ab_participate!('My Inactive test', raise_on_missing: true)
=> AbTestError, "no A/B Test with name My Inactive test exists or it is not active"
```
A note for `Mongoid`: If you have `Mongoid.raise_not_found_error` this
will raise the generic mongoid error for not found documents.

If you added additional db colums or you want to add or extend more logic you can
use the `add` method which evaluates the given block in the scope of
the main `BlackAndWhite` module. That way you don't have to worry about
code location.
```ruby
BlackAndWhite.add(self) do
  def my_new_method; end
  private
  attr_reader :my_property
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/wizardone/black_and_white. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
