import 'package:flutter/material.dart';
import 'package:flutter_animations_book/utiils/layout_utils.dart';
import 'package:widgetbook/widgetbook.dart';

import '../utiils/curve_diagram.dart';
import '../utiils/curves.dart';

import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Animated Card', type: AnimatedCard)
Widget buildMatrixTransitionUseCase(BuildContext context) {
  return AnimatedCard(
    duration: context.knobs.int.slider(
      label: 'Duration (ms)',
      min: 1,
      max: 5000,
      initialValue: 500,
    ),

    curveItem: context.knobs.list<CurveItem>(
      label: 'Curve',
      labelBuilder: (value) => value.label,
      options: curveItems,
      initialOption: curveItems.first,
    ),
    diagramAlignment: context.knobs.list(label: 'Diagram alignment', options: [
      Alignment.topLeft,
      Alignment.topRight,
      Alignment.bottomLeft,
      Alignment.bottomRight,
    ],
    initialOption: Alignment.topLeft,
    ),
  );
}

class AnimatedCard extends StatefulWidget {
  const AnimatedCard({
    super.key,
    required this.duration,
    required this.curveItem,
    required this.diagramAlignment,
  });

  final int duration;
  final CurveItem curveItem;
  final Alignment diagramAlignment;
  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard> {
  LayoutSize layoutSize = LayoutSize.small;

  @override
  Widget build(BuildContext context) {
    Size size = switch (layoutSize) {
      LayoutSize.small => Size(300, 300),
      LayoutSize.medium => Size(400, 300),
      LayoutSize.large => Size(400, 600),
    };

    return Stack(
      alignment: widget.diagramAlignment,
      children: [
        Scaffold(
          body: Center(
            child: Column(
              spacing: 20,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 600,
                  child: Center(
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: widget.duration),
                      curve: widget.curveItem.curve,
                      width: size.width,
                      height: size.height,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  'https://misc-assets.raycast.com/wallpapers/floss.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Animated Card',
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            Text(
                              'This is an animated card with an image and some text.',
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium!.copyWith(
                                color:
                                    Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                SegmentedButton<LayoutSize>(
                  segments: const <ButtonSegment<LayoutSize>>[
                    ButtonSegment<LayoutSize>(
                      value: LayoutSize.small,
                      label: Text('Small'),
                    ),
                    ButtonSegment<LayoutSize>(
                      value: LayoutSize.medium,
                      label: Text('Medium'),
                    ),
                    ButtonSegment<LayoutSize>(
                      value: LayoutSize.large,
                      label: Text('Large'),
                    ),
                  ],
                  selected: <LayoutSize>{layoutSize},
                  onSelectionChanged: (Set<LayoutSize> newSelection) {
                    setState(() {
                      layoutSize = newSelection.first;
                    });
                  },
                ),
              ],
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
