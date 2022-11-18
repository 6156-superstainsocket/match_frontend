import 'package:demo/constants.dart';
import 'package:demo/models/message.dart';
import 'package:demo/src/pages/group/edit_tag.dart';
import 'package:flutter/material.dart';

class MessageMatched extends StatefulWidget {
  const MessageMatched({super.key});

  @override
  State<MessageMatched> createState() => _MessageMatchedState();
}

class _MessageMatchedState extends State<MessageMatched> {
  String fakeResponse =
      '{"count":1,"data":[{"userId":1,"tagId":2,"groupId":8,"hasRead":false,"type":1,"userName":"User1","userIconId":10,"groupName":"Group1","groupIconId":10,"tagIconId":3,"tagName":"like"}]}';
  static final Message loadingTag = Message(id: -1, type: 1);
  var _messagesMatch = <Message>[loadingTag];
  final _fakeMessages = <Message>[
    Message(
      id: 1,
      userId: 1,
      userName: "user 1",
      userIconId: 1,
      tagId: 1,
      tagName: "tag 1",
      tagIconId: 1,
      groupId: 1,
      groupName: "group 1",
      groupIconId: 1,
      type: 1,
    ),
    Message(
      id: 2,
      userId: 2,
      userName: "user 2",
      userIconId: 2,
      tagId: 2,
      tagName: "tag 2",
      tagIconId: 2,
      groupId: 2,
      groupName: "group 2",
      groupIconId: 2,
      type: 2,
    ),
    Message(
      id: 3,
      userId: 3,
      userName: "user 3",
      userIconId: 3,
      tagId: 3,
      tagName: "tag 3",
      tagIconId: 3,
      groupId: 3,
      groupName: "group 3",
      groupIconId: 3,
      type: 3,
    ),
  ];

  @override
  void initState() {
    super.initState();
    // TODO: initial data
    setState(() {
      _messagesMatch.insertAll(_messagesMatch.length - 1, _fakeMessages);
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
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: _messagesMatch.length,
            itemBuilder: ((context, index) {
              // reach bottom
              if (_messagesMatch[index].id == loadingTag.id) {
                if (_messagesMatch.length - 1 < 6) {
                  // TODO: retrieve data, replace 15 with total groups num
                  _retrieveMatchData();
                  return Container(
                    alignment: Alignment.center,
                    child: const SizedBox(
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
                tileColor: _messagesMatch[index].hasRead!
                    ? Colors.white
                    : pinkLightColor,
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
                                  _messagesMatch[index].userIconId!],
                            ),
                            Expanded(
                              child: Text(
                                _messagesMatch[index].userName!,
                                style: textMiddleSize,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IntrinsicHeight(
                              child: Column(
                                children: [
                                  Icon(
                                    allTagIcons[
                                        _messagesMatch[index].tagIconId!],
                                    color: pinkHeavyColor,
                                    size: tagHeight,
                                  ),
                                  Expanded(
                                    child: Text(
                                      _messagesMatch[index].tagName!,
                                      style: tagMiniRedTextStyle,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Text('in'),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            ClipOval(
                              child: allGroupIcons[
                                  _messagesMatch[index].groupIconId!],
                            ),
                            Expanded(
                              child: Text(
                                _messagesMatch[index].groupName!,
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
                  debugPrint("User ID ${_messagesMatch[index].userId}");
                  setState(() {
                    _messagesMatch[index].hasRead = true;
                  });
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return FractionallySizedBox(
                        heightFactor: popContainerHeightFactor,
                        child: EditTag(
                          userId: _messagesMatch[index].userId!,
                          tags: const [],
                          showTags: false,
                        ),
                      );
                    },
                  );
                },
              );
            }),
            separatorBuilder: (context, index) {
              return const Divider(height: 1);
            },
          ),
        ),
      ],
    );
  }

  void _retrieveMatchData() {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      setState(() {
        _messagesMatch.insertAll(_messagesMatch.length - 1, _fakeMessages);
      });
    });
  }
}
