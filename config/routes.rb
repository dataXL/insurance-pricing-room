Rails.application.routes.draw do

  get 'sessions/new'

  root to: 'home#index'

  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get 'test' => 'products#test'
  get 'dashboard' => 'home#dashboard'
  resources :users

  resources :products do
    collection do
      get 'select'
      post 'select'
      get 'filter'
      post 'filter'
      get 'import'
      post 'import'
      put  'complete'
    end
  end

  resources :lists do
    collection do
      get 'users'
      get 'datatables'
      get 'products'
    end
  end

  resources :reports do
    collection do
      get 'orders'
      get 'sales'
    end
  end

  resources :forms do
    collection do
      get 'new_customer'
      get 'new_product'
      get 'wizard'
    end
  end

  resources :pages do
    collection do
      get 'inbox'
      get 'profile'
      get 'latest_activity'
      get 'projects'
      get 'steps'
      get 'calendar'
    end
  end

  resources :pricing do
    collection do
      get 'plans'
      get 'charts'
      get 'form'
      get 'invoice'
    end
  end

  resources :features do
    collection do
      get 'email_templates'
      get 'gallery'
      get 'ui'
      get 'api'
      get 'signup'
      get 'signin'
      get 'status'
    end
  end

  resources :account do
    collection do
      get 'settings'
      get 'billing'
      get 'notifications'
      get 'support'
    end
  end
end
