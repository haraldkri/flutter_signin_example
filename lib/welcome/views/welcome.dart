import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome!',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 20),
          Lottie.asset(
            "assets/animations/hello_animation.json",
            controller: _controller,
            onLoaded: (composition) {
              _controller.duration = composition.duration;
              _controller.forward();
            },
          ),
        ],
      ),
    );
  }
}
