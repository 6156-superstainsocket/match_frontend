import 'package:flutter/material.dart';
import 'package:demo/constants.dart';

class LogoMenu extends StatelessWidget implements PreferredSizeWidget {
  const LogoMenu({super.key, required this.menuTitle});

  final String menuTitle;

  @override
  Size get preferredSize => const Size.fromHeight(topMenuBarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(menuTitle),
      centerTitle: false,
      backgroundColor: pinkLightColor,
      elevation: 0,
      leading: Builder(
        builder: (context) {
          return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu, color: pinkHeavyColor));
        },
      ),
      toolbarHeight: topMenuBarHeight,
    );
  }
}
