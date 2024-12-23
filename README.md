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

Elegant Spring Animation
================================================================================

Make your animations feel natural with spring animations.

This package lets you easily create animation curves that are based on spring physics, with customizable bounciness!

Live demo:
- [WASM](https://wasm-app-launch-animation-concept.netlify.app/) | [JavaScript](https://app-launch-animation-concept.netlify.app/)

Live demo 2:
- [WASM](https://wasm-elegant-spring-animation.netlify.app/) | [JavaScript](https://elegant-spring-animation.netlify.app/)

## Getting started

Add `elegant_spring_animation` as a dependency in your pubspec.yaml file:
```yaml
dependencies:
  elegant_spring_animation: ^2.0.2
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
```dart
ScaleTransition(
    scale: CurvedAnimation(parent: animationController, curve: curve, reverseCurve: curve.flipped),
    child: ...,
)
```
```dart
AnimatedScale(
    scale: condition ? 0.5 : 1.0,
    duration: curve.recommendedDuration,
    curve: curve,
    child: ...,
)
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
  
<img src="https://raw.githubusercontent.com/ercantomac/elegant_spring_animation/refs/heads/main/assets/bounce_0.png" height="480" title="0 Bounce"/>


- ``ElegantSpring.gentleBounce``: Has a very subtle bounce.
  
<img src="https://raw.githubusercontent.com/ercantomac/elegant_spring_animation/refs/heads/main/assets/bounce_0-25.png" height="480" title="0.25 Bounce"/>


- ``ElegantSpring.mediumBounce``: Has a noticeable bounce, but not too distracting.
  
<img src="https://raw.githubusercontent.com/ercantomac/elegant_spring_animation/refs/heads/main/assets/bounce_0-5.png" height="480" title="0.5 Bounce"/>


- ``ElegantSpring.strongBounce``: Has a strong bounce.
  
<img src="https://raw.githubusercontent.com/ercantomac/elegant_spring_animation/refs/heads/main/assets/bounce_0-75.png" height="480" title="0.75 Bounce"/>


- ``ElegantSpring.maximumBounce``: Has the maximum bounce, ideal for playful UIs and games.
  
<img src="https://raw.githubusercontent.com/ercantomac/elegant_spring_animation/refs/heads/main/assets/bounce_1.png" height="480" title="1 Bounce"/>


### ``recommendedDuration`` property
You can use whatever duration you want for your animation. After all, ``ElegantSpring`` is just a ``Curve``.

However, if you don't want your animation to feel too fast or too slow, it is recommended to use the ``recommendedDuration``.
It is calculated based on the ``bounce`` parameter, and it's approximately equal to the time it takes the spring to "settle" at the final point.

### Credits
This package is inspired by [sprung](https://pub.dev/packages/sprung) package and [SwiftUI's Spring API](https://developer.apple.com/documentation/swiftui/spring).
