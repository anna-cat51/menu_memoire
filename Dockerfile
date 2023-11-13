FROM ruby:3.2.2

# Install PostgreSQL client
RUN apt-get update -qq && apt-get install -y postgresql-client

# Install Node.js, Yarn, and other dependencies
RUN curl -sL https://deb.nodesource.com/setup_19.x | bash -\
  && apt-get update -qq && apt-get install -qq --no-install-recommends \
    nodejs \
  && apt-get upgrade -qq \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*\
  && npm install -g yarn@1

# Install global dependencies
RUN yarn global add esbuild tailwindcss

WORKDIR /menumemoire

COPY Gemfile /menumemoire/Gemfile
COPY Gemfile.lock /menumemoire/Gemfile.lock

EXPOSE 3000

RUN bundle install
RUN gem install nokogiri --version '1.13.9' -- --use-system-libraries=true --with-xml2-include=/usr/include/libxml2 --with-xml2-lib=/usr/lib

# Set environment variables
ENV PATH="/menumemoire/node_modules/.bin:${PATH}"

# Your other configurations and CMD/ENTRYPOINT settings go here