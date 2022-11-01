import 'package:demo/src/pages/group/custom_tags.dart';
import 'package:demo/src/pages/group/default_tags.dart';
import 'package:demo/src/pages/group/pop_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:demo/constants.dart';

class AdminSetting extends StatefulWidget {
  const AdminSetting({super.key});

  @override
  State<AdminSetting> createState() => _AdminSettingState();
}

class _AdminSettingState extends State<AdminSetting> {
  bool adminApproval = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const PopMenu(
        title: 'Setting',
        buttonText: 'Save',
      ),
      body: Form(
        child: Column(
          children: [
            const SizedBox(height: defaultPadding),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(flex: 1),
                  Expanded(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Description',
                          style: textLargeSize,
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 0.5 * defaultPadding),
                        Expanded(
                          child: TextFormField(
                            initialValue: 'This is a group for fun',
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            style: textMiddleSize,
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        const Text('Image', style: textLargeSize),
                        const SizedBox(height: 0.5 * defaultPadding),
                        SvgPicture.asset(
                          "assets/svgs/group/16.svg",
                          height: 40,
                          width: 40,
                          fit: BoxFit.scaleDown,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(flex: 1),
                  Expanded(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Admission Policy',
                          style: textLargeSize,
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 0.5 * defaultPadding),
                        Text(
                          'Allow other members invite others without your approval?',
                          style: textMiddleSize,
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Switch(
                          value: adminApproval,
                          activeColor: greenColor,
                          onChanged: (bool value) {
                            setState(() {
                              adminApproval = value;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(flex: 1),
                  Expanded(
                    flex: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Default Tags',
                          style: textLargeSize,
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 0.5 * defaultPadding),
                        Expanded(child: DefaultTags()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(flex: 1),
                  Expanded(
                    flex: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Custom Tags(limit 3)',
                          style: textLargeSize,
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 0.5 * defaultPadding),
                        Expanded(child: DefaultTags()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Delete the Group'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
