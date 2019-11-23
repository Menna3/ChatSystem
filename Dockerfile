FROM ruby:2.3.3
COPY . /application
WORKDIR /application

ENV RAILS_ENV production

COPY Gemfile Gemfile.lock ./
ENV BUNDLER_VERSION 2.0.2
RUN gem install bundler -v 2.0.2 && bundle install --jobs 20 --retry 5

RUN bundle lock --add-platform ruby \
    && bundle lock --add-platform x86_64-linux \
    && bundle install --deployment --without development test

    
CMD ["rails","server","-b","0.0.0.0"]