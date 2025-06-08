import 'package:flutter/material.dart';
import 'dart:math';

import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'DragDrop', type: DragDrop)
Widget buildDragDropUseCase(BuildContext context) {
  return const DragDrop();
}

class DragDrop extends StatefulWidget {
  const DragDrop({super.key});

  @override
  State<DragDrop> createState() => _DragDropState();
}

class _DragDropState extends State<DragDrop> {
  bool _isDropped = false;
  Color _currentDragColor = Color(0xFF00F9D6);
  Color _droppedColor = Color(0xFF00F9D6);
  final Random _random = Random();

  Color _generateRandomColor() {
    return Color.fromARGB(
      255,
      _random.nextInt(256),
      _random.nextInt(256),
      _random.nextInt(256),
    );
  }

  Widget _buildDraggableContainer({double scale = 1, Color? color}) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 1.0, end: scale),
      duration: const Duration(milliseconds: 300),
      curve: Easing.emphasizedDecelerate,
      builder: (context, animatedScale, child) {
        return Transform.scale(
          scale: animatedScale,
          child: Container(
            width: 100,
            height: 100,
            decoration: ShapeDecoration(
              color: color ?? _currentDragColor,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
            ),
            child: Center(
              child: DefaultTextStyle(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                child: Text(_isDropped ? 'Dropped!' : 'Drag me'),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _currentDragColor = _generateRandomColor();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        spacing: 32,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Draggable<String>(
            data: 'Dragged',
            feedback: _buildDraggableContainer(scale: 1.2),
            childWhenDragging: SizedBox(
              width: 100,
              height: 100,
            ),
            child: _buildDraggableContainer(),
          ),
          DragTarget<String>(
            onAcceptWithDetails: (details) {
              setState(() {
                _isDropped = true;
                _droppedColor =
                    _currentDragColor; // Save the current color as dropped
              });

              // Reset after a delay to allow for another drag
              Future.delayed(Duration(milliseconds: 300), () {
                setState(() {
                  _isDropped = false;
                  _currentDragColor =
                      _generateRandomColor(); // Generate new color for next drag
                });
              });
            },
            builder: (context, candidateData, rejectedData) {
              if (_isDropped) {
                return _buildDraggableContainer(color: _droppedColor);
              }

              bool isAccepting = candidateData.isNotEmpty;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Easing.emphasizedDecelerate,
                width: isAccepting ? 140 : 100,
                height: isAccepting ? 140 : 100,
                decoration: ShapeDecoration(
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  color: isAccepting ? Color(0xFFE0E0E0) : Color(0xFFF0F0F0),
                ),
                child: Center(
                  child: Text(
                    'Drop here',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
