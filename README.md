# Apiarist

Apiarist is an opinionated [ActiveModel::Serializers](https://github.com/rails-api/active_model_serializers) alternative

## Why?

* Built on the top of [inherited_resources](https://github.com/josevalim/inherited_resources). Creating an API is as easy as defining your resource representations.
* Serializers inherit controller's namespace making it easier to version and maintain your API.
* Serialization scopes: allows you to define different representations of the same resource.

## Installation

Add this line to your application's Gemfile:

    gem 'apiarist'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install apiarist

## Usage

~~~ruby
# app/controllers/api/v1/products_controller.rb
class Api::V1::Products < Apiarist::ResourceController::Base
  actions :index, :show
  belongs_to :category

  serialization_scope :basic, only: :index
  serialization_scope :extended, only: :show
end

# app/serializers/api/v1/category_serializer.rb
class Api::V1::CategorySerializer < Apiarist::Serializer
  attributes :id, :name
end

# app/serializers/api/v1/product_serializer.rb
class Api::V1::ProductSerializer < Apiarist::Serializer
  attributes :id, :name, :description

  scope :basic do
    attribute :category_name
  end

  scope :extended do
    association :category
  end

  def category_name
    category.name
  end
end
~~~

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/knoopx/apiarist/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

