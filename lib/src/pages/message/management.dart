import 'dart:io';

import 'package:demo/constants.dart';
import 'package:demo/models/message.dart';
import 'package:demo/models/messages.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Management extends StatefulWidget {
  const Management({super.key});

  @override
  State<Management> createState() => _ManagementState();
}

String getText(bool hasAccept) {
  if (!hasAccept) {
    return "denied by you";
  }

  return "accepted by you";
}

class _ManagementState extends State<Management> {
  static final Message loadingTag =
      Message(id: "loadingTag", type: -1, hasRead: true);
  var _messagesName = <Message>[loadingTag];
  int pageOffset = 0;
  int totalCount = 0;
  bool initialized = false;

  @override
  void initState() {
    super.initState();
    _retrieveData();
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: _messagesName.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (_messagesName[index].type == loadingTag.type) {
                        if (_messagesName.length - 1 < totalCount) {
                          _retrieveData();
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
                      return Slidable(
                        enabled: !_messagesName[index].hasRead,
                        closeOnScroll: true,
                        startActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                setState(() {
                                  _messagesName[index].hasRead = true;
                                  _messagesName[index].content!.hasAccept =
                                      false;
                                });
                              },
                              backgroundColor: pinkHeavyColor,
                              label: 'Deny',
                              autoClose: true,
                            )
                          ],
                        ),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                setState(() {
                                  _messagesName[index].hasRead = true;
                                  _messagesName[index].content!.hasAccept =
                                      true;
                                });
                              },
                              backgroundColor: greenColor,
                              label: 'Accept',
                            )
                          ],
                        ),
                        child: ListTile(
                          tileColor: getBackGroundColor(
                              _messagesName[index].hasRead,
                              _messagesName[index].content!.hasAccept),
                          visualDensity: const VisualDensity(
                            vertical: visualDensityNum,
                          ),
                          title: IntrinsicHeight(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      ClipOval(
                                        child: allUserIcons[_messagesName[index]
                                            .content!
                                            .toUser!
                                            .iconId!],
                                      ),
                                      Expanded(
                                        child: Text(
                                          _messagesName[index]
                                              .content!
                                              .toUser!
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
                                  flex: 2,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      !_messagesName[index].hasRead
                                          ? Row(children: [
                                              const Text(
                                                "invited by",
                                              ),
                                              IntrinsicHeight(
                                                child: Column(
                                                  children: [
                                                    ClipOval(
                                                      child: allUserIcons[
                                                          _messagesName[index]
                                                              .content!
                                                              .fromUser!
                                                              .iconId!],
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        _messagesName[index]
                                                            .content!
                                                            .fromUser!
                                                            .name!,
                                                        style: textMiddleSize,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ])
                                          : Text(
                                              getText(_messagesName[index]
                                                  .content!
                                                  .hasAccept),
                                            ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      ClipOval(
                                        child: allGroupIcons[
                                            _messagesName[index]
                                                .content!
                                                .group!
                                                .iconId!],
                                      ),
                                      Expanded(
                                        child: Text(
                                          _messagesName[index]
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
                            debugPrint("Message ID ${_messagesName[index].id}");
                          },
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(height: 1);
                    },
                  ),
                )
              ],
            ),
    );
  }

  Future<void> _pullRefresh() async {
    pageOffset = 0;
    _messagesName = <Message>[loadingTag];
    _retrieveData();
  }

  void _retrieveData() async {
    int? userId = await loadUserId();
    if (userId == null) {
      throw Exception('Failed to get user ID');
    }

    Response response;
    response = await messageDio.get(
        '/messages/$userId?page=$pageOffset&limit=$groupsLoadNum&type=$manageMessageType');
    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Error HTTP Code: ${response.statusCode}');
    }

    Messages messagesResponse = Messages.fromJson(response.data);

    totalCount = messagesResponse.count;
    pageOffset += 1;

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _messagesName.insertAll(
            _messagesName.length - 1, messagesResponse.content!);
        initialized = true;
      });
    });
  }
}
