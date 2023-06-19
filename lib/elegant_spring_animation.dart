library elegant_spring_animation;

import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/physics.dart';

class ElegantSpring extends Curve {
  ElegantSpring({
    required Duration duration,
    double bounce = 0.0,
  }) {
    assert((bounce >= -1.0 && bounce <= 1.0), '"bounce" value must be between -1.0 and 1.0.');
    /*if (!(bounce >= -1.0 && bounce <= 1.0)) {
      throw Exception('"bounce" value must be between -1.0 and 1.0.');
    }*/

    final double dur = max(1.0, (duration.inMilliseconds / 1000));
    final double stiffness = ((2 * pi) / dur) * ((2 * pi) / dur) * 3.5;
    final double dampingRatio = 1.0 - bounce;
    /*final double alternativeDampingRatio =
        (bounce >= 0.0) ? (1 - (4 * pi) * bounce / dur) : ((4 * pi) / (dur + (4 * pi) * bounce));*/

    final SpringDescription desc = SpringDescription.withDampingRatio(
      mass: 1.0,
      stiffness: stiffness,
      ratio: dampingRatio,
    );

    _sim = SpringSimulation(
      desc,
      0.0,
      1.0,
      0.0,
    );

    _val = (1 - _sim.x(1.0));

    print('Bounce: $bounce');
    print('Duration: $dur seconds');
    print('Stiffness: $stiffness');
    print('Damping ratio: $dampingRatio');
    //print('Alternative damping ratio: $alternativeDampingRatio');
    print('Damping: ${desc.damping}\n\n');
  }

  late final SpringSimulation _sim;
  late final double _val;

  @override
  double transform(double t) => _sim.x(t) + t * _val;
}
