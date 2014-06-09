## Redis Session Store

This gem implements a SessionStore that stores serialised session data in Redis.

### Usage

#### Initialization

```ruby
# config/initializers/session_store.rb
AwesomeApp::Application.config.session_store :redis_store,
  connection: Redis.new,
  expire_after: 2.weeks
```

## TODO

* add tests for more win
