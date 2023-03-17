# README

## Quickstart

```
bundle install
bundle exec rails db:create
bundle exec rails db:seed
bundle exec rails s
```

## APIs you could try out

NOTE: The current user is set to the first created user, so when you are creating/destroying stuff, it will be added in relation to the first user.

```

# See all clock ins of a user (you being number #1, of course)
GET api/v1/users/:id/clock_ins

# Create a clock in event
# params clock_in_time [DateTime] clock in datetime
# params clock_out_time [DateTime] clock out datetime
POST api/v1/users/:id/clock_in

# Delete a clock in event
DELETE api/v1/users/:id/clock_in

# Friend/unfriend user
POST api/v1/users/:id/friend
DELETE api/v1/users/:id/unfriend

# See the sleep records over the past week for their friends, ordered by the length of their sleep.
GET api/v1/users/1/sleep_records/

```
