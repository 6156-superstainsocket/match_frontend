import 'package:flutter/material.dart';
import 'package:demo/constants.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class LogoMenu extends StatelessWidget implements PreferredSizeWidget {
  const LogoMenu({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(topMenuBarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // title: SvgPicture.asset(
      //   "assets/svgs/logo.svg",
      //   height: 32,
      //   width: 32,
      //   fit: BoxFit.scaleDown,
      // ),
      // centerTitle: true,
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
