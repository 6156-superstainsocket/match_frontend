import 'package:demo/constants.dart';
import 'package:demo/models/tag.dart';
import 'package:demo/src/pages/group/preview_tags.dart';
import 'package:flutter/material.dart';

class EditTag extends StatefulWidget {
  final List<Tag> tags;
  const EditTag({super.key, required this.tags});

  @override
  State<EditTag> createState() => _EditTagState();
}

class _EditTagState extends State<EditTag> {
  final GlobalKey<FormState> _editTagformKey = GlobalKey<FormState>();

  List<Tag> previewTags = [];
  List<Tag> allCustomTags = [];
  List<Tag> allTags = [];
  List<Tag> dropDownTags = [];
  Map<int, Tag> previewTagMap = {};

  @override
  void initState() {
    super.initState();
    if (widget.tags.isNotEmpty) {
      previewTags = widget.tags;
    }

    // TODO, get allCustomTags from API
    allTags = [...defaultTags, ...allCustomTags];
    previewTagMap = {for (var item in previewTags) item.id!: item};

    for (var i = 0; i < allTags.length; i += 1) {
      if (previewTagMap.containsKey(allTags[i].id)) {
        continue;
      }
      dropDownTags.add(allTags[i]);
    }
  }

  void addPreviewTag(Tag tag) {
    setState(() {
      previewTags.add(tag);
    });
  }

  void removewPreviewTag(int index) {
    setState(() {
      previewTags.removeAt(index);
    });
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
              child: Form(
                key: _editTagformKey,
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      const Spacer(flex: 1),
                      Expanded(
                        flex: 10,
                        child: IntrinsicHeight(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PreviewTags(
                                tags: previewTags,
                                tagIcons: allTagIcons,
                                showActions: true,
                                showEditButton: false,
                              ),
                              // dropDownTags.isEmpty
                              //     ? Container()
                              //     : DropdownButtonFormField(
                              //         items: dropDownTags
                              //             .map<DropdownMenuItem<Tag>>(
                              //                 (Tag value) {
                              //           return DropdownMenuItem<Tag>(
                              //             value: value,
                              //             child: Text(value),
                              //           );
                              //         }).toList(),
                              //         onChanged: (Object? value) {
                              //           setState(() {});
                              //         },
                              //       ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(flex: 1),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
