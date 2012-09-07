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
  * rails-authn: Extend Rails with AuthN



Using AuthN
===========

To start using authn you simply need to install and hook up to your existing "user" model:

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
Now what about all those addons?
We'll you can see their own pages, but here's a taste:

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
  has_activation mailer: "ActivationMailer", on_create: false
  has_login_protection maximum: 3, redirect: { controller: :accounts, action: :maximum_login_failure }
  has_secure_password

  validates :email, uniqueness: true, presence: true, length: 5..255
  validates :password, length: 10..1024

  attr_accessible :email
end
```

You'll notice that there are options after some of the addon singleton methods.
These are used to overwrite the global configuration.
authn assumes quite a few things, but never stops you from changing how it works.
As above you can change how each of your "user" models functions (for say admin recovery emails vs support recovery emails).
In addition you can either programatically write the "global" configuration or have a `authn.yml` file ready to be loaded.

Installing AuthN
================

Add this line to your application's Gemfile:

    gem 'authn'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install authn

Looking for instructions on how to setup with Rails?
Find them over [here](https://github.com/krainboltgreene/rails-authn)


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
