.PHONY: weather_app/install weather_app/check

weather_app/install:
	cd weather_app; flutter pub get

weather_app/check:
	cd weather_app; dart format lib --line-length 100 --set-exit-if-changed
	cd weather_app; flutter test
	cd weather_app; dart run cyclic_dependency_checks .
