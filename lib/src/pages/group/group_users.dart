import 'dart:io';

import 'package:demo/constants.dart';
import 'package:demo/models/group_user.dart';
import 'package:demo/models/group_user_list_response.dart';
import 'package:demo/models/tag.dart';
import 'package:demo/models/user.dart';
import 'package:demo/src/pages/group/edit_tag.dart';
import 'package:demo/src/pages/group/overview_menu.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class GroupUsers extends StatefulWidget {
  const GroupUsers({
    super.key,
    required this.groupId,
    required this.groupIconId,
    required this.groupName,
    required this.groupDescription,
    required this.isAdmin,
  });

  final int groupId;
  final int groupIconId;
  final String groupName;
  final String groupDescription;
  final bool isAdmin;

  @override
  State<GroupUsers> createState() => _GroupUsersState();
}

class _GroupUsersState extends State<GroupUsers> {
  static final GroupUser loadingTag = GroupUser(
      user: User(userId: -1, name: "", iconId: -1, email: "", id: -1));
  var _users = <GroupUser>[loadingTag];
  String searchString = "";
  int pageOffset = 0;
  int totalCount = 0;

  @override
  void initState() {
    super.initState();
    _retrieveGroupUserData();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OverviewMenu(
        groupIconId: widget.groupIconId,
        groupName: widget.groupName,
        groupDescription: widget.groupDescription,
        groupId: widget.groupId,
        isAdmin: widget.isAdmin,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: defaultPadding, right: 0.5 * defaultPadding),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchString = value.toLowerCase();
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Search',
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Groups List
          Expanded(
            child: ListView.separated(
                itemCount: _users.length,
                itemBuilder: (context, index) {
                  // reach bottom
                  if (_users[index].user!.userId == loadingTag.user!.userId) {
                    if (_users.length - 1 < totalCount) {
                      _retrieveGroupUserData();
                      return Container(
                        padding: const EdgeInsets.all(defaultPadding),
                        alignment: Alignment.center,
                        child: const SizedBox(
                          width: 24.0,
                          height: 24.0,
                          child: CircularProgressIndicator(strokeWidth: 2.0),
                        ),
                      );
                    } else {
                      return Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(defaultPadding),
                        child: const Text(
                          "Hit Bottom",
                          style: TextStyle(color: greyColor),
                        ),
                      );
                    }
                  }
                  return ("${_users[index].user!.name}")
                          .toLowerCase()
                          .contains(searchString)
                      ? ListTile(
                          visualDensity: const VisualDensity(
                            vertical: visualDensityNum,
                          ),
                          leading: ClipOval(
                            child: allUserIcons[_users[index].user!.iconId!],
                          ),
                          title: Row(
                            children: [
                              Text(
                                "${_users[index].user!.name}",
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0.5 * defaultPadding),
                              ),
                              (_users[index].tags != null &&
                                      _users[index].tags!.isNotEmpty)
                                  ? Expanded(
                                      flex: 4,
                                      child: SizedBox(
                                        height: imgHeight,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: _users[index].tags!.length,
                                          itemBuilder: (BuildContext context,
                                              int tagIndex) {
                                            Tag userTag =
                                                _users[index].tags![tagIndex];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal:
                                                          0.5 * defaultPadding),
                                              child: Column(
                                                children: [
                                                  Icon(
                                                    allTagIcons[
                                                        userTag.iconId!],
                                                    size: tagMiniHeight,
                                                    color: userTag.isMatch!
                                                        ? pinkHeavyColor
                                                        : greyHeavyColor,
                                                  ),
                                                  Text(
                                                    userTag.name!,
                                                    style: userTag.isMatch!
                                                        ? tagRedTextStyle
                                                        : tagBlackTextStyle,
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                          onTap: () => {
                            debugPrint("User ID ${_users[index].user!.userId}"),
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                return FractionallySizedBox(
                                  heightFactor: popContainerHeightFactor,
                                  child: EditTag(
                                    user: _users[index].user!,
                                    tags: _users[index].tags!,
                                  ),
                                );
                              },
                            )
                          },
                        )
                      : Container();
                },
                separatorBuilder: (context, index) {
                  return ("${_users[index].user!.name}")
                          .toLowerCase()
                          .contains(searchString)
                      ? const Divider(
                          height: 1,
                          color: greyBackground,
                        )
                      : Container();
                }),
          ),
        ],
      ),
    );
  }

  void _retrieveGroupUserData() async {
    Response response;
    response = await groupDio.get(
        '/groups/${widget.groupId}/users?offset=$pageOffset&limit=$groupUsersLoadNum');
    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Error HTTP Code: ${response.statusCode}');
    }

    GroupUserListResponse groupUserListResponse =
        GroupUserListResponse.fromJson(response.data);

    totalCount = groupUserListResponse.count!;
    pageOffset += groupUsersLoadNum;

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _users.insertAll(_users.length - 1, groupUserListResponse.results!);
      });
    });
  }
}
