#!/bin/bash

set -eu

DIR="${1:-/opt/minecraft-server}"
mkdir -p "${DIR}"

PORT=25565
MOTD="you fucking donkey"
DIFFICULTY="normal" # peaceful | easy | normal | hard
WHITELIST=TheLoNgTeApoT,dzhek,SoggyMemelord420,willy_b13,yungborg
OPS=TheLoNgTeApoT
VERSION='1.21.5'
SEED='-5584399987456711267'
#ICON="/opt/misc/donkey.png"
ICON="${DIR}/donkey.png"
TYPE=FABRIC
DATA="${DIR}"
SERVER_NAME='ass munchers'

docker container stop minecraft
docker container rm minecraft

docker container run                        \
  --detach                                  \
  --restart always                          \
  -p "25565:${PORT}"                        \
  --volume "/etc/timezone:/etc/timezone:ro" \
  --volume "${DATA}:/data"                  \
  --volume "$(pwd)/worlds:/worlds"          \
  --volume "$(pwd)/mods:/mods:ro"           \
  --volume "$(pwd)/misc:/opt/misc:ro"       \
  --name minecraft                          \
  -e EULA=TRUE                              \
  -e MEMORY=10G                             \
  -e TYPE="${TYPE}"                         \
  -e VERSION="${VERSION}"                   \
  -e SERVER_NAME="${SERVER_NAME}"           \
  -e MOTD="${MOTD}"                         \
  -e SEED="${SEED:-}"                       \
  -e DIFFICULTY="${DIFFICULTY}"             \
  -e MODE=survival                          \
  -e PVP=true                               \
  -e HARDCORE=false                         \
  -e SPAWN_PROTECTION=16                    \
  -e ENABLE_COMMAND_BLOCK=false             \
  -e WHITELIST="$WHITELIST"                 \
  -e OPS="${OPS}"                           \
  -e VIEW_DISTANCE=18                       \
  -e ICON="${ICON}"                         \
  -e OVERRIDE_ICON=true                     \
  -e USE_SIMD_FLAGS=true                    \
  itzg/minecraft-server:latest

echo "Server started."
docker container logs -f minecraft
