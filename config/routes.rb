Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "people#index"
  post 'upload_file'   => 'people#upload_file'
  get 'people' => 'people#index'
end
