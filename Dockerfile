FROM concordconsortium/docker-rails-base-private:ruby-2.3.7-rails-3.2.22.13

ENV APP_HOME /secure_samesite_cookies

RUN mkdir $APP_HOME
COPY . $APP_HOME/
WORKDIR $APP_HOME

RUN bundle install
