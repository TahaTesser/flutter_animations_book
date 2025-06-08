import 'dart:math';

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../utiils/curve_diagram.dart';
import '../utiils/curves.dart';

@widgetbook.UseCase(name: 'MatrixTransition', type: MatrixTransitionUseCase)
Widget buildMatrixTransitionUseCase(BuildContext context) {
  return MatrixTransitionUseCase(
    curveItem: context.knobs.list<CurveItem>(
      label: 'Curve',
      labelBuilder: (value) => value.label,
      options: curveItems,
      initialOption: curveItems.first,
    ),
    duration: context.knobs.int.slider(
      label: 'Duration (ms)',
      min: 1,
      max: 5000,
      initialValue: 2000,
    ),
    logoSize: context.knobs.double.slider(
      label: 'FlutterLogo size',
      min: 0,
      max: 1000,
      initialValue: 150,
    ),
  );
}

class MatrixTransitionUseCase extends StatefulWidget {
  const MatrixTransitionUseCase({
    super.key,
    required this.curveItem,
    required this.duration,
    required this.logoSize,
  });

  final CurveItem curveItem;
  final int duration;
  final double logoSize;

  @override
  State<MatrixTransitionUseCase> createState() =>
      _MatrixTransitionUseCaseState();
}

/// [AnimationController]s can be created with `vsync: this` because of
/// [TickerProviderStateMixin].
class _MatrixTransitionUseCaseState extends State<MatrixTransitionUseCase>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.duration),
      vsync: this,
    )..repeat();
    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curveItem.curve,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Center(
            child: MatrixTransition(
              animation: _animation,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: FlutterLogo(size: widget.logoSize),
              ),
              onTransform: (double value) {
                return Matrix4.identity()
                  ..setEntry(3, 2, 0.004)
                  ..rotateY(pi * 2.0 * value);
              },
            ),
          ),
        ),
        CurveDiagram(
          name: widget.curveItem.label,
          caption: 'Curve.${widget.curveItem.label}',
          curve: widget.curveItem.curve,
          duration: Duration(milliseconds: widget.duration),
        ),
      ],
    );
  }
}
