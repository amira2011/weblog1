Rails.application.routes.draw do
  devise_for :users
  get 'wlogs/home'
  get 'wlogs/index'
  root 'wlogs#index'
  get 'wlogs/RT'

  resources :wlogs do
    collection { post :import1 }
    collection { post :import2 }

    collection { post :RT }
  end

  resources :charts, only: [] do
  collection do
    get 'server_throughput'
    get 'completed_tasks'
    get 'average_RT'
    get 'error_rate'
    get 'method_RT'
   

  end
end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
