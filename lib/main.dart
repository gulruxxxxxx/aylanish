import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AnimationWidget(),
    );
  }
}

class AnimationWidget extends StatefulWidget {
  const AnimationWidget({super.key});

  @override
  State<AnimationWidget> createState() => _AnimationWidgetState();
}

class _AnimationWidgetState extends State<AnimationWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> rotateAnimation;
  late AnimationController rotateAnimationController;

  @override
  void initState() {
    rotateAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          rotateAnimationController.forward();
        } else if (status == AnimationStatus.completed) {
          rotateAnimationController.repeat();
        }
      })
      ..forward();
    rotateAnimation =
        Tween<double>(begin: 0, end: 2 * pi).animate(rotateAnimationController);

    super.initState();
  }

  @override
  void dispose() {
    rotateAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: AnimatedBuilder(
              animation : rotateAnimation,
              child: Image.asset("assets/girl.avif"),
            builder: (context,child){
                return Transform.rotate(
                    angle : rotateAnimation.value,
                    child: child,
                );
            }
          ),
        ),
      );
  }
}

class AnimationChild extends AnimatedWidget{
  const AnimationChild({
    super.key,
    required Animation animation,
}) : super(listenable: animation);
  @override
  Widget build(BuildContext context){
    return Transform.rotate(
      angle: (listenable as Animation<double>).value,
      child: Image.asset("assets/earth.png"),
    );
  }
}