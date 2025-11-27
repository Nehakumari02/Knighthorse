import 'package:flutter/material.dart';

class BGEffectWidget extends StatelessWidget {
  final Widget child;
  const BGEffectWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.transparent,
        // image: DecorationImage(
        //   image: AssetImage('assets/logo/bg.png'),
        //   alignment: Alignment.center,
        //   fit: BoxFit.cover,
        // ),
      ),
      child: child,
    );
  }
}
