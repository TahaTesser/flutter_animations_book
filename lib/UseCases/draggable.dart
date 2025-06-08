import 'package:flutter/material.dart';

import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Draggable', type: Draggable)
Widget buildDraggableUseCase(BuildContext context) {
  return const DraggableSample();
}

class DraggableSample extends StatefulWidget {
  const DraggableSample({super.key});

  @override
  State<DraggableSample> createState() => _DraggableSampleState();
}

class _DraggableSampleState extends State<DraggableSample> {
  bool _isDragged = false;
  Color cardColor = Color(0xFF00F9D6);


  Widget _buildDraggableContainer({double scale = 1}) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 1.0, end: scale),
      duration: const Duration(milliseconds: 800),
      curve: Easing.emphasizedDecelerate,
      builder: (context, animatedScale, child) {
        return Transform.scale(
          scale: animatedScale,
          child: Container(
            width: 100,
            height: 100,
            decoration: ShapeDecoration(
              color: cardColor,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              shadows: [
                BoxShadow(
                  color: _isDragged ? cardColor.withValues(alpha: 0.2) : Colors.transparent,
                  blurRadius: 10,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Center(
              child: DefaultTextStyle(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                child: Text(_isDragged ? 'Dragged' : 'Drag me'),
              ),
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Draggable<String>(
        data: 'Dragged',
        onDragStarted: () {
          setState(() {
            _isDragged = true;
          });
        } ,
        onDragEnd: (details) {
          setState(() {
            _isDragged = false;
          });
        } ,
        feedback: _buildDraggableContainer(scale: 1.2),
        childWhenDragging: SizedBox.shrink(),
        child: _buildDraggableContainer(),
      ),
    );
  }
}
