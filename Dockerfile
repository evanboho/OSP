FROM ruby:2.2.1 

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

# Install Rails App
RUN mkdir /app
WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install
ADD . /app

WORKDIR /app

# ENV 'POSTGRES_PASSWORD=Uee$5b*n#dfg%^BH'

# ENV RAILS_ENV production

# CMD bundle exec rake assets:precompile && foreman start -f Procfile
# CMD bundle exec rails server --port 3000 --binding 0.0.0.0
