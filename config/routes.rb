Uz::Application.routes.draw do
  resources :apps,:only=>[:index] do
    get "recent(/:page)"=>"apps#recent",on: :collection,as: :recent
    get "top(/:page)"=>"apps#top",on: :collection,as: :top
    put "upd", on: :member
  end
  get "/tags(/:page)" => "apps#tags", as: "tags"
  get "/tag/:id(/:page)" => "apps#tag", as: "tag",
      constraints: {id: /[^\/]+/}
  get "/:id"=>"apps#show",:as=>"app_home"
  root :to => 'visitors#new'
end
