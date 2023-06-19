import 'package:elegant_spring_animation/elegant_spring_animation.dart';
import 'package:flutter/material.dart';

void main() {
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
  late double _kBounce = 0.25;
  late int _kDuration = 1000;
  late AnimationController _animationController;
  late Curve _elegantCurve = ElegantSpring(duration: Duration(milliseconds: _kDuration), bounce: _kBounce);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: _kDuration));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Elegant Spring Animation Demo'),
        centerTitle: true,
      ),
      body: Row(
        children: <Expanded>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Duration: $_kDuration ms',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Slider(
                  divisions: 100,
                  min: 100.0,
                  max: 5100.0,
                  value: _kDuration.toDouble(),
                  onChanged: (double val) {
                    setState(() {
                      _kDuration = val.toInt();
                      _animationController.duration = Duration(milliseconds: _kDuration);
                      _elegantCurve = ElegantSpring(duration: Duration(milliseconds: _kDuration), bounce: _kBounce);
                    });
                  },
                ),
                const SizedBox(height: 50.0),
                Text(
                  'Bounce: $_kBounce',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Slider(
                  divisions: 40,
                  min: -1.0,
                  max: 1.0,
                  value: _kBounce,
                  onChanged: (double val) {
                    setState(() {
                      _kBounce = double.parse(val.toStringAsFixed(2));
                      _elegantCurve = ElegantSpring(duration: Duration(milliseconds: _kDuration), bounce: _kBounce);
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                const Spacer(flex: 2),
                Expanded(
                  flex: 3,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: ScaleTransition(
                      scale: CurvedAnimation(
                              parent: _animationController, curve: _elegantCurve, reverseCurve: _elegantCurve.flipped)
                          .drive(Tween<double>(begin: 1.0, end: 0.2)),
                      child: RotationTransition(
                        turns: CurvedAnimation(
                                parent: _animationController, curve: _elegantCurve, reverseCurve: _elegantCurve.flipped)
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
                const Spacer(flex: 2),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_animationController.isDismissed) {
            _animationController.forward();
          } else {
            _animationController.reverse();
          }
        },
        label: const Text('Run'),
        icon: const Icon(Icons.play_circle_outline_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
