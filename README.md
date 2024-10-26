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

## Getting started

Add `elegant_spring_animation` as a dependency in your pubspec.yaml file:
```yaml
dependencies:
  elegant_spring_animation: ^2.0.0
```

## Usage

### Basic usage

```dart
late AnimationController animationController;
final ElegantSpring curve = ElegantSpring.smooth;

@override
void initState() {
  super.initState();
  animationController = AnimationController(vsync: this, duration: curve.recommendedDuration);
}
```

### Customizing the bounciness

There is an optional `bounce` parameter, which has a default value of 0 (no bounce).

You can provide a value between 0 and 1. Higher the value, bouncier the animation.

```dart
final ElegantSpring curve = ElegantSpring(bounce: 0.25);
```

### Predefined curves
There are five predefined curves:

- ``ElegantSpring.smooth``: Has no bounce, gracefully comes to rest.

- ``ElegantSpring.gentleBounce``: Has a very subtle bounce.

- ``ElegantSpring.mediumBounce``: Has a noticeable bounce, but not too distracting.

- ``ElegantSpring.strongBounce``: Has a strong bounce.

- ``ElegantSpring.maximumBounce``: Has the maximum bounce, ideal for playful UIs and games.

### ``recommendedDuration`` property
You can use whatever duration you want for your animation. After all, ``ElegantSpring`` is just a ``Curve``.

However, if you don't want your animation to feel too fast or too slow, it is recommended to use the ``recommendedDuration``.
It is calculated based on the ``bounce`` parameter, and it's approximately equal to the time it takes the spring to "settle" at the final point.