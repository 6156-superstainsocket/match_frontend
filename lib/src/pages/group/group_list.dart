import 'dart:io';

import 'package:demo/constants.dart';
import 'package:demo/models/group.dart';
import 'package:demo/models/group_list_response.dart';
import 'package:demo/models/group_user_list_response.dart';
import 'package:demo/src/pages/group/group_create.dart';
import 'package:demo/src/pages/group/group_users.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class GroupList extends StatefulWidget {
  const GroupList({super.key});

  @override
  State<GroupList> createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  static final Group loadingTag = Group(id: -1);
  var _groupsName = <Group>[loadingTag];
  String searchString = "";
  int pageOffset = 0;
  int totalCount = 0;
  int userId = 0;
  int userCount = 0;
  bool initialized = false;

  @override
  void initState() {
    super.initState();
    _retrieveData();
    _retrieveUserId();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _pullRefresh,
      child: !initialized
          ? Container(
              padding: const EdgeInsets.all(defaultPadding),
              alignment: Alignment.center,
              child: const SizedBox(
                width: 24.0,
                height: 24.0,
                child: CircularProgressIndicator(strokeWidth: 2.0),
              ),
            )
          : Column(
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
                          left: defaultPadding,
                          right: 0.5 * defaultPadding,
                        ),
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
                    IconButton(
                      padding: const EdgeInsets.only(
                        left: 0.5 * defaultPadding,
                        right: defaultPadding,
                      ),
                      onPressed: (() => {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                return const FractionallySizedBox(
                                  heightFactor: popContainerHeightFactor,
                                  child: GroupCreate(),
                                );
                              },
                            ).then((refresh) {
                              if (refresh != null && refresh) {
                                setState(() {
                                  pageOffset = 0;
                                  totalCount += 1;
                                  _groupsName = <Group>[loadingTag];
                                });
                              }
                            })
                          }),
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Groups List
                Expanded(
                  child: ListView.separated(
                      itemCount: _groupsName.length,
                      itemBuilder: (context, index) {
                        // reach bottom
                        if (_groupsName[index].id == loadingTag.id) {
                          if (_groupsName.length - 1 < totalCount) {
                            _retrieveData();
                            return Container(
                              padding: const EdgeInsets.all(defaultPadding),
                              alignment: Alignment.center,
                              child: const SizedBox(
                                width: 24.0,
                                height: 24.0,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2.0),
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
                        return _groupsName[index]
                                .name!
                                .toLowerCase()
                                .contains(searchString)
                            ? ListTile(
                                visualDensity: const VisualDensity(
                                  vertical: visualDensityNum,
                                ),
                                leading: ClipOval(
                                  child:
                                      allGroupIcons[_groupsName[index].iconId!],
                                ),
                                title: Text(
                                  _groupsName[index].name!,
                                ),
                                onTap: () {
                                  debugPrint(
                                      "Group ID ${_groupsName[index].id} userId $userId");
                                  _retrieveGroupUserData(_groupsName[index].id)
                                      .whenComplete(() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: ((context) {
                                        return GroupUsers(
                                          groupId: _groupsName[index].id,
                                          groupIconId:
                                              _groupsName[index].iconId!,
                                          groupName: _groupsName[index].name!,
                                          groupDescription:
                                              _groupsName[index].description!,
                                          isAdmin:
                                              _groupsName[index].adminUserId ==
                                                  userId,
                                          memberCount: userCount,
                                          userId: userId,
                                        );
                                      })),
                                    ).then((refresh) {
                                      if (refresh != null && refresh) {
                                        setState(() {
                                          pageOffset = 0;
                                          _groupsName = <Group>[loadingTag];
                                        });
                                      }
                                    });
                                  });
                                },
                              )
                            : Container();
                      },
                      separatorBuilder: (context, index) {
                        return _groupsName[index]
                                .name!
                                .toLowerCase()
                                .contains(searchString)
                            ? const Divider(
                                height: 1,
                              )
                            : Container();
                      }),
                ),
              ],
            ),
    );
  }

  void _retrieveUserId() async {
    int? currentUserId = await loadUserId();
    if (currentUserId != null) {
      setState(() {
        userId = currentUserId;
      });
    }
  }

  Future<void> _pullRefresh() async {
    pageOffset = 0;
    _groupsName = <Group>[loadingTag];
    _retrieveData();
  }

  void _retrieveData() async {
    Response response;
    response = await groupDio.get(
        '/groups?offset=$pageOffset&limit=$groupsLoadNum&order=-created_at');
    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Error HTTP Code: ${response.statusCode}');
    }

    GroupListResponse groupListResponse =
        GroupListResponse.fromJson(response.data);

    totalCount = groupListResponse.count!;
    pageOffset += groupsLoadNum;

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _groupsName.insertAll(
            _groupsName.length - 1, groupListResponse.results!);
        initialized = true;
      });
    });
  }

  Future<void> _retrieveGroupUserData(int groupId) async {
    Response response;
    response = await groupDio.get('/groups/$groupId/users?offset=0&limit=10');
    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Error HTTP Code: ${response.statusCode}');
    }

    GroupUserListResponse groupUserListResponse =
        GroupUserListResponse.fromJson(response.data);
    setState(() {
      userCount = groupUserListResponse.count!;
    });
  }
}
