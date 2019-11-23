# ChatSystem

This is Ruby on Rails API allows authenticated users to create new applications.

* Each application has a token(generated by the system); which is the identifier that devices use to send chats to that
 application, and a name(provided by the client). 

* Each application can have many chats, 
and each chat has a number which is returned in 
the creation request.

* A chat contains messages,
and each message has a number which is returned in 
the creation request. 


## Ruby version
Ruby 2.3.3, Rails 5.1.7


## System dependencies
```
gem 'redis', '~> 3.3', '>= 3.3.3'
gem 'sidekiq', '~> 5.2', '= 5.2.3'
gem 'sidekiq-cron'
gem 'elasticsearch-model'
gem 'elasticsearch-rails'
```

## How to run the docker image
[Install docker](https://docs.docker.com/install/)
```
git clone https://github.com/Menna3/ChatSystem.git
docker build -t chatsystem
 ```
 
 ## Get Authenticated
 
 ### Sign up
 
 Go to route:
 ```
POST /signup
```
Request Body Example:
```
{
   "name": "menna",
   "email": "asd@asdf.com",
   "password": "12345",
   "password_confirmation": "12345"
}
```
Then a token will be returned.
Use it in the header while requesting any other endpoint in the app.

### Login

Go to route:
 ```
POST /auth/login
```
Request Body Example:
```
{
   "email": "asd@asdf.com",
   "password": "12345"
}
```

## Create an Application

### Request

 ```
POST /applications
```
Request Body Example:
```
{
   "app_name": "My first app"
}
```

### Response

```
A generated token
```

## Create a Chat

### Request
 ```
POST /applications/:app_token/chats
```
Request Body Example:
```
{
   "chat_name": "My first chat"
}
```

### Response

```
Chat number
```

## Create a Message

### Request

 ```
POST /applications/:app_token/chats/:chat_number/messages
```
Request Body Example:
```
{
   "message_body": "My first message"
}
```

### Response

```
Message number
```

## All Endpoints

```
  #Applications Endpoints
  get 'applications', to: 'applications#index'
  post 'applications', to: 'applications#create'
  get 'applications/:token', to: 'applications#show'
  put 'applications/:token', to: 'applications#update'
  delete 'applications/:token', to: 'applications#destroy'
  
  #Chats Endpoints
  get 'applications/:token/chats', to: 'chats#index'
  post 'applications/:token/chats', to: 'chats#create'
  get 'applications/:token/chats/:chat_number', to: 'chats#show'
  put 'applications/:token/chats/:chat_number', to: 'chats#update'
  delete 'applications/:token/chats/:chat_number', to: 'chats#destroy'
    
  #Messages Endpoints
  get 'applications/:token/chats/:chat_number/messages', to: 'chat_messages#index'
  post 'applications/:token/chats/:chat_number/messages', to: 'chat_messages#create'
  get 'applications/:token/chats/:chat_number/messages/:message_number', to: 'chat_messages#show'
  put 'applications/:token/chats/:chat_number/messages/:message_number', to: 'chat_messages#update'
  delete 'applications/:token/chats/:chat_number/messages/:message_number', to: 'chat_messages#destroy'
  get 'search', to: 'chat_messages#search'
```

## Search Messages

You can search through messages of a specific chat 
and partially match messages’ bodies.

This is achieved using Elasticsearch with 2 indices, 
one for the `message_body` and the other for the `chat_id`.

```
GET /search?chat_id=id&query=msg
```

## Job queues

Two jobs for the chat and message creation were done in order to handle race conditions and to minimize the queries 
and avoid writing directly to MySQL while serving the 
requests, and use REDIS-SERVER to store temporarily.

ActiveJob `perform_later` was used to enqueue a job to be 
performed as soon as the queuing system is free.

## CronJob

And using Sidekiq-cron, a cronjob is scheduled every hour 
to count and persist column `chats_number` in the applications 
table, and the `messages_number` in the chats table. 

