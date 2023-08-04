SHELL := /bin/bash
PWD=$(shell pwd)
DOCKER := sudo docker

.PHONY: build
build:
	$(DOCKER) build -t microblogpub/microblogpub .

.PHONY: config
config:
	# Run and remove instantly
	-$(DOCKER) run --rm -it --volume `pwd`/data:/app/data microblogpub/microblogpub inv configuration-wizard

.PHONY: update
update:
	-$(DOCKER) run --rm --volume `pwd`/data:/app/data --volume `pwd`/app/static:/app/app/static microblogpub/microblogpub inv update --no-update-deps

.PHONY: prune-old-data
prune-old-data:
	-$(DOCKER) run --rm --volume `pwd`/data:/app/data --volume `pwd`/app/static:/app/app/static microblogpub/microblogpub inv prune-old-data

.PHONY: webfinger
webfinger:
	-$(DOCKER) run --rm --volume `pwd`/data:/app/data --volume `pwd`/app/static:/app/app/static microblogpub/microblogpub inv webfinger $(account)

.PHONY: move-to
move-to:
	-$(DOCKER) run --rm --volume `pwd`/data:/app/data --volume `pwd`/app/static:/app/app/static microblogpub/microblogpub inv move-to $(account)

.PHONY: self-destruct
self-destruct:
	-$(DOCKER) run --rm --it --volume `pwd`/data:/app/data --volume `pwd`/app/static:/app/app/static microblogpub/microblogpub inv self-destruct

.PHONY: reset-password
reset-password:
	-$(DOCKER) run --rm -it --volume `pwd`/data:/app/data --volume `pwd`/app/static:/app/app/static microblogpub/microblogpub inv reset-password

.PHONY: check-config
check-config:
	-$(DOCKER) run --rm --volume `pwd`/data:/app/data --volume `pwd`/app/static:/app/app/static microblogpub/microblogpub inv check-config

.PHONY: compile-scss
compile-scss:
	-$(DOCKER) run --rm --volume `pwd`/data:/app/data --volume `pwd`/app/static:/app/app/static microblogpub/microblogpub inv compile-scss

.PHONY: import-mastodon-following-accounts 
import-mastodon-following-accounts:
	-$(DOCKER) run --rm --volume `pwd`/data:/app/data --volume `pwd`/app/static:/app/app/static microblogpub/microblogpub inv import-mastodon-following-accounts $(path)
