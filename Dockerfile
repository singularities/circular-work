FROM ruby:2.3.1

EXPOSE 3000

WORKDIR /app

# Mostly static
COPY config.ru /app/
COPY Rakefile /app/
COPY bin /app/bin
COPY public /app/public
COPY db /app/db
COPY clock.rb /app/

# Gems
COPY Gemfile /app/
COPY Gemfile.lock /app/

RUN bundle install --without development test

# Code
COPY config /app/config
COPY app /app/app
COPY lib /app/lib

# Assets
# This steps needs to precompile assets before:
#   RAILS_ENV=production PRECOMPILE=1 bin/rails assets:precompile 
COPY tmp/ember-cli /app/tmp/ember-cli


CMD ["bin/rails", "s"]
