import 'package:flutter/material.dart';

/// Class [JelloIn]:
/// [key]: optional widget key reference
/// [child]: mandatory, widget to animate
/// [duration]: how much time the animation should take
/// [delay]: delay before the animation starts
/// [controller]: optional/mandatory, exposes the animation controller created by Animate_do
/// the controller can be use to repeat, reverse and anything you want, its just an animation controller
class JelloIn extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final double? frameValue;
  final bool loop;
  final int loopDelay;

  JelloIn(
      {key,
      required this.child,
      this.frameValue,
      this.loop = false,
      this.loopDelay = 2,
      this.duration = const Duration(milliseconds: 800),
      this.delay = const Duration(milliseconds: 0),
      this.controller,
      this.manualTrigger = false,
      this.animate = true})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _JelloInState createState() => _JelloInState();
}

/// State class, where the magic happens
class _JelloInState extends State<JelloIn> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> rotation;
  late Animation<double> opacity;

  @override
  void dispose() {
    disposed = true;
    controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    rotation = Tween<double>(begin: 1.5, end: 0.0)
        .animate(CurvedAnimation(parent: controller!, curve: Curves.bounceOut));

    opacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller!, curve: const Interval(0, 0.65)));

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        if (!disposed) {
          controller?.forward();
        }
      });
    }

    controller?.addListener(() async {
       
      if (widget.loop) {
        if (controller?.isCompleted ?? false) {
          await Future.delayed(Duration(seconds: widget.loopDelay));
          if (!disposed) {
            controller?.forward(from: 0);
          }
        }
      }
    });

    if (widget.controller is Function) {
      widget.controller!(controller!);
    }
  }

  @override
  Widget build(BuildContext context) {

    return AnimatedBuilder(
        animation: controller!,
        builder: (BuildContext context, Widget? child) {
          if (widget.frameValue != null) {
            controller?.value = widget.frameValue!;
          }
          return Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.identity()
                ..setEntry(0, 0, rotation.value + 1)
                ..rotateX(rotation.value),
              child: Opacity(
                opacity: opacity.value,
                child: widget.child,
              ));
        });
  }
}
