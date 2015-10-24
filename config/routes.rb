Rails.application.routes.draw do

  resources :utilities
  resources :codings
  resources :insurers
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'

  root to: 'home#index'

  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get 'test' => 'products#test'
  get 'dashboard' => 'home#dashboard'

  resources :users do
    collection do
      get 'notifications'
      delete 'destroy_multiple'
    end
  end

  resources :insurers do
    collection do
      get '/:id/billing', to: 'insurers#billing', as: 'billing'
    end
  end

  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]

  resources :tariffs do
    collection do
      get 'select'
      post 'select'
      get 'filter'
      post 'filter'
      get 'import'
      post 'import'
      put  'complete'
      post 'export'
      get 'custom'
    end
  end

  resources :risks do
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

  resources :products do
    collection do
      get 'select'
      post 'select'
      get 'filter'
      post 'filter'
      get 'import'
      post 'import'
      put  'complete'
      get 'grid'
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
