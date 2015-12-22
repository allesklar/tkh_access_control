# Tkh Access Control

This is a Rails engine which provides basic authentication and authorization.

Primarily developed for Ten Thousand Hours but we are happy to share if anybody finds it useful.  It's primarily developed to work in sync with the tkh_cms gem suite but over time more and more effort will be made to make it work in isolation if some interest is shown by the community.


## Installation

Add this line to your application's Gemfile:

    gem 'tkh_access_control', '~> 0.13'

And then execute:

    $ bundle

Import migration and locale files

		$ rake tkh_access_control:install

Run the migration

		$ rake db:migrate

You need a root route in your app but most apps have that already.

And then of course restart your server!

		$ rails server


## Upgrading

    $ bundle update tkh_access_control

Upon upgrading to a new version of the gem this command updates migration and locale files if needed.

		$ rake tkh_access_control:update

Migrate the database if necessary

    $ rake db:migrate


## Usage - AUTHENTICATION


A starting point could be:

    $ /login

... and it should work out of the box.

To display the login information module anywhere in your views

		render 'shared/login_info'

To restrict access to your controllers to logged in users:

		before_action :authenticate, except: 'show'


## Usage - AUTHORIZATION

Ta add a role to a user

    @user.roles << 'role_name'

To add a permission to a role

    @role.permissions << 'permission_name'

To restrict a logged in user's access to your controllers on a permission basis

    before_action -> { require_permission 'permission_name'}, except: [ :show ]


## Contributing

Pull requests for new features and bug fixes are welcome.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Create your failing tests based on the Test Unit framework.
4. Create your code which makes the tests pass.
5. Commit your changes (`git commit -am 'Added some feature'`)
6. Push to the branch (`git push origin my-new-feature`)
7. Create new Pull Request
