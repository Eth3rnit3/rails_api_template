#!/usr/bin/env sh

set -e

if [ -f tmp/pids/server.pid ]; then
    rm tmp/pids/server.pid
fi

bundle exec rake db:migrate 2>/dev/null || bundle exec rake db:setup

if [[ "$RAILS_ENV" == 'production' ]]; then
    echo 'Start production server'
fi

bundle exec rails s -b 0.0.0.0