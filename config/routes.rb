Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "chat#home"
  get 'chat/home', to: 'chat#home'
  get 'chat/chat', to: 'chat#chat'
end
