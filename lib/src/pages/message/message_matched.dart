import 'dart:io';

import 'package:demo/constants.dart';
import 'package:demo/models/group_user.dart';
import 'package:demo/models/message.dart';
import 'package:demo/models/messages.dart';
import 'package:demo/models/user.dart' as match_user;
import 'package:demo/src/pages/group/edit_tag.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MessageMatched extends StatefulWidget {
  const MessageMatched({super.key});

  @override
  State<MessageMatched> createState() => _MessageMatchedState();
}

class _MessageMatchedState extends State<MessageMatched> {
  static final Message loadingTag =
      Message(id: "loadingTag", type: -1, hasRead: true);
  var _messagesMatch = <Message>[loadingTag];
  int pageOffset = 0;
  int totalCount = 0;
  bool initialized = false;

  @override
  void initState() {
    super.initState();
    _retrieveMatchData();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future<match_user.User?> getGroupUserInfo(int groupId, int userId) async {
    Response response;
    response = await groupDio.get('/groups/$groupId/users/$userId');

    GroupUser data = GroupUser.fromJson(response.data);
    if (response.statusCode != HttpStatus.ok) {
      throw Exception('error: ${data.detail}');
    }
    return data.user;
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
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: _messagesMatch.length,
                    itemBuilder: ((context, index) {
                      // reach bottom
                      if (_messagesMatch[index].type == loadingTag.type) {
                        if (_messagesMatch.length - 1 < totalCount) {
                          _retrieveMatchData();
                          return Container(
                            alignment: Alignment.center,
                            child: const SizedBox(
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
                      return ListTile(
                        tileColor: _messagesMatch[index].hasRead
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
                                      child: allUserIcons[_messagesMatch[index]
                                          .content!
                                          .fromUser!
                                          .iconId!],
                                    ),
                                    Expanded(
                                      child: Text(
                                        _messagesMatch[index]
                                            .content!
                                            .fromUser!
                                            .name!,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IntrinsicHeight(
                                      child: Column(
                                        children: [
                                          Icon(
                                            allTagIcons[_messagesMatch[index]
                                                .content!
                                                .tag!
                                                .iconId!],
                                            color: pinkHeavyColor,
                                            size: tagHeight,
                                          ),
                                          Expanded(
                                            child: Text(
                                              _messagesMatch[index]
                                                  .content!
                                                  .tag!
                                                  .name!,
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
                                      child: allGroupIcons[_messagesMatch[index]
                                          .content!
                                          .group!
                                          .iconId!],
                                    ),
                                    Expanded(
                                      child: Text(
                                        _messagesMatch[index]
                                            .content!
                                            .group!
                                            .name!,
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
                          // debugPrint(
                          //     "User ID ${_messagesMatch[index].content!.fromUser!.userId}");
                          setState(() {
                            _messagesMatch[index].hasRead = true;
                          });
                          try {
                            getGroupUserInfo(
                                    _messagesMatch[index].content!.group!.id,
                                    _messagesMatch[index].content!.fromUser!.id)
                                .then(
                              (value) => showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) {
                                  return FractionallySizedBox(
                                    heightFactor: popContainerHeightFactor,
                                    child: EditTag(
                                      user: value!,
                                      tags: const [],
                                      showTags: false,
                                    ),
                                  );
                                },
                              ),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())),
                            );
                          }
                        },
                      );
                    }),
                    separatorBuilder: (context, index) {
                      return const Divider(height: 1);
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> _pullRefresh() async {
    pageOffset = 0;
    _messagesMatch = <Message>[loadingTag];
    _retrieveMatchData();
  }

  void _retrieveMatchData() async {
    int? userId = await loadUserId();
    if (userId == null) {
      throw Exception('Failed to get user ID');
    }

    Response response;
    response = await messageDio.get(
        '/messages/$userId?page=$pageOffset&limit=$groupsLoadNum&type=$matchMessageType');
    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Error HTTP Code: ${response.statusCode}');
    }

    Messages messagesResponse = Messages.fromJson(response.data);

    totalCount = messagesResponse.count;
    pageOffset += 1;

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _messagesMatch.insertAll(
            _messagesMatch.length - 1, messagesResponse.content!);
        initialized = true;
      });
    });
  }
}
