group "default" {
    targets = [
        "ferium"
    ]
}

target "ferium" {
    target = "ferium"
    args = {
        RUST_VERSION = "1.86.0"
        PROFILE_NAME = "minecraft-server"
        MINECRAFT_VERSION  = "1.21.5"
        PROFILE_MOD_LOADER = "fabric"
    }
    dockerfile = "Dockerfile"
    tags = [
        "harrybrwn/ferium:latest"
    ]
    platforms = ["linux/amd64"]
}
