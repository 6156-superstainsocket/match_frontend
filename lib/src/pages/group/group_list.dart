import 'package:demo/constants.dart';
import 'package:demo/models/group.dart';
import 'package:demo/src/pages/group/group_create.dart';
import 'package:demo/src/pages/group/group_users.dart';
import 'package:flutter/material.dart';

class GroupList extends StatefulWidget {
  const GroupList({super.key});

  @override
  State<GroupList> createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  static final Group loadingTag = Group(id: -1);
  var _groupsName = <Group>[loadingTag];
  final _fakeWords = <Group>[
    Group(id: 1, name: "Group 1", iconId: 1, description: "description 1"),
    Group(id: 2, name: "Group 2", iconId: 2, description: "description 2"),
    Group(id: 3, name: "Group 3", iconId: 3, description: "description 3"),
    Group(id: 4, name: "Group 4", iconId: 4, description: "description 4"),
    Group(id: 5, name: "Group 5", iconId: 5, description: "description 5"),
  ];
  String searchString = "";

  @override
  void initState() {
    super.initState();
    // TODO: initial data
    setState(() {
      _groupsName.insertAll(_groupsName.length - 1, _fakeWords);
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
    return Column(
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
            IconButton(
              padding: const EdgeInsets.only(left: 8.0, right: 15.0),
              onPressed: () => {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return const FractionallySizedBox(
                      heightFactor: popContainerHeightFactor,
                      child: GroupCreate(),
                    );
                  },
                )
              },
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
                  if (_groupsName.length - 1 < 15) {
                    // TODO: retrieve data, replace 15 with total groups num
                    _retrieveData();
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
                return _groupsName[index]
                        .name!
                        .toLowerCase()
                        .contains(searchString)
                    ? ListTile(
                        visualDensity: const VisualDensity(
                          vertical: visualDensityNum,
                        ),
                        leading: CircleAvatar(
                          child: allGroupIcons[_groupsName[index].iconId!],
                        ),
                        title: Text(
                          _groupsName[index].name!,
                        ),
                        onTap: () {
                          debugPrint("Group ID ${_groupsName[index].id}");
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: ((context) {
                              return GroupUsers(
                                groupId: _groupsName[index].id,
                                groupIconId: _groupsName[index].iconId!,
                                groupName: _groupsName[index].name!,
                                groupDescription:
                                    _groupsName[index].description!,
                              );
                            })),
                          );
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
                        color: greyBackground,
                      )
                    : Container();
              }),
        ),
      ],
    );
  }

  void _retrieveData() {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      setState(() {
        _groupsName.insertAll(_groupsName.length - 1, _fakeWords);
      });
    });
  }
}
