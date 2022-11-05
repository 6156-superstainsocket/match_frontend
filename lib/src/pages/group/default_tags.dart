import 'package:demo/models/tag.dart';
import 'package:demo/src/pages/group/preview_tags.dart';
import 'package:flutter/material.dart';
import 'package:demo/constants.dart';

final List<Tag> defaultTags = [
  Tag(
    name: 'dinner',
    description: 'I want to have dinner with her/him',
    iconId: 0,
  ),
  Tag(
    name: 'date',
    description: 'I want to date her/him',
    iconId: 1,
  ),
  Tag(
    name: 'study',
    description: 'I want to study with her/him',
    iconId: 2,
  ),
];

class DefaultTags extends StatelessWidget {
  const DefaultTags({super.key});

  @override
  Widget build(BuildContext context) {
    return PreviewTags(
      tags: defaultTags,
      tagIcons: defaultTagIcons,
      showActions: false,
    );
  }
}
