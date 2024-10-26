import 'dart:math';

import 'package:elegant_spring_animation/elegant_spring_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elegant Spring Animation Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.light),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.dark),
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late double _kBounce = 0.0;
  late int _kDuration = _elegantCurve.recommendedDuration.inMilliseconds;
  late final AnimationController _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: _kDuration));
  late ElegantSpring _elegantCurve = ElegantSpring(bounce: _kBounce);

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double maxWidth = max(MediaQuery.sizeOf(context).height / 2, MediaQuery.sizeOf(context).width / 2);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Elegant Spring Animation Demo'),
        centerTitle: true,
      ),
      body: FractionallySizedBox(
        widthFactor: 1.0,
        child: Wrap(
          //crossAxisAlignment: WrapCrossAlignment.center,
          runAlignment: WrapAlignment.center,
          alignment: WrapAlignment.center,
          children: <Widget>[
            SizedBox(
              width: maxWidth,
              child: AspectRatio(
                aspectRatio: 1,
                child: FractionallySizedBox(
                  //widthFactor: 0.7,
                  heightFactor: 0.7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Duration: $_kDuration ms',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Slider(
                        divisions: 98,
                        min: 100.0,
                        max: 10000.0,
                        value: _kDuration.toDouble(),
                        onChanged: (double val) {
                          setState(() {
                            _kDuration = val.toInt();
                          });
                        },
                      ),
                      Text(
                        'Bounce: $_kBounce',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Slider(
                        divisions: 20,
                        min: 0.0,
                        max: 1.0,
                        value: _kBounce,
                        onChanged: (double val) {
                          setState(() {
                            _kBounce = double.parse(val.toStringAsFixed(2));
                            _kDuration = ElegantSpring(bounce: _kBounce).recommendedDuration.inMilliseconds;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: maxWidth,
              child: AspectRatio(
                aspectRatio: 1,
                child: Align(
                  alignment: const Alignment(0.0, -0.5),
                  child: FractionallySizedBox(
                    widthFactor: 0.5,
                    heightFactor: 0.5,
                    child: ScaleTransition(
                      scale: CurvedAnimation(parent: _animationController, curve: _elegantCurve, reverseCurve: _elegantCurve.flipped)
                          .drive(Tween<double>(begin: 1.0, end: 0.2)),
                      child: RotationTransition(
                        turns: CurvedAnimation(parent: _animationController, curve: _elegantCurve, reverseCurve: _elegantCurve.flipped)
                            .drive(Tween<double>(begin: 0.0, end: 0.5)),
                        child: Material(
                          elevation: 16.0,
                          borderRadius: BorderRadius.circular(20.0),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _isAnimating
            ? null
            : () async {
                setState(() {
                  _animationController.duration = Duration(milliseconds: _kDuration);
                  _elegantCurve = ElegantSpring(bounce: _kBounce);
                  _isAnimating = true;
                });

                if (_animationController.isDismissed) {
                  await _animationController.forward();
                } else {
                  await _animationController.reverse();
                }

                setState(() {
                  _isAnimating = false;
                });
              },
        backgroundColor: _isAnimating ? Theme.of(context).colorScheme.secondaryContainer : null,
        foregroundColor: _isAnimating ? Colors.white38 : null,
        label: const Text('Run'),
        icon: const Icon(Icons.play_circle_outline_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  late bool _isAnimating = false;
}
