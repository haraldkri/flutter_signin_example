import 'package:flutter/material.dart';

void main() => runApp(const SignUpApp());

class SignUpApp extends StatelessWidget {
  const SignUpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      routes: {
        '/': (context) => const SignUpScreen(),
        '/welcome': (context) => const WelcomeScreen(),
      },
    );
  }
}

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
//      backgroundColor: Colors.grey[200],
      body: Center(
        child: SizedBox(
          width: 400,
          child: Card(
            child: SignUpForm(),
          ),
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _firstNameTextController = TextEditingController();
  final _lastNameTextController = TextEditingController();
  final _usernameTextController = TextEditingController();

  double _formProgress = 0;

  final _formKey = GlobalKey<FormState>();

  void _updateFormProgress() {
    double progress = 0.0;
    final controllers = [
      _firstNameTextController,
      _lastNameTextController,
      _usernameTextController
    ];

    for (var controller in controllers) {
      if (controller.value.text.isNotEmpty) progress += 1 / controllers.length;
    }

    setState(() {
      _formProgress = progress;
    });
  }

  void _showWelcomeScreen() {
    Navigator.of(context).pushNamed('/welcome');
  }

  void _onFormSubmit() {
    if (_formKey.currentState!.validate()) {
      _showWelcomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      onChanged: _updateFormProgress,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedProgressIndicator(value: _formProgress),
          Text('Sign up', style: Theme.of(context).textTheme.headlineMedium),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              controller: _firstNameTextController,
              decoration: const InputDecoration(hintText: 'First name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                if (value.contains(RegExp(r'[0-9]'))) {
                  return 'Your name must not contain any numbers';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
                controller: _lastNameTextController,
                decoration: const InputDecoration(hintText: 'Last name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  if (value.contains(RegExp(r'[0-9]'))) {
                    return 'Your name must not contain any numbers';
                  }
                  return null;
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              controller: _usernameTextController,
              decoration: const InputDecoration(hintText: 'Username'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                if (value.length < 3) {
                  return 'Your name must contain at least three characters';
                }
                return null;
              },
            ),
          ),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.resolveWith((states) {
                return states.contains(MaterialState.disabled)
                    ? null
                    : Colors.white;
              }),
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                return states.contains(MaterialState.disabled)
                    ? null
                    : Colors.blue;
              }),
            ),
            onPressed: _formProgress == 1.0 ? _onFormSubmit : null,
            child: const Text('Sign up'),
          ),
        ],
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Welcome!',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
    );
  }
}

class AnimatedProgressIndicator extends StatefulWidget {
  final double value;

  const AnimatedProgressIndicator({
    super.key,
    required this.value,
  });

  @override
  State<AnimatedProgressIndicator> createState() {
    return _AnimatedProgressIndicatorState();
  }
}

class _AnimatedProgressIndicatorState extends State<AnimatedProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _curveAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    final colorTween = TweenSequence([
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.red, end: Colors.orange),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.orange, end: Colors.yellow),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.yellow, end: Colors.green),
        weight: 1,
      ),
    ]);

    _colorAnimation = _controller.drive(colorTween);
    _curveAnimation = _controller.drive(CurveTween(curve: Curves.easeIn));
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.animateTo(widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => LinearProgressIndicator(
        value: _curveAnimation.value,
        valueColor: _colorAnimation,
        backgroundColor: _colorAnimation.value?.withOpacity(0.4),
      ),
    );
  }
}
