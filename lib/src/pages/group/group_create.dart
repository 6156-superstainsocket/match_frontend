import 'dart:io';

import 'package:demo/constants.dart';
import 'package:demo/models/group.dart';
import 'package:demo/src/pages/group/custom_tags.dart';
import 'package:demo/src/pages/group/default_tags.dart';
import 'package:demo/src/pages/utils/icon_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class GroupCreate extends StatefulWidget {
  const GroupCreate({super.key});

  @override
  State<GroupCreate> createState() => _GroupCreateState();
}

class _GroupCreateState extends State<GroupCreate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Create Group'),
        centerTitle: true,
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                icon: const Icon(Icons.close_outlined));
          },
        ),
        toolbarHeight: topMenuBarHeight,
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: const IntrinsicHeight(
                child: SettingForm(),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SettingForm extends StatefulWidget {
  const SettingForm({super.key});

  @override
  State<SettingForm> createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  final GlobalKey<FormState> _adminSettingformKey = GlobalKey<FormState>();
  Group changedGroupSetting = Group(id: -1);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _adminSettingformKey,
      child: Column(
        children: [
          const SizedBox(height: defaultPadding),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(flex: 1),
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Name',
                        style: textLargeSize,
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 0.5 * defaultPadding),
                      Expanded(
                        child: TextFormField(
                          initialValue: changedGroupSetting.name,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          style: textMiddleSize,
                          onChanged: (value) {
                            setState(() {
                              changedGroupSetting.name = value;
                            });
                          },
                          validator: (value) {
                            return value!.trim().isNotEmpty
                                ? null
                                : "Please enter group name";
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      const Text('Image', style: textLargeSize),
                      const SizedBox(height: 0.5 * defaultPadding),
                      IconButton(
                        iconSize: imgHeight,
                        onPressed: () async {
                          int? result = await showIconPicker(
                            context: context,
                            defalutIconId: changedGroupSetting.iconId,
                            isIcon: false,
                            svgs: allGroupIcons,
                          );
                          setState(() {
                            changedGroupSetting.iconId = result!;
                          });
                        },
                        icon: allGroupIcons[changedGroupSetting.iconId!],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(flex: 1),
                Expanded(
                  flex: 10,
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
                          initialValue: changedGroupSetting.description,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          style: textMiddleSize,
                          onChanged: (value) {
                            setState(() {
                              changedGroupSetting.description = value;
                            });
                          },
                          validator: (value) {
                            return value!.trim().isNotEmpty
                                ? null
                                : "Please enter group description";
                          },
                        ),
                      )
                    ],
                  ),
                ),
                const Spacer(flex: 1),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 0.5 * defaultPadding),
            child: Divider(),
          ),
          IntrinsicHeight(
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
                        value: changedGroupSetting.allowWithoutApproval!,
                        activeColor: greenColor,
                        onChanged: (bool value) {
                          setState(() {
                            changedGroupSetting.allowWithoutApproval = value;
                          });
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 0.5 * defaultPadding),
            child: Divider(),
          ),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(flex: 1),
                Expanded(
                  flex: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Default Tags',
                        style: textLargeSize,
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 0.5 * defaultPadding),
                      Expanded(child: DefaultTags(tags: defaultTags)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 0.5 * defaultPadding),
            child: Divider(),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(flex: 1),
                Expanded(
                  flex: 10,
                  child: CustomTags(
                    formKey: _adminSettingformKey,
                    previousCustomTags: changedGroupSetting.customTags,
                    onCustomTagChanged: (tags) {
                      setState(() {
                        changedGroupSetting.customTags = tags;
                      });
                    },
                  ),
                ),
                const Spacer(flex: 1),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: defaultPadding),
            child: ElevatedButton(
              onPressed: () {
                if (_adminSettingformKey.currentState!.validate()) {
                  // TODO: send data
                  // debugPrint("Group ID: ${changedGroupSetting.id}");
                  // debugPrint("Group Name: ${changedGroupSetting.name}");
                  // debugPrint(
                  //     "Group Description: ${changedGroupSetting.description}");
                  // debugPrint(
                  //     "Group Allow: ${changedGroupSetting.allowWithoutApproval}");
                  // debugPrint("Group Icon ID: ${changedGroupSetting.iconId}");
                  _sendGroupData()
                      .whenComplete(() => Navigator.of(context).pop(true));
                }
              },
              child: const Text('Create'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _sendGroupData() async {
    Response response;
    response =
        await groupDio.post('/groups', data: changedGroupSetting.toJson());
    if (response.statusCode != HttpStatus.created) {
      throw Exception('Error HTTP Code: ${response.statusCode}');
    }
  }
}
