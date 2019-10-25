#!/usr/bin/env bash

# Install services
SERVICES=(
  mysql@5.5
  postgresql@10
  redis
)

LIST=""
for SERVICE in "${SERVICES[@]}"
do
  LIST="brew \"$SERVICE\", restart_service: :changed, link: true\\n$LIST"
done

echo -e "$LIST" | brew bundle --file=/dev/stdin 
