import 'package:demo/constants.dart';
import 'package:demo/models/tag.dart';
import 'package:flutter/material.dart';

typedef PreviewTagCallBack = void Function(Tag tag);

class PreviewTags extends StatefulWidget {
  final List<Tag> tags;
  final List<IconData> tagIcons;
  final bool showActions;
  final bool showEditButton;
  final PreviewTagCallBack? onEditPreviewtag;
  const PreviewTags({
    super.key,
    required this.tags,
    required this.tagIcons,
    required this.showActions,
    required this.showEditButton,
    this.onEditPreviewtag,
  });

  @override
  State<PreviewTags> createState() => _PreviewTagsState();
}

class _PreviewTagsState extends State<PreviewTags> {
  void removePreviewTag(int index) {
    setState(() {
      widget.tags.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.tags.length * (imgHeight + 10),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.tags.length,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            child: Row(
              children: [
                Column(
                  children: [
                    Icon(
                      widget.tagIcons[widget.tags[index].iconId!],
                      size: tagHeight,
                      color: pinkHeavyColor,
                    ),
                    Text(widget.tags[index].name!, style: tagRedTextStyle),
                  ],
                ),
                const Spacer(flex: 1),
                Expanded(
                  flex: 4,
                  child: Text(
                    widget.tags[index].description!,
                    style: textMiddleSize,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                widget.showActions == false
                    ? Container()
                    : Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            widget.showEditButton
                                ? IconButton(
                                    onPressed: (() {
                                      widget.onEditPreviewtag!(
                                          widget.tags[index]);
                                      removePreviewTag(index);
                                    }),
                                    icon: const Icon(Icons.edit_outlined),
                                  )
                                : const Spacer(),
                            IconButton(
                              onPressed: (() {
                                setState(() {
                                  removePreviewTag(index);
                                });
                              }),
                              icon: const Icon(Icons.delete_outline),
                            )
                          ],
                        ),
                      )
              ],
            ),
          );
        },
      ),
    );
  }
}
