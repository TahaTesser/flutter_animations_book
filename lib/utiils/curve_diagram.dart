import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:math' as math;

const double _kFontSize = 14.0;
const Duration _kCurveAnimationDuration = Duration(seconds: 2);

/// A custom painter to draw the graph of the curve.
class CurveDescription extends CustomPainter {
  CurveDescription(this.caption, this.curve, this.position)
      : _caption = _createLabelPainter(caption, color: Colors.black);

  final String caption;
  final Curve curve;
  final double position;

  static final TextPainter _t = _createLabelPainter(
    't',
    style: FontStyle.italic,
  );
  static final TextPainter _x = _createLabelPainter(
    'x',
    style: FontStyle.italic,
  );
  static final TextPainter _zero = _createLabelPainter('0.0');
  static final TextPainter _one = _createLabelPainter('1.0');
  final TextPainter _caption;

  static TextPainter _createLabelPainter(
    String label, {
    FontStyle style = FontStyle.normal,
    Color color = Colors.black45,
  }) {
    final TextPainter result = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: label,
        style: TextStyle(color: color, fontStyle: style, fontSize: _kFontSize),
      ),
    );
    result.layout();
    return result;
  }

  static final Paint _axisPaint = Paint()
    ..color = Colors.black45
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0;

  static final Paint _positionPaint = Paint()
    ..color = Colors.black45
    ..style = PaintingStyle.stroke
    ..strokeWidth = 0.0;

  static final Paint _dashPaint = Paint()
    ..color = Colors.black45
    ..style = PaintingStyle.stroke
    ..strokeWidth = 0.0;

  static final Paint _graphPaint = Paint()
    ..color = Colors.blue.shade900
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 4.0;

  static final Paint _graphProgressPaint = Paint()
    ..color = Colors.black26
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 4.0;

  static final Paint _valueMarkerPaint = Paint()
    ..color = const Color(0xffA02020)
    ..style = PaintingStyle.fill;

  static final Paint _positionCirclePaint = Paint()
    ..color = Colors.blue.shade900
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    assert(size != Size.zero);
    final double unit = _zero.width / 4.0;
    final double leftMargin = unit * 6.0;
    final double rightMargin = 3.0 * unit + _t.width;
    final double bottomMargin = unit / 2.0;
    final double verticalHeadroom = size.height * 0.2;
    final double markerWidth = unit * 3.0;

    final Rect area = Rect.fromLTRB(
      leftMargin,
      verticalHeadroom,
      size.width - rightMargin,
      size.height - verticalHeadroom,
    );
    final Path axes = Path()
      ..moveTo(area.left - unit, area.top) // vertical axis 1.0 tick
      ..lineTo(area.left, area.top) // vertical axis
      ..lineTo(area.left, area.bottom) // origin
      ..lineTo(area.right, area.bottom) // horizontal axis
      ..lineTo(area.right, area.bottom + unit); // horizontal axis 1.0 tick
    canvas.drawPath(axes, _axisPaint);
    final Path dashLine = Path();
    final double delta = 8.0 / area.width;
    assert(delta > 0.0);
    for (double t = 0.0; t < 1.0; t += delta) {
      final Offset point1 = FractionalOffset(t, 0.0).withinRect(area);
      final Offset point2 = FractionalOffset(
        t + delta / 2.0,
        0.0,
      ).withinRect(area);
      dashLine
        ..moveTo(point1.dx, point1.dy)
        ..lineTo(point2.dx, point2.dy);
    }
    canvas.drawPath(dashLine, _dashPaint);

    _one.paint(
      canvas,
      Offset(
        area.left - leftMargin + (_zero.width - _one.width),
        area.top - _one.height / 2.0,
      ),
    );
    _one.paint(
      canvas,
      Offset(area.right - _one.width / 2.0, area.bottom + bottomMargin + unit),
    );
    _x.paint(canvas, Offset(area.left + _x.width, area.top));
    _t.paint(
      canvas,
      Offset(area.right - _t.width, area.bottom - _t.height - unit / 2.0),
    );
    _caption.paint(
      canvas,
      Offset(
        leftMargin + (area.width - _caption.width) / 2.0,
        size.height - (verticalHeadroom + _caption.height) / 2.0,
      ),
    );
    final Offset activePoint = FractionalOffset(
      position,
      1.0 - curve.transform(position),
    ).withinRect(area);
    // Skip drawing the tracing line if we're at 0.0 because we want the
    // initial paused state to not include the position indicators. They just
    // add clutter before the animation is started.
    if (position != 0.0) {
      final Path positionLine = Path()
        ..moveTo(activePoint.dx, area.bottom)
        ..lineTo(activePoint.dx, area.top); // vertical pointer from base
      canvas.drawPath(positionLine, _positionPaint);
      final Path valueMarker = Path()
        ..moveTo(area.right + unit, activePoint.dy)
        ..lineTo(area.right + unit * 2.0, activePoint.dy - unit)
        ..lineTo(
          area.right + unit * 2.0 + markerWidth,
          activePoint.dy - unit,
        )
        ..lineTo(
          area.right + unit * 2.0 + markerWidth,
          activePoint.dy + unit,
        )
        ..lineTo(area.right + unit * 2.0, activePoint.dy + unit)
        ..lineTo(area.right + unit, activePoint.dy);
      canvas.drawPath(valueMarker, _valueMarkerPaint);
    }
    final Path graph = Path()..moveTo(area.left, area.bottom);
    final double stepSize = 1.0 /
        (area.width *
            (ui.PlatformDispatcher.instance.implicitView?.devicePixelRatio ??
                1.0));
    for (double t = 0.0;
        t <= (position == 0.0 ? 1.0 : position);
        t += stepSize) {
      final Offset point = FractionalOffset(
        t,
        1.0 - curve.transform(t),
      ).withinRect(area);
      graph.lineTo(point.dx, point.dy);
    }
    canvas.drawPath(graph, _graphPaint);
    if (position != 0.0) {
      final Offset startPoint = FractionalOffset(
        position,
        1.0 - curve.transform(position),
      ).withinRect(area);
      final Path graphProgress = Path()..moveTo(startPoint.dx, startPoint.dy);
      for (double t = position; t <= 1.0; t += stepSize) {
        final Offset point = FractionalOffset(
          t,
          1.0 - curve.transform(t),
        ).withinRect(area);
        graphProgress.lineTo(point.dx, point.dy);
      }
      canvas.drawPath(graphProgress, _graphProgressPaint);
      canvas.drawCircle(
        Offset(activePoint.dx, activePoint.dy),
        4.0,
        _positionCirclePaint,
      );
    }
  }

  @override
  bool shouldRepaint(CurveDescription oldDelegate) {
    return caption != oldDelegate.caption || curve != oldDelegate.curve;
  }
}

