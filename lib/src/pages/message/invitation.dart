import 'package:demo/constants.dart';
import 'package:demo/models/message.dart';
import 'package:flutter/material.dart';

class Invitation extends StatefulWidget {
  const Invitation({super.key});

  @override
  State<Invitation> createState() => _InvitationState();
}

class _InvitationState extends State<Invitation> {
  static final Message loadingTag = Message(id: -1, type: 2);
  var _messagesName = <Message>[loadingTag];
  final _fakeMessages = <Message>[
    Message(
      id: 1,
      type: 2,
      userId: 1,
      userIconId: 0,
      userName: "User1",
      groupId: 0,
      groupIconId: 5,
      groupName: "group 333333333333333333333333 56wq57wq7w",
    ),
    Message(
      id: 2,
      type: 2,
      userId: 2,
      userIconId: 9,
      userName: "User2",
      groupId: 9,
      groupIconId: 3,
      groupName: "Group2",
    )
  ];

  @override
  void initState() {
    super.initState();
    // TODO: initial data
    setState(() {
      _messagesName.insertAll(_messagesName.length - 1, _fakeMessages);
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Expanded(
          child: ListView.separated(
            itemCount: _messagesName.length,
            itemBuilder: (BuildContext context, int index) {
              if (_messagesName[index].id == loadingTag.id) {
                if (_messagesName.length - 1 < 15) {
                  // TODO: retrieve data, replace 15 with total groups num
                  _retrieveData();
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
              return ListTile(
                visualDensity: const VisualDensity(
                  vertical: visualDensityNum,
                ),
                title: IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            ClipOval(
                              child: allUserIcons[
                                  _messagesName[index].userIconId!],
                            ),
                            Expanded(
                              child: Text(
                                _messagesName[index].userName!,
                                style: textMiddleSize,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: const [
                            Text('invite you'),
                            Icon(
                              Icons.arrow_right_alt,
                              size: imgWidth,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            ClipOval(
                              child: allGroupIcons[
                                  _messagesName[index].groupIconId!],
                            ),
                            Expanded(
                              child: Text(
                                _messagesName[index].groupName!,
                                style: textMiddleSize,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  debugPrint("Message ID ${_messagesName[index].id}");
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
          ),
        )
      ],
    );
  }

  void _retrieveData() {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      setState(() {
        _messagesName.insertAll(_messagesName.length - 1, _fakeMessages);
      });
    });
  }
}
