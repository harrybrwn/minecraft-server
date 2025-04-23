# Getting Started

0. Have docker.
1. Install [ferium](https://github.com/gorilla-devs/ferium).

```sh
git clone git@github.com:gorilla-devs/ferium.git
cd ferium
# Important: Build or install without the gui
cargo install --no-default-features --path .
```

2. Install Mods

```sh
ferium add \
  sodium \
  lithium \
  styledplayerlist \
  your-items-are-safe \
  appleskin \
  lmd \
  ferrite-core \
  architectury-api
ferium upgrade
```

3. Run
```sh
./server.sh
```
