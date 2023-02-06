FROM node:12.4-stretch as node

FROM ruby:2.7.5

# Install Node.js and Yarn
ENV YARN_VERSION 1.16.0
RUN mkdir -p /opt
COPY --from=node /opt/yarn-v$YARN_VERSION /opt/yarn
COPY --from=node /usr/local/bin/node /usr/local/bin/
COPY --from=node /usr/local/lib/node_modules/ /usr/local/lib/node_modules/
RUN ln -s /opt/yarn/bin/yarn /usr/local/bin/yarn \
  && ln -s /opt/yarn/bin/yarn /usr/local/bin/yarnpkg \
  && ln -s /usr/local/bin/node /usr/local/bin/nodejs \
  && ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm \
  && ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npx
RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle update --bundler
RUN gem install bundler:1.17.2
RUN bundle install
COPY . /myapp
RUN bundle exec rails webpacker:install

# コンテナ起動時に実行させるスクリプトを追加
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Rails サーバ起動
CMD ["rails", "server", "-b", "0.0.0.0"]