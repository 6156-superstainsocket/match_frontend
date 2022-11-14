import 'package:demo/constants.dart';
import 'package:demo/models/tag.dart';
import 'package:flutter/material.dart';

class EditTag extends StatefulWidget {
  final List<Tag> tags;
  const EditTag({super.key, required this.tags});

  @override
  State<EditTag> createState() => _EditTagState();
}

class _EditTagState extends State<EditTag> {
  List<Tag> previewTags = [];
  List<Tag> allCustomTags = [];
  List<Tag> allTags = [];

  Map<Tag, bool> checkboxValues = {};

  @override
  void initState() {
    super.initState();
    if (widget.tags.isNotEmpty) {
      previewTags = widget.tags;
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
        title: const Text('Edit Tags'),
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
        actions: [
          TextButton(
              onPressed: () {
                debugPrint('${previewTags.length}');
                Navigator.pop(context);
              },
              child: const Text('Save'))
        ],
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
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: allTags.length,
                          itemBuilder: (BuildContext context, int index) {
                            Tag key = checkboxValues.keys.elementAt(index);
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
                        ),
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
