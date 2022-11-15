import 'package:demo/constants.dart';
import 'package:demo/models/user.dart';
import 'package:demo/src/pages/user/profile.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  final int userId;
  const MyDrawer({super.key, required this.userId});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  User user = User(id: 0);

  @override
  void initState() {
    super.initState();
    user.id = widget.userId;
    // TODO: initial user data
    setState(() {});
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
                    onPressed: (() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return Profile(
                              user: user,
                            );
                          },
                        ),
                      );
                    }),
                    child: const Text('Edit Profile'),
                  ),
                ],
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.account_circle_outlined),
              title: Text("${user.firstName} ${user.lastName}"),
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
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
