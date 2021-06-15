Rails.application.routes.draw do
  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }
  
  devise_for :users, controllers: {
    sessions: "public/sessions",
    passwords: "public/passwords",
    registrations: "public/registrations"
  }
  
  namespace :admin do
    root "homes#top"
  end
  
  scope module: :public do
    root "homes#top"
    get "/about" => "homes#about"
  end
  
end
