import 'package:flutter/material.dart';

class BentoGrid extends StatelessWidget {
  final List<Widget> children;
  final List<List<int>> rows;
  final double spacing;

  const BentoGrid({
    super.key,
    required this.children,
    required this.rows,
    this.spacing = 20,
  });

  @override
  Widget build(BuildContext context) {
    final cells = [...children];
    final built = <Widget>[];

    for (var r = 0; r < rows.length; r++) {
      final rowSpans = rows[r];
      final rowChildren = <Widget>[];
      for (var i = 0; i < rowSpans.length; i++) {
        if (i > 0) {
          rowChildren.add(SizedBox(width: spacing));
        }
        rowChildren.add(Expanded(flex: rowSpans[i], child: cells.removeAt(0)));
      }
      if (r > 0) {
        built.add(SizedBox(height: spacing));
      }
      built.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: rowChildren,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: built,
    );
  }
}
