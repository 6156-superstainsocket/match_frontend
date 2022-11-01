import 'package:flutter/material.dart';
import 'package:demo/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DefaultTags extends StatelessWidget {
  const DefaultTags({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Column(
                children: [
                  SvgPicture.asset(
                    "assets/svgs/tag/red/1.svg",
                    height: tagHeight,
                    width: tagWidth,
                    fit: BoxFit.scaleDown,
                  ),
                  const Text('dinner', style: tagRedTextStyle),
                ],
              ),
              const Spacer(flex: 1),
              const Expanded(
                  flex: 6,
                  child: Text('I want to have dinner with her/him',
                      style: textMiddleSize))
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Column(
                children: [
                  SvgPicture.asset(
                    "assets/svgs/tag/red/2.svg",
                    height: tagHeight,
                    width: tagWidth,
                    fit: BoxFit.scaleDown,
                  ),
                  const Text(
                    'date',
                    style: tagRedTextStyle,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              const Spacer(flex: 1),
              const Expanded(
                flex: 6,
                child: Text('I want to date her/him'),
              )
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Column(
                children: [
                  SvgPicture.asset(
                    "assets/svgs/tag/red/3.svg",
                    height: tagHeight,
                    width: tagWidth,
                    fit: BoxFit.scaleDown,
                  ),
                  const Text(
                    'study',
                    style: tagRedTextStyle,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              const Spacer(flex: 1),
              const Expanded(
                flex: 6,
                child: Text(
                  'I want to study with her/him',
                  textAlign: TextAlign.left,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
