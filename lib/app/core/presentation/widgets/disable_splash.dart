import 'package:flutter/material.dart';

class DisableSplash extends StatelessWidget {
  const DisableSplash({required this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overscroll) {
        overscroll.disallowIndicator();
        return true;
      },
      child: child!,
    );
  }
}
