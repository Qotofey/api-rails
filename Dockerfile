FROM ruby:2.5.1

WORKDIR /api-rails
COPY . /api-rails

RUN bundle install

EXPOSE 3000

CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]