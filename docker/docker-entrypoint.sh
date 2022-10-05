#!/bin/bash
set -e

if [ "$1" = 'api' ]
then
    if [ -f tmp/pids/server.pid ]; then
        rm tmp/pids/server.pid
    fi
    bundle check || bundle install
    bin/rails db:migrate 2>/dev/null || bin/rails db:setup
    
    if [[ "$RAILS_ENV" == 'production' ]]; then
        echo 'Start production server'
    fi
    
    bundle exec rails s -b 0.0.0.0
elif [ "$1" = 'worker' ]
then
    bundle check || bundle install
    echo "Start worker"
    while true
    do
        echo "Add worker stating command here"
        sleep 10
    done
else
    echo "Invalid argument send to docker-entrypoint.sh"
    exit 0
fi

exec "$@"