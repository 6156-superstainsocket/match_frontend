import 'package:flutter/material.dart';
import 'package:demo/constants.dart';

class PopMenu extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final String? buttonText;
  const PopMenu({super.key, required this.title, this.buttonText});

  @override
  State<PopMenu> createState() => _PopMenuState();

  @override
  Size get preferredSize => const Size.fromHeight(topMenuBarHeight);
}

class _PopMenuState extends State<PopMenu> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      centerTitle: true,
      elevation: 0,
      leading: Builder(
        builder: (context) {
          return IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close_outlined));
        },
      ),
      toolbarHeight: topMenuBarHeight,
      actions: widget.buttonText == null
          ? null
          : [TextButton(onPressed: () {}, child: Text(widget.buttonText!))],
    );
  }
}
