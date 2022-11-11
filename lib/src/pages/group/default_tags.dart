import 'package:demo/models/tag.dart';
import 'package:demo/src/pages/group/preview_tags.dart';
import 'package:flutter/material.dart';
import 'package:demo/constants.dart';

class DefaultTags extends StatelessWidget {
  final List<Tag> tags;
  const DefaultTags({super.key, required this.tags});

  @override
  Widget build(BuildContext context) {
    return PreviewTags(
      tags: tags,
      tagIcons: allTagIcons,
      showActions: false,
    );
  }
}
