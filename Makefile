# BUILD
.PHONY: format 
format:
	flutter format lib/

.PHONY: format-analyze
format-analyze:
	flutter format --dry-run lib/
	flutter analyze

.PHONY: unit-test
unit-test:
	flutter test --coverage --coverage-path=./coverage/lcov.info

.PHONY: build-runner
build-runner:
	./bin/before_build_runner.bash && flutter packages pub run build_runner build --delete-conflicting-outputs && ./bin/after_build_runner.bash

.PHONY: watch-runner
watch-runner:
	flutter packages pub run build_runner watch --delete-conflicting-outputs

.PHONY: build_runner_filter
build-filter:
	dart ./bin/build_runner/index.dart