Rails.application.routes.draw do
  resources :customers do
    get "clear", :on => :collection
    get "upload", :on => :collection
    post "import", :on => :collection
    get "randomize", :on => :collection
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
