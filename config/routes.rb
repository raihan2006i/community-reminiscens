Rails.application.routes.draw do
  apipie
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
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
      resources :sessions do
        resources :slots do
          resources :blocks
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