# README

①git clone

②docker build -t ruby-node:multi .でコンテナイメージをビルドする

③docker-compose run web rails new . —force —no-deps —database=mysql

 Docker-composeコマンドを使ってrails newを実行し、railsプロジェクトを作成する
Railsが動くサービスにはwebという名前をdocker-compose.ymlでつけたのでコマンドでのコンテナ名としてはwebを当てはめます

④docker-compose run web rails db:create

Rails db:createコマンドをdocker-compose経由で実行してデータベースを作成する

⑤docker-compose run web rails webpacker:install

Rails 6系からは Webpacker が必要となっているため
webコンテナ内に Webpacker をインストール

⑥docker-compose up -d
コンテナを起動


