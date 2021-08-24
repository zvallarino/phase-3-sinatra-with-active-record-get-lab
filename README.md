# Sinatra with Active Record: GET Requests Lab

## Learning Goals

- Handle multiple `GET` requests in a controller
- Use the params hash to look up data with Active Record
- Send a JSON response using data from an Active Record model
- Use the `#to_json` method to serialize JSON data

## Setup

In this application, we'll be working on a JSON API to get a list of bakeries
and their baked goods. We have two models, bakeries and baked goods, in a
one-to-many relationship. The migrations are already set up. Here's what the ERD
for these tables looks like:

![Bakeries ERD](https://curriculum-content.s3.amazonaws.com/phase-3/sinatra-with-active-record-get-lab/bakeries-baked_goods-erd.png)

To set up the application, run these commands:

```console
$ bundle install
$ bundle exec rake db:migrate db:seed
```

You can run the app and explore your API in the browser by using the custom Rake
task:

```console
$ bundle exec rake server
```

## Instructions

This is a test-driven lab, so run the tests to get started! You'll be
responsible for building out the associations between the models, and then
working on adding routes to the `ApplicationController` for the different
endpoints described in the test spec.

### Models

Update the `Bakery` and `BakedGood` models to set up the correct associations
based on the structure of the tables. Use the `belongs_to` and `has_many` Active
Record macros.

### Lab Workflow

After setting up your models, it's time to work on your routes! Since
this is your first lab in Sinatra, here's a recommendation on how to
approach writing routes based on the deliverables below.

Let's work on the first deliverable, defining a route that responds to a `GET`
request to `/bakeries` and returns an array of JSON objects for all bakeries in
the database.

Start by running the server with `bundle exec rake server`. Then, in your
browser, visit that endpoint with the server running:
[http://localhost:9292/bakeries](http://localhost:9292/bakeries). You should see
a helpful error message from Sinatra, like this:

![Sinatra error message](https://curriculum-content.s3.amazonaws.com/phase-3/sinatra-with-active-record-get-lab/sinatra-error-message.png)

Start by adding that route to your `ApplicationController`, like Sinatra suggests:

```rb
class ApplicationController
  get '/bakeries' do
    "Hello World"
  end
end
```

Then, refresh the browser. No more error message! Next, write out a bit of
pseudocode. What do we need to do to solve this deliverable?

```rb
class ApplicationController
  get '/bakeries' do
    # get all the bakeries from the database
    # send them back as a JSON array
  end
end
```

Great! Now, we just need to translate that pseudocode into Ruby:

```rb
class ApplicationController
  get '/bakeries' do
    # get all the bakeries from the database
    bakeries = Bakery.all
    # send them back as a JSON array
    bakeries.to_json
  end
end
```

Try refreshing the page now and make sure the response matches what you expect.
Then, run `learn test` and work through the remaining deliverables in a similar
manner.

### Routes

Set up your `ApplicationController` so that the
[default content type][available settings] for responses use the
`Content-Type: application/json` header. Then, define routes that do the
following:

- `GET /bakeries`: returns an array of JSON objects for all bakeries in the database.
- `GET /bakeries/:id`: returns a single bakery as JSON with its baked goods
  nested in an array. Use the `id` from the URL to look up the correct bakery.
  (**HINT**: you'll need to pass in some custom options to the
  [`#to_json`][as_json] method.)
- `GET /baked_goods/by_price`: returns an array of baked goods as JSON, sorted
  by price in descending order. (**HINT**: how can you use Active Record to sort
  the baked goods in a particular order?)
- `GET /baked_goods/most_expensive`: returns the single most expensive baked
  good as JSON. (**HINT**: how can you use Active Record to sort the baked goods
  in a particular order?)

## Resources

- [Sinatra Routes](https://rubydoc.info/gems/sinatra#routes)
- [Active Record Query Interface](https://guides.rubyonrails.org/active_record_querying.html)
- [Active Model `#as_json` method][as_json]

[available settings]: https://msp-greg.github.io/sinatra/file.README.html#available-settings
[as_json]: https://api.rubyonrails.org/classes/ActiveModel/Serializers/JSON.html#method-i-as_json
