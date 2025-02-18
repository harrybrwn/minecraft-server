#!/bin/bash

set -eu

mkdir -p /opt/minecraft-server

PORT=25565
MOTD="you fucking donkey"
DIFFICULTY="normal" # peaceful | easy | normal | hard
WHITELIST=TheLoNgTeApoT,dzhek,SoggyMemelord420,willy_b13,yungborg
OPS=TheLoNgTeApoT
VERSION='1.21.4'
SEED='-5584399987456711267'
ICON="/opt/misc/donkey.png"
TYPE=FABRIC
DATA='/opt/minecraft-server'

# Mods
# https://www.curseforge.com/minecraft/mc-mods/styled-player-list
# https://www.curseforge.com/minecraft/mc-mods/clumps
# https://www.curseforge.com/minecraft/mc-mods/gravestone-mod
# https://www.curseforge.com/minecraft/mc-mods/xaeros-minimap
# https://www.curseforge.com/minecraft/mc-mods/xaeros-world-map

mkdir -p mods
if [ ! -f mods/fabric-api.jar ]; then
  curl \
    "https://mediafilez.forgecdn.net/files/6196/247/fabric-api-0.117.0%2B${VERSION}.jar" \
    -o mods/fabric-api.jar
fi
if [ ! -f mods/lithium-neoforge.jar ]; then
  curl \
    "https://mediafilez.forgecdn.net/files/6108/93/lithium-neoforge-0.14.7%2Bmc${VERSION}.jar" \
    -o mods/lithium-neoforge.jar
fi
if [ ! -f mods/styledplayerlist.jar ]; then
  curl \
    "https://mediafilez.forgecdn.net/files/5825/477/styledplayerlist-3.6.0%2B1.21.2.jar" \
    -o mods/styledplayerlist.jar
fi
if [ ! -f mods/gravestone.jar ]; then
  curl \
    "https://mediafilez.forgecdn.net/files/5959/722/gravestone-neoforge-${VERSION}-1.0.24.jar" \
    -o mods/gravestone.jar
fi
#if [ ! -f mods/Xaeros_Minimap.jar ]; then
#  curl \
#    'https://mediafilez.forgecdn.net/files/6184/473/Xaeros_Minimap_25.1.0_Fabric_1.21.4.jar' \
#    -o mods/Xaeros_Minimap.jar
#fi
#if [ ! -f mods/XaerosWorldMap.jar ]; then
#  curl \
#    'https://mediafilez.forgecdn.net/files/6142/446/XaerosWorldMap_1.39.3_Fabric_1.21.4.jar' \
#    -o mods/XaerosWorldMap.jar
#fi

docker container run \
  --detach           \
  --restart always   \
  -p "25565:${PORT}" \
  --volume "/etc/timezone:/etc/timezone:ro" \
  --volume "${DATA}:/data"         \
  --volume "$(pwd)/worlds:/worlds" \
  --volume "$(pwd)/mods:/mods"     \
  --volume "$(pwd)/misc:/opt/misc" \
  --name minecraft                 \
  -e EULA=TRUE                     \
  -e MEMORY=10G                    \
  -e TYPE="${TYPE}"                \
  -e VERSION="${VERSION}"          \
  -e SERVER_NAME="ass munchers"    \
  -e MOTD="${MOTD}"                \
  -e SEED="${SEED:-}"              \
  -e DIFFICULTY="${DIFFICULTY}"    \
  -e MODE=survival                 \
  -e PVP=true                      \
  -e HARDCORE=false                \
  -e SPAWN_PROTECTION=16           \
  -e ENABLE_COMMAND_BLOCK=false    \
  -e WHITELIST="$WHITELIST"        \
  -e OPS="${OPS}"                  \
  -e VIEW_DISTANCE=18              \
  -e ICON="${ICON}"                \
  -e OVERRIDE_ICON=true            \
  -e USE_SIMD_FLAGS=true           \
  itzg/minecraft-server:latest

echo "Server started."
docker container logs -f minecraft