/// A sample tile that shows the effect of a curve on translation.
class TranslateSampleTile extends StatelessWidget {
  const TranslateSampleTile({
    super.key,
    required this.animation,
    required this.name,
  });

  static const double blockHeight = 20.0;
  static const double blockWidth = 30.0;
  static const double containerSize = 48.0;

  final Animation<double> animation;
  final String name;

  Widget mutate({required Widget child}) {
    return Transform.translate(
      offset: Offset(0.0, 13.0 - animation.value * 26.0),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    const BorderRadius outerRadius = BorderRadius.all(Radius.circular(8.0));
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: ClipRRect(
            borderRadius: outerRadius,
            // ignore: avoid_unnecessary_containers
            child: Container(
              width: containerSize,
              height: containerSize,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                borderRadius: outerRadius,
                border: Border.all(color: Colors.black45),
              ),
              child: mutate(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                  width: blockWidth,
                  height: blockHeight,
                ),
              ),
            ),
          ),
        ),
        Text(
          name,
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(color: Colors.black, fontSize: 12.0),
        ),
      ],
    );
  }
}

/// A sample tile that shows the effect of a curve on rotation.
class RotateSampleTile extends TranslateSampleTile {
  const RotateSampleTile({
    super.key,
    required super.animation,
    required super.name,
  });

  @override
  Widget mutate({required Widget child}) {
    return Transform.rotate(
      angle: animation.value * math.pi / 2.0,
      child: child,
    );
  }
}

/// A sample tile that shows the effect of a curve on scale.
class ScaleSampleTile extends TranslateSampleTile {
  const ScaleSampleTile({
    super.key,
    required super.animation,
    required super.name,
  });

  @override
  Widget mutate({required Widget child}) {
    return Transform.scale(scale: math.max(animation.value, 0.0), child: child);
  }
}

/// A sample tile that shows the effect of a curve on opacity.
class OpacitySampleTile extends TranslateSampleTile {
  const OpacitySampleTile({
    super.key,
    required super.animation,
    required super.name,
  });

  @override
  Widget mutate({required Widget child}) {
    return Opacity(opacity: animation.value.clamp(0.0, 1.0), child: child);
  }
}

class CurveDiagram extends StatefulWidget {
  const CurveDiagram({
    required String name,
    required this.caption,
    this.duration = _kCurveAnimationDuration,
    required this.curve,
    this.repeat = true,
    super.key,
  }) : name = 'curve_$name';

  final String name;
  final String caption;
  final Curve curve;
  final Duration duration;
  final bool repeat;

  @override
  CurveDiagramState createState() {
    return CurveDiagramState();
  }
}

class CurveDiagramState extends State<CurveDiagram>
    with TickerProviderStateMixin<CurveDiagram> {
  late AnimationController controller;
  late CurvedAnimation animation;

  @override
  void didUpdateWidget(CurveDiagram oldWidget) {
    super.didUpdateWidget(oldWidget);
    controller.value = 0.0;
    animation = CurvedAnimation(curve: widget.curve, parent: controller);
    controller.forward();
    if (widget.repeat) {
      controller.repeat();
    }
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: widget.duration, vsync: this)
      ..addListener(() {
        setState(() {});
      });
    animation = CurvedAnimation(curve: widget.curve, parent: controller);
    controller.forward();
    if (widget.repeat) {
      controller.repeat();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CurveDescription description = CurveDescription(
      widget.caption,
      widget.curve,
      controller.value,
    );
    return Container(
      padding: const EdgeInsets.all(7.0),
      child: ConstrainedBox(
        constraints: BoxConstraints.tight(const Size(300.0, 178.0)),
        key: UniqueKey(),
        child: CustomPaint(painter: description),
      ),
    );
  }
}
