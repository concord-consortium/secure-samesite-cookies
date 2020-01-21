require "rack/secure_samesite_cookies/version"
require 'rack/secure_samesite_cookies/railtie' if defined?(Rails::Railtie)

module Rack
  class SecureSiteSiteCookies

    COOKIE_SEPARATOR = "\n".freeze

    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, body = @app.call(env)

      if headers.key?('Set-Cookie')
        cookies = headers['Set-Cookie'].split(COOKIE_SEPARATOR)

        # set secure flag if this is https request
        add_secure = Rack::Request.new(env).ssl?

        # add SiteSite attribute only for Chrome for now
        add_same_site = !!(env["HTTP_USER_AGENT"] =~ /\schrome\//i)

        cookies.each do |cookie|
          # can't use .present? as we aren't running in rails in tests
          next if cookie.empty? || (cookie.gsub(/\s/, "").length == 0)
          if add_secure && cookie !~ /;\s*secure/i
            cookie << '; secure'
          end
          if add_same_site && cookie !~ /;\ssamesite/i
            cookie << '; SameSite=None'
          end
        end

        headers['Set-Cookie'] = cookies.join(COOKIE_SEPARATOR)
      end

      [status, headers, body]
    end
  end
end

