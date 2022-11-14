import 'package:demo/constants.dart';
import 'package:demo/models/tag.dart';
import 'package:demo/models/user.dart';
import 'package:demo/src/pages/group/edit_tag.dart';
import 'package:demo/src/pages/group/overview_menu.dart';
import 'package:flutter/material.dart';

class GroupUsers extends StatefulWidget {
  const GroupUsers(
      {super.key,
      required this.groupId,
      required this.groupIconId,
      required this.groupName,
      required this.groupDescription});

  final int groupId;
  final int groupIconId;
  final String groupName;
  final String groupDescription;

  @override
  State<GroupUsers> createState() => _GroupUsersState();
}

class _GroupUsersState extends State<GroupUsers> {
  static final User loadingTag =
      User(id: -1, firstName: "", lastName: "", iconId: -1, email: "");
  var _users = <User>[loadingTag];
  final _fakeUsers = <User>[
    User(
        id: 1,
        firstName: "user",
        lastName: "1",
        email: "user1@xxx.com",
        iconId: 1,
        tags: defaultTags),
    User(
        id: 2,
        firstName: "user",
        lastName: "2",
        email: "user1@xxx.com",
        iconId: 2),
    User(
        id: 3,
        firstName: "user",
        lastName: "3",
        email: "user1@xxx.com",
        iconId: 3),
    User(
        id: 4,
        firstName: "user",
        lastName: "4",
        email: "user1@xxx.com",
        iconId: 4),
    User(
        id: 5,
        firstName: "user",
        lastName: "5",
        email: "user1@xxx.com",
        iconId: 5),
  ];
  String searchString = "";

  @override
  void initState() {
    super.initState();
    // TODO: initial data
    setState(() {
      _users.insertAll(_users.length - 1, _fakeUsers);
    });
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
        isAdmin: true,
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
                  padding: const EdgeInsets.only(left: 15.0, right: 7.0),
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
                  if (_users[index].id == loadingTag.id) {
                    if (_users.length - 1 < 15) {
                      // TODO: retrieve data, replace 15 with total groups user num
                      _retrieveGroupUserData();
                      return Container(
                        padding: const EdgeInsets.all(16.0),
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
                        padding: const EdgeInsets.all(16.0),
                        child: const Text(
                          "Hit Bottom",
                          style: TextStyle(color: greyColor),
                        ),
                      );
                    }
                  }
                  return ("${_users[index].firstName} ${_users[index].lastName}")
                          .toLowerCase()
                          .contains(searchString)
                      ? ListTile(
                          visualDensity: const VisualDensity(
                            vertical: visualDensityNum,
                          ),
                          leading: ClipOval(
                            child: allUserIcons[_users[index].iconId!],
                          ),
                          title: Row(
                            children: [
                              Text(
                                "${_users[index].firstName} ${_users[index].lastName}",
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
                            debugPrint("User ID ${_users[index].id}"),
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                return FractionallySizedBox(
                                  heightFactor: popContainerHeightFactor,
                                  child: EditTag(
                                    userId: _users[index].id,
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
                  return ("${_users[index].firstName} ${_users[index].lastName}")
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

  void _retrieveGroupUserData() {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      setState(() {
        _users.insertAll(_users.length - 1, _fakeUsers);
      });
    });
  }
}