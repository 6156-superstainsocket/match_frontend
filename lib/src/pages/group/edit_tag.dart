import 'dart:io';

import 'package:demo/constants.dart';
import 'package:demo/models/customresponse.dart';
import 'package:demo/models/tag.dart';
import 'package:demo/models/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class EditTag extends StatefulWidget {
  final User user;
  final List<Tag> tags;
  final bool? showTags;
  final List<Tag>? allTags;
  final int? groupId;
  const EditTag({
    super.key,
    required this.user,
    required this.tags,
    this.showTags = true,
    this.allTags,
    this.groupId,
  });

  @override
  State<EditTag> createState() => _EditTagState();
}

class _EditTagState extends State<EditTag> {
  User user = User(id: 0);
  bool showContactInfo = false;
  List<Tag> previewTags = [];
  List<Tag> allTags = [];
  int myUserId = 0;
  Map<Tag, bool> checkboxValues = {};

  void _retrieveUserId() async {
    int? currentUserId = await loadUserId();
    if (currentUserId != null) {
      setState(() {
        myUserId = currentUserId;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    user = widget.user;
    _retrieveUserId();

    if (widget.allTags != null) {
      allTags = widget.allTags!;
      Map<int, Tag> previewTagsMap = {
        for (var item in previewTags) item.id!: item
      };
      for (var i = 0; i < widget.allTags!.length; i++) {
        if (previewTagsMap.containsKey(widget.allTags![i].id!)) {
          checkboxValues[widget.allTags![i]] = true;
          allTags[i].isMatch = previewTagsMap[widget.allTags![i].id!]!.isMatch;
        } else {
          checkboxValues[widget.allTags![i]] = false;
        }
      }
    }

    if (widget.tags.isNotEmpty) {
      previewTags = widget.tags;
    }

    if (widget.showTags! == false) {
      showContactInfo = true;
    } else {
      for (var i = 0; i < previewTags.length; i++) {
        if (previewTags[i].isMatch!) {
          showContactInfo = true;
          break;
        }
      }
    }
  }

  Future<void> updateTags(int userId) async {
    List<int> tagIds = [];
    checkboxValues.forEach((key, value) {
      if (value) {
        tagIds.add(key.id!);
      }
    });
    Response response = await groupDio.put('/likes', data: {
      "uid_from": myUserId,
      "uid_to": user.userId,
      "tagIds": tagIds,
      "groupId": widget.groupId,
    });
    CustomResponse data = CustomResponse.fromJson(response.data);
    if (response.statusCode != HttpStatus.ok) {
      throw Exception('error: ${data.detail}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close_outlined));
          },
        ),
        toolbarHeight: topMenuBarHeight,
        actions: widget.showTags!
            ? [
                TextButton(
                    onPressed: () async {
                      try {
                        await updateTags(user.userId).whenComplete(() {
                          Navigator.pop(context, true);
                        });
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.toString())),
                        );
                      }
                    },
                    child: const Text('Save'))
              ]
            : null,
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(flex: 1),
                  Expanded(
                    flex: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: defaultPadding),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: Image.asset(
                                "$assetUserPath${(user.iconId! + 1).toString()}.png",
                                width: profileImgWidth,
                                height: profileImgHeight,
                                fit: BoxFit.scaleDown,
                              ),
                            )
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 0.5 * defaultPadding),
                          child: Divider(),
                        ),
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Name',
                                    style: textMiddleSize,
                                    textAlign: TextAlign.left,
                                  ),
                                  const SizedBox(height: 0.5 * defaultPadding),
                                  Expanded(
                                    child:
                                        Text(user.name!, style: textLargeSize),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 0.5 * defaultPadding),
                          child: Divider(),
                        ),
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Description',
                                    style: textMiddleSize,
                                    textAlign: TextAlign.left,
                                  ),
                                  const SizedBox(height: 0.5 * defaultPadding),
                                  Expanded(
                                    child: Text(user.description!,
                                        style: textLargeSize),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 0.5 * defaultPadding),
                          child: Divider(),
                        ),
                        showContactInfo
                            ? Column(
                                children: [
                                  IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Email',
                                              style: textMiddleSize,
                                              textAlign: TextAlign.left,
                                            ),
                                            const SizedBox(
                                                height: 0.5 * defaultPadding),
                                            Expanded(
                                              child: Text(user.email!,
                                                  style: textLargeSize),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 0.5 * defaultPadding),
                                    child: Divider(),
                                  ),
                                  IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Phone',
                                              style: textMiddleSize,
                                              textAlign: TextAlign.left,
                                            ),
                                            const SizedBox(
                                                height: 0.5 * defaultPadding),
                                            Expanded(
                                              child: Text(user.phone!,
                                                  style: textLargeSize),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 0.5 * defaultPadding),
                                    child: Divider(),
                                  ),
                                ],
                              )
                            : Container(),
                        widget.showTags!
                            ? IntrinsicHeight(
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          'Tags',
                                          style: textMiddleSize,
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 0.5 * defaultPadding),
                        ),
                        widget.showTags!
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: allTags.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Tag key =
                                      checkboxValues.keys.elementAt(index);
                                  return CheckboxListTile(
                                    enabled: key.isMatch == false,
                                    title: Row(
                                      children: [
                                        Column(
                                          children: [
                                            Icon(
                                              allTagIcons[key.iconId!],
                                              size: tagHeight,
                                              color: key.isMatch!
                                                  ? pinkHeavyColor
                                                  : greyHeavyColor,
                                            ),
                                            Text(key.name!,
                                                style: key.isMatch!
                                                    ? tagRedTextStyle
                                                    : tagBlackTextStyle),
                                          ],
                                        ),
                                        const Spacer(flex: 1),
                                        Expanded(
                                          flex: 4,
                                          child: Text(
                                            key.description!,
                                            style: textMiddleSize,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    value: checkboxValues[key],
                                    onChanged: ((value) {
                                      setState(() {
                                        checkboxValues[key] = value!;
                                      });
                                    }),
                                  );
                                },
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  const Spacer(flex: 1),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
