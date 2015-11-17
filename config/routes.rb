Rails.application.routes.draw do

  resources :brokers
  resources :quotes
  devise_for :users, :controllers => { :confirmations => 'confirmations', :registrations => 'registrations' }

  devise_scope :user do
    root to: "home#dashboard"
    patch "/confirm" => "confirmations#confirm"
  end

  resources :coefficients do
    collection do
      get 'select'
      post 'select'
      get 'filter'
      post 'filter'
      get 'import'
      post 'import'
      post 'update_async'
    end
  end

  resources :users

  resources :surveys do
    collection do
      get 'select'
      post 'select'
      get 'filter'
      post 'filter'
      get 'import'
      post 'import'
    end
  end

  resources :product_templates do
    collection do
      get 'build'
      post 'build'
      get 'save'
      post 'save'
    end
  end

  resources :products do
    collection do
      get 'grid'
      post 'add_multiple'
    end
  end

  resources :utilities
  resources :codings
  resources :insurers

  get 'dashboard' => 'home#dashboard'

  resources :insurers do
    collection do
      get '/:id/billing', to: 'insurers#billing', as: 'billing'
    end
  end

  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]

  resources :tariffs do
    collection do
      match 'select', via: [:get, :post]
      match 'map', via: [:get, :post]
      match 'import', via: [:get, :post]

      post 'export'
    end
  end

  resources :risks do
    collection do
      match 'select', via: [:get, :post]
      match 'map', via: [:get, :post]
      match 'import', via: [:get, :post]

      put  'complete'
    end
  end

  resources :competitors do
    collection do
      match 'select', via: [:get, :post]
      match 'map', via: [:get, :post]
      match 'import', via: [:get, :post]

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
