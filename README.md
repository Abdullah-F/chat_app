# Chat App

## Installation
In order to get the app running follow the steps listed below:
* Make sure you have [docker](https://docs.docker.com/engine/install/) installed locally on your machine.
* Make sure to have [docker-compose](https://docs.docker.com/compose/install/) installed locally on your machine.
* after dowing the above steps clone the app from this repo.
* after cloning open the terminal, run `cd chat_app`
* after being in the repo directory in your machine run `docker-compose up`
* the app should be running on [http://localhost:5000/](http://localhost:5000/)

## Stack Used in this Demo and the why behind it.
### Stack Used:
* Ruby On Rails for the apis.
* Mysql as the relational storage.
* SideKiq for background processing.
* Elastic search for doing full text search.
* Redis for performance opmization along with Sidekiq.

### Why
For the purpose of this demo I used Redis and Sidekiq to perform queueing for tasks in the back-end
while compared to using queues like RabittMq or SQS and their better persistent for messages I used redis
since this is a demo. Of course queues like fifo queues in this case would be a better choice specially if
another languages or apps are used for handling part of the requests. also they are more reliable than redis.

I wish I could use GOLang, or Elixir for handling the parallel requests because of their great support for 
concurrency, But since I do not have perior expiernce with them and not having time to learn them due to 
my busy scheule I decided to make all requests handled by the ROR api and handled as much as race conditions as possible.

I'm a big fan of GO, Elixir, and Rust so learning them would be a joy as they do complement areas where ruby is not an option in them.
Keep an eye on this repo, as when I learn Go, or Elixir I will be writing a new version of it with them.

### Further Imporvements to the current stack
  Using Go, or Elixir, plush adding a Queue server for communicating with the Go app.
### Further Improvements to the app.
  No serializtion currently done nor pagination. so futher adding draper, active_model_searilazer or any better alternative will an option to provide 
  serilazation out of the box and remove the none DRY current serialzation which is currently fine for the app size.
  Adding authentication and enriching the app with other features would be the next step as needed.

the application is composed of there main entities `subject` which has many `chats` which in turn has many `messages`

## Api end points:
No authentication is made yet in the app so you can try `GET` requests in the browser directy, and use [curl](https://curl.se/docs/manpage.html) for other requests.
* `GET    /subjects` for retriving the subjects from the api (no pagination yet is done in the app)
* `POST   /subjects` for creating subjects, the returned response will be a json object containing the token.
* `POST   /subjects/:subject_token/chats` for creating a chat in a specific topic. The order of the chat will be returned and same applies when creating messages.
* `GET    /subjects/:subject_token/chats/:order` for showing a chat in a subject using its order (its number in the subject it belongs to)
* `DELETE /subjects/:subject_token/chats/:order` for deletig a specific chat.
* `GET    /subjects/:subject_token/chats/:order/search` for searchin for messagins within a chat by body text ( body should be passed as query parameter)
* `POST   /subjects/:subject_token/chats/:chat_order/messages` for creating a message. payload must contain a body for the message.
* `PUT    /subjects/:subject_token/chats/:chat_order/messages/:order` for updating a message in a specific chat.
* `DELETE /subjects/:subject_token/chats/:chat_order/messages/:order`  for deleting a message.

## Testing
Most of the app has tests as most of it was written using TDD.
### Convention within specs
 When adding specs make sure to refer to the chat `subject` as `topic` to elminate the confusion with `rspec`'s `subject` variable. This
 is the current convention we use in this app when writting tests.
### how to run the tests
to run the tests follow the folling steps.
* open a new terminal window from your cloned repo directory.
* make sure to run `docker-compose up -d`
* run `docker container exec -it chat_app_api_1 /bin/bash`
* run `rspec`
* you can do the last two step at once by running this command `docker container exec -it chat_app_api_1 rspec`
 ### Plans for making the tests better
* using the swagger gem for testing apis and generating docs will be a next step.
* no automated tests currently done for load testing the app api for race conditions, so this would an important add on.
* adding testprof gem for keeping anlysis about the app so we can use to enhance tests speed the more we add tests.
* adding more tests coverage to models and areas that do not have tests yet.


