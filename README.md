# Flutter Starter

## Intro

This is a starter project for Flutter based mobile applications.
Some of the code is useful for desktop apps too.
This is an example of a simple mobile app with API integration and how to set it up with some
dependency injection and predictable testing of API integrations.

* See [`AppDependencies`](lib/app_dependencies.dart) for some simple dependency injection and
  ability to override during tests.
* See [`TestAppDepdendencies`](test/test_app_dependencies.dart) for injection of test dependencies.
* See [`result.dart`](lib/prelude/result.dart) for functional handling of errors.
* See [`json.dart`](lib/prelude/json.dart) for simple json parsing (careful it can throw exception).
* See [`http.dart`](lib/prelude/http.dart) for exception free API integrations including safe json
  parsing.
* See [`open_meteo_api.dart`](lib/open_meteo/open_meteo_api.dart) for a usage example of all the
  above.
* See [`location_search_page_test.dart`](test/location_search_page_test.dart) for an example test
  with API integration.

## Dev Environment setup

* Install [Dart](https://dart.dev/)
* Install [Flutter](https://flutter.dev/)
* Install [Android Studio](https://developer.android.com/studio) with Flutter and Dart plugins
* Install [XCode](https://developer.apple.com/xcode/) for iOS dev

## Running the app

### On Android Emulator

* In Android Studio, setup an emulator in the `Device Manager`.
* Run it using the play button in `Device Manager`
* It switches to the `Running Devices` view.
* Select the emulator from the device list next to the run configuration.
* Run `main.dart`

### On iOS Simulator (MacOS+XCode required)

* Start the `iOS Simulator` app
* Install and Run the iPhone Simulator of your choice.
* In Android Studio, select the simulator from the device list next to the run configuration.
* Run `main.dart`

### On Android or iOS Device

* Configure device for developer mode (see Android/iOS documentation for that)
* Connect to your computer
* Select in Android Studio's device list
* Run `main.dart`

## Running tests

```
make test
```

## Formatting

We use a line length of `100` characters, which is good enough to show two files side by side on a modern 27 inch
screen.
Line length can be set in Android Studio `Preferences > Editor > Code Style > Dart`.

```
make format
```

If your prefer a different line length, feel free to update the `Makefile` to your team's liking
and have developers configure Android Studio as well.

## Check before push

To check formatting and run tests before pushing your code

```
make check
```

or

```
make
```
