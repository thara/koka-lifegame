.PHONY: build run test

build:
	@koka -istd -o lifegame lifegame.kk

run:
	@koka -istd -e lifegame.kk
	
test:
	@koka -istd -e test.kk
