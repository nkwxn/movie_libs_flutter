import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MovieInfoText extends StatelessWidget {
  final bool useFlex;
  final String title;
  final Widget content;

  const MovieInfoText(
      {super.key,
      required this.useFlex,
      required this.title,
      required this.content});

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    return Column(
      children: [
        Text(
          title.toUpperCase(),
          style: appTheme.textTheme.bodySmall,
        ),
        generateFlexContainer(
          flex: 1,
          child: content,
        ),
      ],
    );
  }

  Widget generateFlexContainer({int flex = 0, required Widget child}) {
    return useFlex ? Flexible(flex: flex, child: child) : child;
  }
}
