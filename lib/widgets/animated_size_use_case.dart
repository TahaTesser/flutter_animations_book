import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../utiils/curve_diagram.dart';
import '../utiils/curves.dart';

// @widgetbook.UseCase(name: 'AnimatedSize', type: AnimatedSizeUseCase)
// Widget buildMatrixTransitionUseCase(BuildContext context) {
//   return AnimatedSizeUseCase(
//     duration: context.knobs.int.slider(
//       label: 'Duration (ms)',
//       min: 1,
//       max: 5000,
//       initialValue: 2000,
//     ),
//   reverseDuration: context.knobs.int.slider(
//       label: 'Reverse duration (ms)',
//       min: 1,
//       max: 5000,
//       initialValue: 2000,
//     ),
//     curveItem: context.knobs.list<CurveItem>(
//       label: 'Curve',
//       labelBuilder: (value) => value.label,
//       options: curveItems,
//       initialOption: curveItems.first,
//     ),
//   );
// }

class AnimatedSizeUseCase extends StatefulWidget {
  const AnimatedSizeUseCase({
    required this.duration,
    required this.reverseDuration,
    required this.curveItem,
    super.key,
  });

  final int duration;
  final int reverseDuration;
  final CurveItem curveItem;

  @override
  State<AnimatedSizeUseCase> createState() => _AnimatedSizeUseCaseState();
}

class _AnimatedSizeUseCaseState extends State<AnimatedSizeUseCase> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Center(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isSelected = !_isSelected;
                });
              },
              child: ColoredBox(
                color: Colors.amberAccent,
                child: AnimatedSize(
                  duration: Duration(milliseconds: widget.duration),
                  reverseDuration: Duration(milliseconds: widget.reverseDuration),
                  curve: widget.curveItem.curve,
                  child: SizedBox.square(
                    dimension: _isSelected ? 250.0 : 100.0,
                    child: const Center(child: FlutterLogo(size: 75.0)),
                  ),
                ),
              ),
            ),
          ),
        ),
        CurveDiagram(
          name: widget.curveItem.label,
          caption: 'Curve.${widget.curveItem.label}',
          curve: widget.curveItem.curve,
          duration: Duration(milliseconds: widget.duration),
          repeat: false,
        ),
      ],
    );
  }
}
