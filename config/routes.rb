Rails.application.routes.draw do
  
  #Auth Endpoints
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
    
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
  
end
