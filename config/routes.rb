require "resque_web"



Rails.application.routes.draw do

  class AuthenticatedSuperUserConstraint
    def self.matches?(request)
      #puts request.session.fetch(:super_user, false)
      request.session.fetch(:super_user, false)
    end
  end

  get 'comments/chapter/:chapter_id' => 'comments#index',  as: :comments
  get 'comments/:id' => 'comments#show',  as: :comment
  post 'comments/' => 'comments#add', as: :add_comment
  delete 'comments/' => 'comments#remove', as: :remove_comment
  put 'comments/flag' => 'comments#flag', as: :flag_comment

  get '/auth/google'
  get '/auth/:provider/callback', to: 'account#callback'

  post 'votes' => 'votes#create', as: :vote_for_action

  get 'votes/destroy'

  post 'story/set' => 'story#set_current_story_id', as: :set_current_story
  get 'story/set/:story' => 'story#set_current_story_id', as: :set_current_story_by_id

  get 'story/read/:story'=> 'story#set_current_story_id', as: :read_current_story
  get 'story/choose' => 'story#choose', as: :choose_story
  get 'story/chapter/:number'  => 'story#chapter', as: :read_chapter
  get 'story/:story/chapter/:number'  => 'story#story_chapter', as: :read_story_chapter
  get 'story/:story/latest'  => 'story#latest', as: :read_latest_chapter

  get 'story' => 'story#index', as: :story
  get 'story/about' => 'story#about', as: :about_story

  mount Ckeditor::Engine => '/ckeditor'

  namespace :account do
    get 'subscriptions' => 'subscriptions#index', as: :subscriptions
    get 'subscriptions/available' => 'subscriptions#available', as: :available_stories
    post 'subscriptions' => 'subscriptions#add', as: :add_subscription
    post 'subscriptions/:id' => 'subscriptions#update', as: :update_subscription
    delete 'subscriptions' => 'subscriptions#remove', as: :remove_subscription
  end

  get '/account' => 'account#index', as: :account
  get '/account/profile' => 'account#profile', as: :profile
  put '/account/profile' => 'account#update_profile', as: :update_profile
  get '/login' => 'account#login', as: :login
  post '/login' => 'account#process_login', as: :process_login
  get '/logout' => 'account#logout', as: :logout

  namespace :manage do
      get '' => 'home#index', as: :bashboard

    post 'subscribers/promote' => 'subscribers#promote', as: :promote
    post 'subscribers/relegate' => 'subscribers#relegate', as: :relegate

    resources :comments
    resources :invites
    resources :users
    resources :stories do
      collection do
        get :all
      end
      member do
        get :subscribers
        get :invitations
        post 'invitations' => 'stories#send_invitations', as: :send_invitations
      end

      resources :chapters

    end
  end

  get '/about' => 'home#about'
  root 'home#index'

  constraints(AuthenticatedSuperUserConstraint) do
    mount ResqueWeb::Engine => "/system/resque"
  end

end
