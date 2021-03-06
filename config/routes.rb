Rails.application.routes.draw do
  get 'pages/client'

  apipie
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      namespace :kb do
        resources :questions, except: [:index, :show, :new, :create, :edit, :update, :destroy] do
          collection do
            get :search
          end
        end
        resources :multimedia, except: [:index, :show, :new, :create, :edit, :update, :destroy] do
          collection do
            get :local_search
            get :thirdparty_search
          end
        end
      end
      resources :caregivers do
        collection do
          post :authorize
        end
      end
      resources :groups do
        member do
          get :guests
        end
      end
      resources :guests
      resources :stories do
        resources :comments
        resources :story_fragments
        resources :story_attachments
      end
      resources :contexts
      resources :themes
      resources :session_histories
      resources :sessions do
        member do
          post :start
        end
        resources :slots do
          resources :blocks do
            member do
              post :live
            end
          end
        end
      end
    end
  end

  scope ':locale', locale: I18n.locale do
    ActiveAdmin.routes(self)
    namespace :admin do
      resources :stories do
        resources :story_fragments
        resources :comments
        resources :attachments
      end
    end
  end

  root to: redirect('/apidoc/1.en.html')
end