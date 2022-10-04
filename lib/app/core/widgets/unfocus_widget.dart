import 'package:flutter/material.dart';

class UnfocusWidget extends StatelessWidget {
  final Widget? child;

  UnfocusWidget({this.child});

  @override
  Widget build(BuildContext context) {
    return Listener(
      child: child,
      onPointerDown: (event) {
        final currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
    );
  }
}
