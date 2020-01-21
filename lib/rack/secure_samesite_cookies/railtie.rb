module Rack
  class SecureSamesiteCookies
    class Railtie < ::Rails::Railtie
      initializer "rack-secure_samesite_cookies.configure_rails_initialization" do |app|
        app.config.middleware.insert_after(ActionDispatch::Static, Rack::SecureSiteSiteCookies)
      end
    end
  end
end
