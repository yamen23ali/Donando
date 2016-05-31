FROM ruby:2.2.1

# Install dependencies:
# - build-essential: To ensure certain gems can be compiled
# - nodejs: Compile assets
# - libpq-dev: Communicate with postgres through the postgres gem
# - postgresql-client-9.4: In case you want to talk directly to postgres
RUN apt-get update && apt-get install -qq -y build-essential nodejs libpq-dev postgresql-client-9.4 --fix-missing --no-install-recommends

# Install Zalando CA
RUN apt-get update && apt-get -qy install curl && \
    curl https://static.zalando.de/ca/zalando-service.ca > /usr/local/share/ca-certificates/zalando-service.crt && \
    curl https://static.zalando.de/ca/zalando-root.ca > /usr/local/share/ca-certificates/zalando-root.crt && \
    update-ca-certificates

# create app folder and change permission
RUN mkdir /donando
WORKDIR /donando

# Copy in the application code from your work station at the current directory
# over to the working directory.
ADD . /donando

# install gems
RUN bundle install

# chamge permission
RUN chmod -R 777 /donando

# Start rails and sidkiq
CMD ["sh","start_up.sh"]
