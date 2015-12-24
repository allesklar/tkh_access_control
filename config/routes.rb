Rails.application.routes.draw do

  unless  Gem::Specification::find_all_by_name('route_translator').any?

    # normal translation scoping
    scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
      ##### ACCESS CONTROL
      # legacy routes. Pointing to new pathway. Keep them. They are semantically sound.
      # still used in this gem.
      get 'signup', to: 'reception#email_input', as: 'signup'
      get 'login', to: 'reception#email_input', as: 'login'
      get 'logout', to: 'reception#disconnect', as: 'logout'
      # New access control pathway
      get '/reception', to: 'reception#email_input', as: 'email_input'
      post '/parse_email', to: 'reception#parse_email'
      get '/email_validation', to: 'reception#email_validation'
      get '/create_your_password', to: 'reception#create_your_password'
      post '/password_creation/:id', to: 'reception#password_creation', as: 'password_creation'
      get '/enter_your_password', to: 'reception#enter_your_password'
      post '/password_checking/:id', to: 'reception#password_checking', as: 'password_checking'
      get '/i_forgot_my_password', to: 'reception#i_forgot_my_password'
      post '/request_new_password', to: 'reception#request_new_password'
      get '/change_your_password', to: 'reception#change_your_password'
      post '/password_reset/:id', to: 'reception#password_reset', as: 'password_reset'
      get '/disconnect', to: 'reception#disconnect'
    end

  else # special routing for localized routes via the route_translator gem

    localized do
      ##### ACCESS CONTROL
      # legacy routes. Pointing to new pathway. Keep them. They are semantically sound.
      # still used in this gem.
      get 'signup', to: 'reception#email_input', as: 'signup'
      get 'login', to: 'reception#email_input', as: 'login'
      get 'logout', to: 'reception#disconnect', as: 'logout'
      # New access control pathway
      get '/reception', to: 'reception#email_input', as: 'email_input'
      post '/parse_email', to: 'reception#parse_email'
      get '/email_validation', to: 'reception#email_validation'
      get '/create_your_password', to: 'reception#create_your_password'
      post '/password_creation/:id', to: 'reception#password_creation', as: 'password_creation'
      get '/enter_your_password', to: 'reception#enter_your_password'
      post '/password_checking/:id', to: 'reception#password_checking', as: 'password_checking'
      get '/i_forgot_my_password', to: 'reception#i_forgot_my_password'
      post '/request_new_password', to: 'reception#request_new_password'
      get '/change_your_password', to: 'reception#change_your_password'
      post '/password_reset/:id', to: 'reception#password_reset', as: 'password_reset'
      get '/disconnect', to: 'reception#disconnect'
    end

  end

end
