import 'package:demo/constants.dart';
import 'package:demo/src/pages/utils/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GroupMain extends StatefulWidget {
  const GroupMain({super.key});

  @override
  State<GroupMain> createState() => _GroupMainState();
}

class _GroupMainState extends State<GroupMain> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          "assets/svgs/logo.svg",
          height: 32,
          width: 32,
          fit: BoxFit.scaleDown,
        ),
        centerTitle: true,
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
      ),
      drawer: const MyDrawer(),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: greyBackground),
          ),
        ),
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.message), label: "Message"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "You"),
          ],
          elevation: 0,
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          fixedColor: greenColor,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
