<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

Make your animations feel natural with spring animations.

This package lets you easily create spring physics-based animation curves, and use them wherever you want.

[See live demo here.](https://elegant-spring-animation.netlify.app/)

<!--
## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.
-->

## Getting started

Add `elegant_spring_animation` as a dependency in your pubspec.yaml file:
```yaml
dependencies:
  elegant_spring_animation: ^1.0.0
```

## Usage

### Basic usage

Pass the duration of your animation in the constructor, and that's it.

Note: be sure to pass the correct duration, as internal calculations are based on the duration.
(If you pass a different duration than the actual duration of the animation, the resulting curve won't be ideal)

```dart
  final Duration _duration = const Duration(milliseconds: 1000);
  late AnimationController _animationController;
  late Curve _elegantCurve;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: _duration);
    _elegantCurve = ElegantSpring(duration: _duration);
  }
```

### Customizing the bounciness

There is an optional `bounce` parameter, which has a default value of 0 (no bounce).

You can provide a value between -1 and 1. Higher the value, bouncier the animation. (Negative values may result in an unnatural motion).

```dart
_elegantCurve = ElegantSpring(duration: _duration, bounce: 0.25);
```

<!--
## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
-->
