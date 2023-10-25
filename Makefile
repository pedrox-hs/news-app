setup:
	flutter pub get
	npm --prefix packages/ds install

ds:
	dart run ds:main build
	dart fix --apply packages/ds/lib
	dart format packages/ds/lib