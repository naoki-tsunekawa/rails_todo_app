FROM ruby:2.5
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    node.js \
    postgresql-client \
    yarn

# 作業ディレクトリに移動(無ければ自動で作成します)
WORKDIR /app
#build context内のGemfileとGemfile.lockをコピー
COPY Gemfile Gemfile.lock /app/
#Gemをインストール
RUN bundle install
