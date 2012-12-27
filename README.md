AuthN
-----

authn is a simplistic and barebones authentication library.
It only does a few things for you, such as:

  * Give you a controller and helper method to access the "current user"
  * Give you simple "sign in", "sign out", and "auto sign in" methods
  * Works with any ORM that behaves likes ActiveModel
  * Functions with any framework that has a session interface

In addition you can bring in other behavior sets like:

  * authn-activation: Account activation
  * authn-protection: Failed login protection
  * authn-recovery: Password recovery
  * authn-rails: Extend Rails with AuthN



Using AuthN
===========

**The Model**

In order to use AuthN in your model you'll only need to follow a few steps:

  * ActiveModel's SecurePassword requires the model have an accessor called `password_digest`. (See schema below, for the ActiveRecord version)
  * The `AuthN::Model` module will need to be included into the model. (See codeblock below)
  * The singleton method `has_authentication` will need to be called.
  * The singleton method `has_secure_password` will need to be called.

That's it!
Now for those fun code examples:

``` ruby
# create_table :accounts do |t|
#   t.string :email
#   t.binary :password_digest
#
#   t.timestamps
# end
# add_index :accounts, :email
#

class Account < ActiveRecord::Base
  include AuthN::Model

  has_authentication
  has_secure_password

  validates :email, uniqueness: true, presence: true, length: 5..255
  validates :password, length: 10..1024

  attr_accessible :email
end
```

See?
No muss, no fuss.
Of course authn does (and will) provide extras, like activation or rails integration.
You'll need to read those repositories for more information.
Here's a taste of what a "fully loaded" model looks like:

``` ruby
# create_table :accounts do |t|
#   t.string :email
#   t.binary :password_digest
#
#   t.string :activation_token
#   t.boolean :activation_state, default: false
#   t.datetime :activation_expires_at
#
#   t.string :password_recovery_token
#   t.datetime :password_recovery_expires_at
#
#   t.string :login_protection_token
#   t.datetime :login_protection_expires_at
#   t.integer :login_protection_attempts, default: 0
#
#   t.timestamps
# end
# add_index :accounts, :email
# add_index :accounts, :activation_token
# add_index :accounts, :activation_state
# add_index :accounts, :password_recovery_token
# add_index :accounts, :login_protection_token
#

class Account < ActiveRecord::Base
  include AuthN::Model

  has_authentication
  has_password_recovery mailer: "PasswordRecoveryMailer"
  has_activation mailer: "ActivationMailer", on_create_send: false
  has_login_protection maximum: 3
  has_secure_password

  validates :email, uniqueness: true, presence: true, length: 5..255
  validates :password, length: 10..1024

  attr_accessible :email
end
```

You'll notice that each singleton method can take some options passed to it in the form of a Hash (or similar).
These options *supercede* the global config options given by your AuthN config.
Those options supercede the default config in the gem.


**The Controller**

Inside your controllers you have access to these methods:

  * `login email: "jpublic@mail.com", password: "12341234"`, for logging accounts in if the creds match
  * `auto_login Account.find(23)`, for automatically logging in a certain account
  * `logged_in?` for checking if there's a current user
  * `current_user` which returns the current user instance
  * `require_login`, which redirects to the `unauthorized` action if the user isn't logged in
  * `logout`, for logging out of the current user

For more information, check the [wiki](/wiki)

Installing AuthN
================

Add this line to your application's Gemfile:

    gem 'authn'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install authn

Looking for instructions on how to setup with Rails?
Find them over [here](https://github.com/krainboltgreene/authn-rails)


Contributing
============

  1. Fork it
  2. Create your feature branch (`git checkout -b my-new-feature`)
  3. Commit your changes (`git commit -am 'Add some feature'`)
  4. Push to the branch (`git push origin my-new-feature`)
  5. Create new Pull Request

License
=======

    Copyright (c) 2012 Kurtis Rainbolt-Greene

    MIT License

    Permission is hereby granted, free of charge, to any person obtaining
    a copy of this software and associated documentation files (the
    "Software"), to deal in the Software without restriction, including
    without limitation the rights to use, copy, modify, merge, publish,
    distribute, sublicense, and/or sell copies of the Software, and to
    permit persons to whom the Software is furnished to do so, subject to
    the following conditions:

    The above copyright notice and this permission notice shall be
    included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
    NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
    LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
    OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
    WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
