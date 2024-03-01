Rails.application.routes.draw do
  get  'map_editor', to: 'pages#map_editor'
  root 'pages#home'
  if Rails.env.development?
    redirector = ->(params, _) { ApplicationController.helpers.asset_path("#{params[:name].split('-').first}.map") }
    constraint = ->(request) { request.path.ends_with?(".map") }
    get "assets/*name", to: redirect(redirector), constraints: constraint

    get '*file.map', to: redirect('/assets/%{file}.map')
  end
end
