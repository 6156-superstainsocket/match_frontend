import 'package:demo/models/group.dart';
import 'package:demo/src/pages/group/custom_tags.dart';
import 'package:demo/src/pages/group/default_tags.dart';
import 'package:demo/src/pages/utils/icon_picker.dart';
import 'package:flutter/material.dart';
import 'package:demo/constants.dart';

class AdminSetting extends StatefulWidget {
  const AdminSetting({super.key, required this.id});

  final int id;

  @override
  State<AdminSetting> createState() => _AdminSettingState();
}

class _AdminSettingState extends State<AdminSetting> {
  Group groupSetting = Group(id: 0);

  @override
  void initState() {
    // TODO: fill group information
    super.initState();
    groupSetting.id = widget.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Setting'),
        centerTitle: true,
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close_outlined));
          },
        ),
        toolbarHeight: topMenuBarHeight,
        actions: [
          TextButton(
              onPressed: () {
                // TODO save the change
                Navigator.pop(context);
              },
              child: const Text('Save'))
        ],
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: SettingForm(
                  groupSetting: groupSetting,
                  onSettingFormChanged: (group) {
                    setState(() {
                      groupSetting = group;
                    });
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

typedef SettingFormCallBack = void Function(Group group);

class SettingForm extends StatefulWidget {
  final Group groupSetting;
  final SettingFormCallBack onSettingFormChanged;
  const SettingForm({
    super.key,
    required this.groupSetting,
    required this.onSettingFormChanged,
  });

  @override
  State<SettingForm> createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  final GlobalKey<FormState> _adminSettingformKey = GlobalKey<FormState>();
  // TODO: fill group information
  Group changedGroupSetting = Group(id: 0);

  @override
  void initState() {
    super.initState();
    changedGroupSetting = widget.groupSetting;
  }

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
                            widget.onSettingFormChanged(changedGroupSetting);
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
                          widget.onSettingFormChanged(changedGroupSetting);
                        },
                        icon: allGroupIcons[changedGroupSetting.iconId!],
                      ),
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
                          widget.onSettingFormChanged(changedGroupSetting);
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
                      widget.onSettingFormChanged(changedGroupSetting);
                    },
                  ),
                ),
                const Spacer(flex: 1),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: ElevatedButton(
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Delete the Group'),
                  content:
                      const Text('Are you sure you wanna delete the group?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        // TODO delete the group
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
              child: const Text('Delete the Group'),
            ),
          ),
        ],
      ),
    );
  }
}
