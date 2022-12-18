import 'dart:io';

import 'package:demo/models/group.dart';
import 'package:demo/src/pages/group/admin_setting.dart';
import 'package:demo/src/pages/group/group_invite.dart';
import 'package:demo/src/pages/group/member_setting.dart';
import 'package:dio/dio.dart';
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
  Group groupInfo = Group(id: 0);
  bool isGroupInfoChanged = false;

  @override
  void initState() {
    super.initState();
    groupInfo.id = widget.groupId;
    groupInfo.iconId = widget.groupIconId;
    groupInfo.name = widget.groupName;
    groupInfo.description = widget.groupDescription;
  }

  Future<Group> getGroupInfo(int groupId) async {
    Response response;
    response = await groupDio.get('/groups/$groupId');

    Group data = Group.fromJson(response.data);
    if (response.statusCode != HttpStatus.ok) {
      throw Exception('error: ${data.detail}');
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(children: [
        Column(children: [
          allGroupIcons[groupInfo.iconId!],
          const Text('xx members',
              textAlign: TextAlign.left, style: textSmallSize)
        ]),
        Expanded(
          child: Column(
            children: [
              Text(groupInfo.name!,
                  textAlign: TextAlign.left, style: textLargeSize),
              Text(groupInfo.description!,
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
                Navigator.pop(context, isGroupInfoChanged);
              },
              icon: const Icon(Icons.arrow_back_ios_new));
        },
      ),
      actions: [
        IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return FractionallySizedBox(
                    heightFactor: popContainerHeightFactor,
                    child: GroupInvite(groupId: widget.groupId),
                  );
                },
              );
            },
            icon: const Icon(Icons.add_circle_outline)),
        IconButton(
            onPressed: () async {
              try {
                await getGroupInfo(widget.groupId).then((value) async {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return FractionallySizedBox(
                        heightFactor: popContainerHeightFactor,
                        child: widget.isAdmin
                            ? AdminSetting(
                                groupSetting: value,
                              )
                            : MemberSetting(
                                groupSetting: value,
                              ),
                      );
                    },
                  ).then((refresh) async {
                    if (refresh != null && refresh) {
                      await getGroupInfo(widget.groupId).then(
                        (value) {
                          setState(() {
                            groupInfo = value;
                            isGroupInfoChanged = true;
                          });
                        },
                      );
                    }
                  });
                });
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(e.toString())),
                );
              }
            },
            icon: const Icon(Icons.settings_outlined)),
      ],
    );
  }
}
