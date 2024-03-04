Rails.application.routes.draw do
  resources :tilesets, except: :show
  get  'map_editor', to: 'pages#map_editor'
  root 'pages#home'
end
