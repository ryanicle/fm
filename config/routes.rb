Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      post 'friends/add' => 'friends#add', as: :request_friend
      get 'friends/list' => 'friends#list', as: :find_friends
      get 'friends/common' => 'friends#common', as: :find_common_friends
      post 'friends/subscribe' => 'friends#subscribe', as: :subscribe_friend
      put 'friends/unsubscribe' => 'friends#unsubscribe', as: :unsubscribe_friend
      get 'friends/updates' => 'friends#updates', as: :receive_updates
    end
  end
end
