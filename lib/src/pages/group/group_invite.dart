import 'dart:io';

import 'package:demo/constants.dart';
import 'package:dio/dio.dart';
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
                if (_groupInviteKey.currentState!.validate()) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return Dialog(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        child: Center(
                          child: SizedBox(
                            width: progressIndicatorSize,
                            height: progressIndicatorSize,
                            child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                  List<String> emails = _invitedEmails.text
                      .split(",")
                      .map((x) => x.trim())
                      .where((element) =>
                          element.isNotEmpty &&
                          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(element))
                      .toList();
                  // debugPrint("Invite Emails: ${_invitedEmails.text}");
                  // debugPrint("Invite Emails Sent: $emails");
                  try {
                    _sendInviteEmails(emails).whenComplete(() {
                      // pop loading dialog
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(milliseconds: 2500),
                          content: Text(
                            "Send invites successfully!",
                            style: TextStyle(color: greenColor),
                          ),
                        ),
                      );
                      Future.delayed(const Duration(seconds: 3), () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        Navigator.of(context).pop();
                      });
                    });
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          e.toString(),
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    );
                  }
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

  Future<void> _sendInviteEmails(List<String> emails) async {
    if (emails.isEmpty) {
      return;
    }

    Response response;
    response = await groupDio
        .post('/groups/${widget.groupId}/users', data: {'emails': emails});
    // debugPrint('${response.toString()}');
    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Error HTTP Code: ${response.statusCode}');
    }
  }
}
