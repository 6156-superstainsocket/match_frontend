import 'package:demo/constants.dart';
import 'package:demo/models/user.dart';
import 'package:demo/src/pages/login/login.dart';
import 'package:demo/src/pages/user/profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  User user = User(id: -1);

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  _loadUser() async {
    User? currentUser = await loadUser();
    if (currentUser != null) {
      setState(() {
        user = currentUser;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: pinkLightColor,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: defaultPadding * 2),
              child: Column(
                children: [
                  ClipOval(
                    child: allUserIcons[user.iconId!],
                  ),
                  const SizedBox(height: 0.5 * defaultPadding),
                  TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: (() async {
                      User changedUser = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return Profile(
                              user: user,
                            );
                          },
                        ),
                      );
                      setState(() {
                        user = changedUser;
                      });
                    }),
                    child: const Text('Edit Profile'),
                  ),
                ],
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.account_circle_outlined),
              title: Text("${user.name}"),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.description_outlined),
              title: Text(user.description!),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.email_outlined),
              title: Text(user.email!),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.phone_outlined),
              title: Text(user.phone!),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Sign Out"),
              onTap: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                await preferences.clear().whenComplete(() {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const Login();
                      },
                    ),
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
