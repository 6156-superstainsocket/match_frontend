import 'package:demo/constants.dart';
import 'package:demo/models/tag.dart';
import 'package:demo/models/user.dart';
import 'package:flutter/material.dart';

class EditTag extends StatefulWidget {
  final User user;
  final List<Tag> tags;
  final bool? showTags;
  const EditTag({
    super.key,
    required this.user,
    required this.tags,
    this.showTags = true,
  });

  @override
  State<EditTag> createState() => _EditTagState();
}

class _EditTagState extends State<EditTag> {
  User user = User(id: 0);
  bool showContactInfo = false;
  List<Tag> previewTags = [];
  List<Tag> allCustomTags = [];
  List<Tag> allTags = [];

  Map<Tag, bool> checkboxValues = {};

  @override
  void initState() {
    super.initState();
    user = widget.user;

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

    Map<int, Tag> previewTagsMap = {
      for (var item in previewTags) item.id!: item
    };

    // TODO, get allCustomTags from API
    allTags = [...defaultTags, ...allCustomTags];

    for (var i = 0; i < allTags.length; i++) {
      if (previewTagsMap.containsKey(allTags[i].id!)) {
        checkboxValues[allTags[i]] = true;
      } else {
        checkboxValues[allTags[i]] = false;
      }
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
                    onPressed: () {
                      Navigator.pop(context);
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
