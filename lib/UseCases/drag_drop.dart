import 'package:flutter/material.dart';

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
  int _currentContainer = 0;
  final Color _cardColor = Color(0xFF00F9D6);
  final Color _containerColor = Color(0xFF9E9E9E);
  bool _isDragging = false;
  static const String _cardId = 'card';

  Widget _buildCard() {
    return Container(
      width: 100,
      height: 100,
      decoration: ShapeDecoration(
        color: _cardColor,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        shadows: _isDragging
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
      ),
      child: Center(
        child: DefaultTextStyle(
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          child: Text('Card'),
        ),
      ),
    );
  }

  Widget _containerArea(int index) {
    bool isActive = _currentContainer == index;
    bool hasCard = isActive;

    return DragTarget<String>(
      onWillAcceptWithDetails: (details) => details.data == _cardId,
      onAcceptWithDetails: (details) {
        setState(() {
          _currentContainer = index;
          // Keep the same color to maintain visual continuity
        });
      },
      builder: (context, candidateData, rejectedData) {
        bool isHovering = candidateData.isNotEmpty;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Easing.emphasizedDecelerate,
          width: 150,
          height: 150,
          decoration: ShapeDecoration(
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(24),
              side: BorderSide(
                color: isHovering
                    ? _cardColor.withValues(alpha: 0.5)
                    : _containerColor.withValues(alpha: 0.3),
                width: isHovering ? 3 : 1,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
            ),
          ),
          child: Stack(
            children: [
              if (hasCard)
                Center(
                  child: Draggable<String>(
                    data: _cardId,
                    onDragStarted: () {
                      setState(() {
                        _isDragging = true;
                      });
                    },
                    onDragEnd: (details) {
                      setState(() {
                        _isDragging = false;
                      });

                      if (!details.wasAccepted) {
                        setState(() {});
                      }
                    },
                    feedback: Transform.scale(
                      scale: 1.1,
                      child: _buildCard(),
                    ),
                    childWhenDragging: Container(
                      width: 100,
                      height: 100,
                      decoration: ShapeDecoration(
                        color: _containerColor.withValues(alpha: 0.1),
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                          side: BorderSide(
                            color: _containerColor.withValues(alpha: 0.5),
                            width: 2,
                            strokeAlign: BorderSide.strokeAlignInside,
                          ),
                        ),
                      ),
                    ),
                    child: _buildCard(),
                  ),
                ),
              if (isHovering && !hasCard)
                Center(
                  child: Icon(
                    Icons.add_circle_outline,
                    color: _cardColor.withValues(alpha: 0.7),
                    size: 48,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        spacing: 50,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _containerArea(0),
          _containerArea(1),
        ],
      ),
    );
  }
}
