require_relative "../../spec_helper"

def cookie_from_response(response=last_response)
  Hash[response.header["Set-Cookie"].lines.map { |line|
    cookie = Rack::Test::Cookie.new(line.chomp)
    [cookie.name, line.chomp]
  }]["foo"]
end

describe "Rack::SecureSiteSiteCookies" do
  include Rack::Test::Methods

  let(:raw_cookie) { "foo=bar" }
  let(:non_chrome_ua) { "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0" }
  let(:chrome_66_and_lower_ua) { "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36" }
  let(:chrome_67_and_above_ua) { "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3945.130 Safari/537.36" }
  let(:app) do
    dummy_app = ->(env) { [200, {"Set-Cookie" => raw_cookie}, "Hello World"] }
    Rack::SecureSiteSiteCookies.new(dummy_app)
  end

  describe "with non-ssl requests and non-chrome user-agents" do
    it "doesn't add secure or samesite attributes" do
      header "User-Agent", non_chrome_ua
      get "/"
      assert_equal cookie_from_response(), raw_cookie
    end
  end

  describe "with ssl requests and non-chrome user-agents" do
    it "adds secure attribute but not samesite attribute" do
      header "User-Agent", non_chrome_ua
      get "/", {}, {'HTTPS' => 'on'}
      assert_equal cookie_from_response(), "#{raw_cookie}; secure"
    end
  end

  describe "with non-ssl requests and chrome <= 66 user-agents" do
    it "does not add secure attribute or samesite attribute" do
      header "User-Agent", chrome_66_and_lower_ua
      get "/"
      assert_equal cookie_from_response(), raw_cookie
    end
  end

  describe "with ssl requests and chrome <= 66 user-agents" do
    it "adds secure attribute but not samesite attribute" do
      header "User-Agent", chrome_66_and_lower_ua
      get "/", {}, {'HTTPS' => 'on'}
      assert_equal cookie_from_response(), "#{raw_cookie}; secure"
    end
  end

  describe "with non-ssl requests and chrome > 66 user-agents" do
    it "does not add secure attribute or samesite attribute" do
      header "User-Agent", chrome_67_and_above_ua
      get "/"
      assert_equal cookie_from_response(), raw_cookie
    end
  end

  describe "with ssl requests and chrome > 66 user-agents" do
    it "adds secure attribute and samesite attribute" do
      header "User-Agent", chrome_67_and_above_ua
      get "/", {}, {'HTTPS' => 'on'}
      assert_equal cookie_from_response(), "#{raw_cookie}; secure; SameSite=None"
    end
  end
end
