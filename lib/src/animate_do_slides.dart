import 'package:flutter/material.dart';

/// Class [SlideInUp]:
/// [key]: optional widget key reference
/// [child]: mandatory, widget to animate
/// [duration]: how much time the animation should take
/// [delay]: delay before the animation starts
/// [controller]: optional/mandatory, exposes the animation controller created by Animate_do
/// the controller can be use to repeat, reverse and anything you want, its just an animation controller
class SlideInUp extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final double from;
  final double? frameValue;
  final bool loop;
  final int loopDelay;

  SlideInUp(
      {key,
      required this.child,
      this.frameValue,
      this.loop = false,
      this.loopDelay = 2,
      this.duration = const Duration(milliseconds: 600),
      this.delay = const Duration(milliseconds: 0),
      this.controller,
      this.manualTrigger = false,
      this.animate = true,
      this.from = 100})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _SlideInUpState createState() => _SlideInUpState();
}

/// State class, where the magic happens
class _SlideInUpState extends State<SlideInUp>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> animation;

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

    animation = Tween<double>(begin: widget.from, end: 0)
        .animate(CurvedAnimation(parent: controller!, curve: Curves.easeOut));

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
          return Transform.translate(
              offset: Offset(0, animation.value), child: widget.child);
        });
  }
}

/// Class [SlideInDown]:
/// [key]: optional widget key reference
/// [child]: mandatory, widget to animate
/// [duration]: how much time the animation should take
/// [delay]: delay before the animation starts
/// [controller]: optional/mandatory, exposes the animation controller created by Animate_do
/// the controller can be use to repeat, reverse and anything you want, its just an animation controller
class SlideInDown extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final double from;
  final double? frameValue;
  final bool loop;
  final int loopDelay;

  SlideInDown(
      {key,
      required this.child,
      this.frameValue,
      this.loop = false,
      this.loopDelay = 2,
      this.duration = const Duration(milliseconds: 600),
      this.delay = const Duration(milliseconds: 0),
      this.controller,
      this.manualTrigger = false,
      this.animate = true,
      this.from = 100})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  Widget build(BuildContext context) => SlideInUp(
        child: child,
        duration: duration,
        delay: delay,
        controller: controller,
        manualTrigger: manualTrigger,
        animate: animate,
        from: from * -1,
        frameValue: frameValue,
        loop: loop,
      );
}

/// Class [SlideInLeft]:
/// [key]: optional widget key reference
/// [child]: mandatory, widget to animate
/// [duration]: how much time the animation should take
/// [delay]: delay before the animation starts
/// [controller]: optional/mandatory, exposes the animation controller created by Animate_do
/// the controller can be use to repeat, reverse and anything you want, its just an animation controller
class SlideInLeft extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final double from;
  final double? frameValue;
  final bool loop;
  final int loopDelay;

  SlideInLeft(
      {key,
      required this.child,
      this.frameValue,
      this.loop = false,
      this.loopDelay = 2,
      this.duration = const Duration(milliseconds: 600),
      this.delay = const Duration(milliseconds: 0),
      this.controller,
      this.manualTrigger = false,
      this.animate = true,
      this.from = 100})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  _SlideInLeftState createState() => _SlideInLeftState();
}

/// State class, where the magic happens
class _SlideInLeftState extends State<SlideInLeft>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> animation;

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

    animation = Tween<double>(begin: widget.from * -1, end: 0)
        .animate(CurvedAnimation(parent: controller!, curve: Curves.easeOut));

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
          return Transform.translate(
              offset: Offset(animation.value, 0), child: widget.child);
        });
  }
}

/// Class [SlideInRight]:
/// [key]: optional widget key reference
/// [child]: mandatory, widget to animate
/// [duration]: how much time the animation should take
/// [delay]: delay before the animation starts
/// [controller]: optional/mandatory, exposes the animation controller created by Animate_do
/// the controller can be use to repeat, reverse and anything you want, its just an animation controller
class SlideInRight extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final double from;
  final double? frameValue;
  final bool loop;
  final int loopDelay;

  SlideInRight(
      {key,
      required this.child,
      this.frameValue,
      this.loop = false,
      this.loopDelay = 2,
      this.duration = const Duration(milliseconds: 600),
      this.delay = const Duration(milliseconds: 0),
      this.controller,
      this.manualTrigger = false,
      this.animate = true,
      this.from = 100})
      : super(key: key) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  Widget build(BuildContext context) => SlideInLeft(
        child: child,
        duration: duration,
        delay: delay,
        controller: controller,
        manualTrigger: manualTrigger,
        animate: animate,
        from: from * -1,
        frameValue: frameValue,
        loop: loop,
      );
}
