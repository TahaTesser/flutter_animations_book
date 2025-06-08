import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// This file does not exist yet,
// it will be generated in the next step
import 'main.directories.g.dart';

void main() {
  runApp(const WidgetbookApp());
}

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      addons: [
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(
                name: 'Light',
                data: ThemeData(
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Color(0xFFFF0000)),
                )),
            WidgetbookTheme(
              name: 'Dark',
              data: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Color(0xFFFF0000),
                  brightness: Brightness.dark,
                ),
              ),
            ),
          ],
        ),
      ],
      // The [directories] variable does not exist yet,
      // it will be generated in the next step
      directories: directories,
    );
  }
}
