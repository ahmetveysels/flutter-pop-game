import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class WidgetSize extends StatefulWidget {
  final Widget child;
  final Function(Size) onChange;

  const WidgetSize({
    super.key,
    required this.onChange,
    required this.child,
  });

  @override
  State<WidgetSize> createState() => _WidgetSizeState();
}

class _WidgetSizeState extends State<WidgetSize> {
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
    return Container(
      key: widgetKey,
      child: widget.child,
    );
  }

  var widgetKey = GlobalKey();
  Size? oldSize;

  void postFrameCallback(_) async {
    var context = widgetKey.currentContext;
    await Future.delayed(
        const Duration(milliseconds: 100)); // wait till the widget is drawn
    if (!mounted || context == null) return; // not yet attached to layout

    // ignore: use_build_context_synchronously
    var newSize = context.size!;
    if (oldSize == newSize) return;

    oldSize = newSize;
    widget.onChange(newSize);
  }
}
