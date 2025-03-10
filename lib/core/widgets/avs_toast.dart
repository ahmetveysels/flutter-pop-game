import 'package:flutter/material.dart';

class AVSToast {
  //Buraya bir enum tanımlanacak uzunluk bakımından. ona göre işlem yapılacak.
  static void show(String msg, BuildContext context, {int? duration = 3, int? gravity = 0, Color? backgroundColor, textStyle = const TextStyle(fontSize: 15, color: Colors.white), double backgroundRadius = 20, bool? rootNavigator, Border? border}) {
    ToastView.dismiss();
    ToastView.createView(msg, context, duration, gravity, backgroundColor ?? const Color.fromARGB(255, 112, 237, 116), textStyle, backgroundRadius, border, rootNavigator);
  }
}

class ToastView {
  static final ToastView _singleton = ToastView._internal();

  factory ToastView() {
    return _singleton;
  }

  ToastView._internal();

  static OverlayState? overlayState;
  static OverlayEntry? _overlayEntry;
  static bool _isVisible = false;

  static void createView(String msg, BuildContext context, int? duration, int? gravity, Color background, TextStyle textStyle, double backgroundRadius, Border? border, bool? rootNavigator) async {
    overlayState = Overlay.of(context, rootOverlay: rootNavigator ?? false);

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => ToastWidget(
          widget: InkWell(
            onTap: () {
              dismiss();
              _isVisible = false;
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    decoration: BoxDecoration(
                      color: background,
                      borderRadius: BorderRadius.circular(backgroundRadius),
                      border: border,
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                    child: Text(msg, softWrap: true, style: textStyle),
                  )),
            ),
          ),
          gravity: gravity),
    );
    _isVisible = true;
    overlayState!.insert(_overlayEntry!);
    await Future.delayed(Duration(seconds: duration ?? 2));
    dismiss();
  }

  static dismiss() async {
    if (!_isVisible) {
      return;
    }
    _isVisible = false;
    _overlayEntry?.remove();
  }
}

class ToastWidget extends StatelessWidget {
  const ToastWidget({
    super.key,
    required this.widget,
    required this.gravity,
  });

  final Widget widget;
  final int? gravity;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: gravity == 2 ? MediaQuery.of(context).viewInsets.top + 70 : null,
        bottom: gravity == 0 ? MediaQuery.of(context).viewInsets.bottom + 70 : null,
        child: Material(
          color: Colors.transparent,
          child: widget,
        ));
  }
}
