import 'package:demo/constants.dart';
import 'package:demo/models/account.dart';
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
  Account user = Account(id: -1);

  _loadUser() async {
    Account? account = await loadUser();
    if (account != null && account.profile != null) {
      setState(() {
        user = account;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LogoMenu(
        menuTitle: _barTitles[_selectedIndex],
      ),
      drawer: MyDrawer(user: user),
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
                icon: Icon(Icons.notifications), label: "Message"),
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
