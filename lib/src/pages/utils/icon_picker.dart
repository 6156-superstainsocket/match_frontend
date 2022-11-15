import 'package:demo/constants.dart';
import 'package:flutter/material.dart';

Future<int?> showIconPicker({
  required BuildContext context,
  int? defalutIconId,
  required bool isIcon,
  List<IconData>? icons,
  List<Widget>? svgs,
  int? crossCount = 4,
}) async {
  int? selectedIconId = defalutIconId;

  await showDialog(
      context: context,
      builder: (_) => AlertDialog(
            content: Container(
              width: dialogWidth,
              height: dialogHeight,
              alignment: Alignment.center,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossCount!,
                ),
                itemCount: isIcon ? icons!.length : svgs!.length,
                itemBuilder: (_, index) => Container(
                  padding: const EdgeInsets.all(0.5 * defaultPadding),
                  child: Center(
                    child: IconButton(
                      color:
                          selectedIconId == index ? pinkHeavyColor : greyColor,
                      iconSize: imgHeight,
                      icon: isIcon ? Icon(icons![index]) : svgs![index],
                      onPressed: () {
                        selectedIconId = index;
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ));

  return selectedIconId;
}
