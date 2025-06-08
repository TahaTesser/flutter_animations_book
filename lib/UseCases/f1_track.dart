import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'F1 Track', type: F1Track)
Widget buildF1TrackUseCase(BuildContext context) {
  return F1Track(
    shouldAnimate: context.knobs.boolean(
      label: 'Animate',
      initialValue: false,
    ),
    duration: Duration(
      milliseconds: context.knobs.int.slider(
        label: 'Duration (ms)',
        initialValue: 1000,
        min: 200,
        max: 5000,
      ),
    ),
  );
}

class AnimatedF1Car extends StatelessWidget {
  final String label;
  final Curve curve;
  final AnimationController animationController;
  final String carEmoji;

  const AnimatedF1Car({
    super.key,
    required this.label,
    required this.curve,
    required this.animationController,
    this.carEmoji = '🏎️',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(label),
        AnimatedAlign(
          alignment: animationController.value == 0
              ? Alignment.centerRight
              : Alignment.centerLeft,
          duration: animationController.duration!,
          curve: curve,
          child: Text(carEmoji, style: TextStyle(fontSize: 60)),
        ),
      ],
    );
  }
}

class F1Track extends StatefulWidget {
  final bool shouldAnimate;
  final Duration duration;

  const F1Track({
    super.key,
    required this.shouldAnimate,
    required this.duration,
  });

  @override
  State<F1Track> createState() => _F1TrackState();
}

class _F1TrackState extends State<F1Track> with TickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    if (widget.shouldAnimate) {
      _animationController.forward();
    }
  }

  @override
  void didUpdateWidget(F1Track oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.duration != widget.duration) {
      _animationController.duration = widget.duration;
    }

    if (oldWidget.shouldAnimate != widget.shouldAnimate) {
      if (widget.shouldAnimate) {
        _animationController.forward();
      } else {
        _animationController.reset();
      }
    }
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
        title: Row(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://www.formula1.com/content/dam/fom-website/manual/Trademarks/f1-red-800px.png',
              height: 60,
            ),
            const Text('Material Easing'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Animation track
            Expanded(
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Column(
                    children: [
                      AnimatedF1Car(
                        label: 'Emphasized Accelerate',
                        curve: Easing.emphasizedAccelerate,
                        animationController: _animationController,
                      ),
                      AnimatedF1Car(
                        label: 'Emphasized Decelerate',
                        curve: Easing.emphasizedDecelerate,
                        animationController: _animationController,
                      ),
                      AnimatedF1Car(
                        label: 'Standard Accelerate',
                        curve: Easing.standardAccelerate,
                        animationController: _animationController,
                      ),
                      AnimatedF1Car(
                        label: 'Standard Decelerate',
                        curve: Easing.standardDecelerate,
                        animationController: _animationController,
                      ),
                      AnimatedF1Car(
                        label: 'Legacy Accelerate',
                        curve: Easing.legacyAccelerate,
                        animationController: _animationController,
                      ),
                      AnimatedF1Car(
                        label: 'Legacy Decelerate',
                        curve: Easing.legacyDecelerate,
                        animationController: _animationController,
                      ),
                      AnimatedF1Car(
                        label: 'Legacy',
                        curve: Easing.legacy,
                        animationController: _animationController,
                      ),
                      AnimatedF1Car(
                        label: 'Linear',
                        curve: Easing.linear,
                        animationController: _animationController,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
