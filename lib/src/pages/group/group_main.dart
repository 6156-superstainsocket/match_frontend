import 'package:demo/constants.dart';
import 'package:demo/src/pages/group/group_list.dart';
import 'package:demo/src/pages/message/message_bar.dart';
import 'package:demo/src/pages/utils/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:demo/src/pages/utils/logo_menu.dart';

class GroupMain extends StatefulWidget {
  const GroupMain({super.key});

  @override
  State<GroupMain> createState() => _GroupMainState();
}

class _GroupMainState extends State<GroupMain> {
  int _selectedIndex = 0;
  final List<String> _barTitles = ["Group", "Message"];
  static const List<Widget> _widgetOptions = <Widget>[
    GroupList(),
    MessageBar(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LogoMenu(
        menuTitle: _barTitles[_selectedIndex],
      ),
      drawer: const MyDrawer(),
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
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
          ],
          elevation: 0,
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          fixedColor: pinkHeavyColor,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
