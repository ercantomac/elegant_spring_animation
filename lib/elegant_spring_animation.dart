library elegant_spring_animation;

import 'dart:math';

import 'package:flutter/animation.dart';

class ElegantSpring extends Curve {
  ElegantSpring({this.bounce = 0.0}) {
    assert((bounce >= 0.0 && bounce <= 1.0), '"bounce" value must be between 0.0 and 1.0 inclusive');

    _dampingRatio = _maxDampingRatio - (sqrt(bounce) * (_maxDampingRatio - _minDampingRatio));
    _stiffness = _baseStiffness / pow(_dampingRatio, 2);

    /// ALWAYS STAYS CONSTANT AT 12.5663706144 (4 * pi)
    _dampingCoefficient = _dampingRatio * 2 * sqrt(_mass * _stiffness);

    final double naturalFrequency = sqrt(_stiffness / _mass);
    _angularFrequency = naturalFrequency * sqrt(1.0 - pow(min(_dampingRatio, 0.999999), 2));

    /// Calculating the settling duration
    final double linearDampingRatio = _maxDampingRatio - (bounce * (_maxDampingRatio - _minDampingRatio));
    final double numerator = _dampingCoefficient * linearDampingRatio;
    final double denominator = 2 * sqrt(_mass * _stiffness);

    recommendedDuration = Duration(milliseconds: ((-log(_tolerance) / ((numerator / denominator) * naturalFrequency)) * 1000).round());

    print('_dampingRatio: $_dampingRatio');
    print('_stiffness: $_stiffness');
    print('_dampingCoefficient: $_dampingCoefficient');
    print('_angularFrequency: $_angularFrequency');
    print('recommendedDuration: $recommendedDuration');
  }

  /// 4 * (pi^2)
  static const double _baseStiffness = 39.4784176044;
  static const double _maxDampingRatio = 1.0, _minDampingRatio = 0.19611615;
  static const double _mass = 1.0;
  static const double _tolerance = 0.0001;

  /// Bounciness of the curve.
  /// Must be >= 0 and <= 1.
  /// 0: No bounce.
  /// 1: Maximum bounce.
  /// Defaults to 0.
  final double bounce;

  /// The "settling duration" of the spring.
  /// Recommended to use as the duration of the animation, to ensure that the animation doesn't feel too fast or too slow.
  late final Duration recommendedDuration;

  /// MAX: _maxDampingRatio (when bounce = 0) - CRITICALLY DAMPED
  /// MIN: _minDampingRatio (when bounce = 1) - UNDER DAMPED
  late final double _dampingRatio;

  /// ALWAYS STAYS CONSTANT AT 12.5663706144 (4 * pi)
  late final double _dampingCoefficient;

  /// MAX: 1026.43870214 (when bounce = 1 & _dampingRatio = _minDampingRatio)
  /// MIN: _baseStiffness (when bounce = 0 & _dampingRatio = _maxDampingRatio)
  late final double _stiffness;

  /// MAX: 31.4159240599 (10 * pi) (when bounce = 1 & _dampingRatio = _minDampingRatio)
  /// MIN: 0.00888576365505 (when bounce = 0 & _dampingRatio = _maxDampingRatio)
  late final double _angularFrequency;

  /// For adjusting the graph to ensure that it's not far-off from 1.0 as t approaches 1.0.
  /// This ensures that the animation doesn't "jump" to target at the end.
  late final double _stretchGraphToTarget = 1.0 - calculate(1.0);

  late final double _sinusMultiplication = _dampingCoefficient / _angularFrequency;

  @override
  double transformInternal(double t) {
    return calculate(t) + (t * _stretchGraphToTarget);
  }

  double calculate(double t) {
    final double decay = exp(-_dampingCoefficient * t);
    final double a = _angularFrequency * t;

    return 1 - (decay * (cos(a) + (_sinusMultiplication * sin(a))));
  }

  /// Has the maximum bounce, ideal for playful UIs and games.
  static final ElegantSpring maximumBounce = ElegantSpring(bounce: 1.0);

  /// Has a strong bounce.
  static final ElegantSpring strongBounce = ElegantSpring(bounce: 0.75);

  /// Has a noticeable bounce, but not too distracting.
  static final ElegantSpring mediumBounce = ElegantSpring(bounce: 0.5);

  /// Has a very subtle bounce.
  static final ElegantSpring gentleBounce = ElegantSpring(bounce: 0.25);

  /// Has no bounce, gracefully comes to rest.
  static final ElegantSpring smooth = ElegantSpring();
}
