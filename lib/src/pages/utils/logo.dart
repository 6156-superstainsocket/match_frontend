import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Expanded(
          flex: 8,
          child: SvgPicture.asset(
            "assets/svgs/logo.svg", 
            height: 100, 
            width: 100,
            fit: BoxFit.scaleDown,
          )
        ),
        const Spacer(),
      ],
    );
  }
}