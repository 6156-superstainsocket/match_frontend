import 'package:demo/constants.dart';
import 'package:demo/models/tag.dart';
import 'package:demo/src/pages/group/preview_tags.dart';
import 'package:demo/src/pages/group/update_tag.dart';
import 'package:flutter/material.dart';

typedef CustomTagsCallBack = void Function(List<Tag> tags);

class CustomTags extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final CustomTagsCallBack onCustomTagChanged;
  final List<Tag>? previousCustomTags;
  const CustomTags({
    super.key,
    required this.formKey,
    this.previousCustomTags,
    required this.onCustomTagChanged,
  });

  @override
  State<CustomTags> createState() => _CustomTagsState();
}

class _CustomTagsState extends State<CustomTags> {
  List<Tag> previewTags = [];

  @override
  void initState() {
    super.initState();
    if (widget.previousCustomTags != null &&
        widget.previousCustomTags!.isNotEmpty) {
      previewTags = widget.previousCustomTags!;
    }
  }

  List<Tag> globalTagList = [];

  void updateTag(Tag newTag, int index) {
    setState(() {
      if (globalTagList.length <= index) {
        globalTagList.add(Tag());
      }
      globalTagList[index] = newTag;
    });
  }

  void addPreviewTag(Tag tag) {
    setState(() {
      previewTags.add(tag);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Custom Tags(limit 3)',
              style: textLargeSize,
              textAlign: TextAlign.left,
            ),
            const Spacer(),
            IconButton(
              onPressed: () async {
                if (previewTags.length >= 3) {
                  const snackBar = SnackBar(
                    content: Text(
                      'Custom Tag Limit 3!',
                      style: tagRedTextStyle,
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  return;
                }

                Tag? newTag = await showUpdateTag(
                  context: context,
                  action: 'Add',
                );

                if (newTag != null &&
                    newTag.name != '' &&
                    newTag.description != '') {
                  addPreviewTag(newTag);
                }

                widget.onCustomTagChanged(previewTags);
              },
              icon: const Icon(Icons.add_circle_outline),
            ),
          ],
        ),
        const SizedBox(height: 0.5 * defaultPadding),
        IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PreviewTags(
                tags: previewTags,
                tagIcons: allTagIcons,
                showActions: true,
                showEditButton: true,
                onEditPreviewtag: (tag) async {
                  Tag? newTag = await showUpdateTag(
                    oldTag: tag,
                    context: context,
                    action: 'Edit',
                  );
                  if (newTag != null &&
                      newTag.name != '' &&
                      newTag.description != '') {
                    addPreviewTag(newTag);
                  }
                  widget.onCustomTagChanged(previewTags);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
