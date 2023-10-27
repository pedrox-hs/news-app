setup:
	flutter pub get
	npm --prefix packages/ds install


ds:
	dart run ds:main build
	dart fix --apply packages/ds/lib
	dart format packages/ds/lib


run:
	flutter run --dart-define-from-file=.env $(args)


run-web:
	make run args='-d web-server'


test-all:
	find . -maxdepth 4 -type f -name pubspec.yaml -execdir test -e './test' \; -execdir flutter test --coverage \;
