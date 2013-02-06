Rails.application.routes.draw do
  resources :issues, :only => :index do
    get :archived, :on => :collection
  end
  scope 'admin' do
    resources :issues, :controller => :admin_issues do
      get :index, :on => :collection, :as => :admin
    end
    resources :updates, :controller => :admin_updates
  end
  resource :status, :only => :show
  root :to => 'issues#index'
end
