import 'package:demo/constants.dart';
import 'package:demo/models/tag.dart';
import 'package:demo/src/pages/utils/icon_picker.dart';
import 'package:flutter/material.dart';

Future<Tag?> showUpdateTag({
  required BuildContext context,
  required String action,
  Tag? oldTag,
}) async {
  Tag tag = Tag();
  if (oldTag != null) {
    tag = oldTag;
  }
  final GlobalKey<FormState> tagformKey = GlobalKey<FormState>();

  await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: ((context, setState) {
          return AlertDialog(
            title: Text('$action Tag'),
            content: Container(
              width: dialogWidth,
              height: 0.5 * dialogHeight,
              alignment: Alignment.center,
              child: Form(
                key: tagformKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: greyBackground,
                            ),
                            icon: tag.iconId == null
                                ? const Icon(
                                    Icons.restaurant_outlined,
                                    color: pinkHeavyColor,
                                  )
                                : Icon(
                                    allTagIcons[tag.iconId!],
                                    color: pinkHeavyColor,
                                  ),
                            onPressed: () async {
                              int? result = await showIconPicker(
                                context: context,
                                defalutIconId: tag.iconId,
                                isIcon: true,
                                icons: allTagIcons,
                              );
                              setState(() {
                                tag.iconId = result!;
                              });
                            },
                            label: const Text('Choose Icon',
                                style: TextStyle(color: greyColor)),
                          ),
                        )
                      ],
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 0.5 * defaultPadding),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: "name",
                            ),
                            initialValue: tag.name,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            style: textMiddleSize,
                            onChanged: (value) {
                              setState(() {
                                tag.name = value;
                              });
                            },
                            validator: (value) {
                              return value!.trim().isNotEmpty
                                  ? null
                                  : "Please enter tag name";
                            },
                          ),
                        )
                      ],
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 0.5 * defaultPadding),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: "description",
                            ),
                            initialValue: tag.description,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            style: textMiddleSize,
                            onChanged: (value) {
                              setState(() {
                                tag.description = value;
                              });
                            },
                            validator: (value) {
                              return value!.trim().isNotEmpty
                                  ? null
                                  : "Please enter tag description";
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  if (tagformKey.currentState!.validate()) {
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Save'),
              ),
            ],
          );
        }),
      );
    },
  );

  return tag;
}
