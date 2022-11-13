import 'package:demo/src/pages/group/default_tags.dart';
import 'package:flutter/material.dart';
import 'package:demo/constants.dart';
import 'package:demo/models/group.dart';

class MemberSetting extends StatefulWidget {
  const MemberSetting({super.key});

  @override
  State<MemberSetting> createState() => _MemberSettingState();
}

class _MemberSettingState extends State<MemberSetting> {
  Group groupSetting = Group();

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
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: MemberSettingForm(
                  groupSetting: groupSetting,
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        elevation: 0,
        child: ElevatedButton(
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Quit the Group'),
              content: const Text('Are you sure you wanna quit the group?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    // TODO quit the group
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          ),
          child: const Text('Quit the Group'),
        ),
      ),
    );
  }
}

class MemberSettingForm extends StatefulWidget {
  final Group groupSetting;
  const MemberSettingForm({
    super.key,
    required this.groupSetting,
  });

  @override
  State<MemberSettingForm> createState() => _MemberSettingFormState();
}

class _MemberSettingFormState extends State<MemberSettingForm> {
  Group changedGroupSetting = Group();

  @override
  void initState() {
    super.initState();
    changedGroupSetting = widget.groupSetting;
    changedGroupSetting.customTags = [];
    if (widget.groupSetting.customTags != null &&
        widget.groupSetting.customTags!.isNotEmpty) {
      changedGroupSetting.customTags = [
        ...defaultTags,
        ...widget.groupSetting.customTags!
      ];
    } else {
      changedGroupSetting.customTags = defaultTags;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                      child: Text(changedGroupSetting.description!),
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
                    allGroupIcons[changedGroupSetting.iconId!],
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    changedGroupSetting.allowWithoutApproval!
                        ? const Text(
                            'Yes',
                            style: textMiddleSize,
                          )
                        : const Text(
                            'No',
                            style: textMiddleSize,
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
                flex: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tags',
                      style: textLargeSize,
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 0.5 * defaultPadding),
                    Expanded(
                        child:
                            DefaultTags(tags: changedGroupSetting.customTags!)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
