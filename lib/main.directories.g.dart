// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_animations_book/UseCases/animated_card.dart' as _i2;
import 'package:flutter_animations_book/UseCases/drag_drop.dart' as _i3;
import 'package:flutter_animations_book/UseCases/f1_track.dart' as _i4;
import 'package:flutter_animations_book/UseCases/matrix_transition.dart' as _i5;
import 'package:widgetbook/widgetbook.dart' as _i1;

final directories = <_i1.WidgetbookNode>[
  _i1.WidgetbookFolder(
    name: 'UseCases',
    children: [
      _i1.WidgetbookLeafComponent(
        name: 'AnimatedCard',
        useCase: _i1.WidgetbookUseCase(
          name: 'Animated Card',
          builder: _i2.buildMatrixTransitionUseCase,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'DragDrop',
        useCase: _i1.WidgetbookUseCase(
          name: 'DragDrop',
          builder: _i3.buildDragDropUseCase,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'F1Track',
        useCase: _i1.WidgetbookUseCase(
          name: 'F1 Track',
          builder: _i4.buildF1TrackUseCase,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'MatrixTransitionUseCase',
        useCase: _i1.WidgetbookUseCase(
          name: 'MatrixTransition',
          builder: _i5.buildMatrixTransitionUseCase,
        ),
      ),
    ],
  )
];
