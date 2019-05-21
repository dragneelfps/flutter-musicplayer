import 'package:flutter/material.dart';

class DurationMaterialPageRoute extends MaterialPageRoute {
  final Duration duration;
  DurationMaterialPageRoute({WidgetBuilder builder, this.duration})
      : super(builder: builder);

  @override
  Duration get transitionDuration => duration;
}
