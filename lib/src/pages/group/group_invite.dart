import 'package:demo/constants.dart';
import 'package:flutter/material.dart';

class GroupInvite extends StatefulWidget {
  const GroupInvite({
    super.key,
    required this.groupId,
  });

  final int groupId;

  @override
  State<GroupInvite> createState() => _GroupInviteState();
}

class _GroupInviteState extends State<GroupInvite> {
  final GlobalKey<FormState> _groupInviteKey = GlobalKey<FormState>();
  final _invitedEmails = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _invitedEmails.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Invite Members'),
        centerTitle: true,
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close_outlined));
          },
        ),
        toolbarHeight: topMenuBarHeight,
        actions: [
          TextButton(
              onPressed: () {
                // TODO save the change
                if (_groupInviteKey.currentState!.validate()) {
                  // TODO: send data
                  debugPrint("Invite Emails: ${_invitedEmails.text}");
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Send'))
        ],
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Form(
                  key: _groupInviteKey,
                  child: TextFormField(
                    controller: _invitedEmails,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: null,
                    maxLength: 500,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      hintText: "xxx@xxx.com, split by \",\"",
                    ),
                    style: textMiddleSize,
                    validator: (value) {
                      return value!.trim().isNotEmpty
                          ? null
                          : "Please enter emails";
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
