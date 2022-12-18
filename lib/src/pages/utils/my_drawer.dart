import 'package:demo/constants.dart';
import 'package:demo/models/account.dart';
import 'package:demo/src/pages/login/login.dart';
import 'package:demo/src/pages/user/profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  final Account user;

  const MyDrawer({super.key, required this.user});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  Account user = Account(id: -1);

  @override
  void initState() {
    super.initState();
    user = widget.user;
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
                    child: allUserIcons[user.profile!.iconId!],
                  ),
                  const SizedBox(height: 0.5 * defaultPadding),
                  TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: (() async {
                      Account? changedUser = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return Profile(
                              user: user,
                            );
                          },
                        ),
                      );
                      if (changedUser != null) {
                        setState(() {
                          user = changedUser;
                        });
                      }
                    }),
                    child: const Text('Edit Profile'),
                  ),
                ],
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.account_circle_outlined),
              title: Text("${user.profile!.name}"),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.description_outlined),
              title: Text(user.profile!.description!),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.email_outlined),
              title: Text(user.email!),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.phone_outlined),
              title: Text(user.profile!.phone!),
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
