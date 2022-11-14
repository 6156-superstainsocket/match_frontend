import 'package:demo/src/pages/group/admin_setting.dart';
import 'package:demo/src/pages/group/member_setting.dart';
import 'package:flutter/material.dart';
import 'package:demo/constants.dart';

class OverviewMenu extends StatefulWidget implements PreferredSizeWidget {
  const OverviewMenu(
      {super.key,
      required this.groupId,
      required this.isAdmin,
      required this.groupIconId,
      required this.groupName,
      required this.groupDescription});

  final int groupId;
  final bool isAdmin;
  final int groupIconId;
  final String groupName;
  final String groupDescription;

  @override
  State<OverviewMenu> createState() => _OverviewMenuState();

  @override
  Size get preferredSize => const Size.fromHeight(topMenuBarHeight);
}

class _OverviewMenuState extends State<OverviewMenu> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(children: [
        Column(children: [
          // const Padding(padding: EdgeInsets.only(top: 0.5 * defaultPadding)),
          allGroupIcons[widget.groupIconId],
          const Text('xx members',
              textAlign: TextAlign.left, style: textSmallSize)
        ]),
        Expanded(
          child: Column(
            children: [
              Text(widget.groupName,
                  textAlign: TextAlign.left, style: textLargeSize),
              Text(widget.groupDescription,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  style: textSmallSize),
            ],
          ),
        ),
      ]),
      centerTitle: false,
      toolbarHeight: topMenuBarHeight,
      elevation: 0,
      leading: Builder(
        builder: (context) {
          return IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new));
        },
      ),
      actions: [
        IconButton(
            onPressed: () {}, icon: const Icon(Icons.add_circle_outline)),
        IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return FractionallySizedBox(
                    heightFactor: popContainerHeightFactor,
                    // TODO: replace 0 with group id
                    child: widget.isAdmin
                        ? AdminSetting(
                            groupId: widget.groupId,
                          )
                        : MemberSetting(
                            groupId: widget.groupId,
                          ),
                  );
                },
              );
            },
            icon: const Icon(Icons.settings_outlined)),
      ],
    );
  }
}
