FROM ruby:2.3.1

EXPOSE 3000

RUN apt-get update && apt-get install -y wget apt-transport-https
RUN wget -qO- https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
RUN echo 'deb https://deb.nodesource.com/node_4.x jessie main' > /etc/apt/sources.list.d/nodesource.list
RUN apt-get update && apt-get install -y nodejs
RUN npm install -g bower

# Allow bower to be executed as root
RUN echo '{ "allow_root": true }' > /root/.bowerrc

WORKDIR /app

# Mostly static backend
COPY config.ru /app/
COPY Rakefile /app/
COPY bin /app/bin
COPY public /app/public
COPY db /app/db

# Mostly static frontend
COPY frontend/ember-cli-build.js /app/frontend/
COPY frontend/public /app/frontend/public
COPY frontend/vendor /app/frontend/vendor

# Gems
COPY Gemfile /app/
COPY Gemfile.lock /app/

RUN bundle install --without development test

# NPM
COPY frontend/package.json /app/frontend/
COPY frontend/bower.json /app/frontend/

# Code backend
COPY config /app/config
COPY app /app/app
COPY lib /app/lib

# Code frontend
COPY frontend/config /app/frontend/config
COPY frontend/app /app/frontend/app

# Assets
RUN RAILS_ENV=production PRECOMPILE=1 bin/rails assets:precompile


CMD ["bin/rails", "s"]
