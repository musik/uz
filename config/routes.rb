Uz::Application.routes.draw do
  resources :apps,:except=>[:show] do
    get "top",on: :collection
    get "recent",on: :collection
    put "upd", on: :member
  end
  get "/tag/:id" => "apps#tag", as: "tag"
  get "/:id"=>"apps#show",:as=>"app_home"
  root :to => 'visitors#new'
end
