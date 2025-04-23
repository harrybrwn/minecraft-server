UID=$(shell id -u)
GID=$(shell id -g)

.PHONY: mods
mods:
	docker compose run --rm ferium ferium upgrade
	docker compose run --rm ferium chown -R $(UID):$(GID) /opt/mods

.PHONY: clean
clean:
	$(RM) -r mods
