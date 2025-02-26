import 'package:flutter/material.dart';
import 'package:popgame/core/functions/app_size.dart';

class BackgraundWidget extends StatelessWidget {
  const BackgraundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: appHeight(context),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFB9DEFE),
            Color(0xFF88C6FC),
            Color(0xFF6FB6F6),
            Color(0xFF199EF3),
            Color(0xFF0082F0),
          ],
        ),
      ),
      child: const Stack(
        children: [],
      ),
    );
  }
}
