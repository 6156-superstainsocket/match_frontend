import 'dart:convert';
import 'dart:io';

import 'package:demo/constants.dart';
import 'package:demo/models/account.dart';
import 'package:demo/src/pages/utils/center_background.dart';
import 'package:demo/src/pages/utils/icon_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  final Account user;
  const Profile({super.key, required this.user});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GlobalKey<FormState> _profileformKey = GlobalKey<FormState>();

  Account changedUser = Account(id: -1);

  @override
  void initState() {
    super.initState();
    changedUser = widget.user;
  }

  Future<void> updateProfile(int userId) async {
    Response response = await userDio
        .put('/users/$userId', data: {"profile": changedUser.profile});
    Account data = Account.fromJson(response.data);
    if (response.statusCode != HttpStatus.ok) {
      throw Exception('error: ${data.detail}');
    }
  }

  Future<void> _saveUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('userStr', jsonEncode(changedUser));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_outlined));
          },
        ),
        toolbarHeight: topMenuBarHeight,
        actions: [
          TextButton(
              onPressed: () {
                if (_profileformKey.currentState!.validate()) {
                  try {
                    updateProfile(changedUser.profile!.userId);
                  } on DioError catch (e) {
                    debugPrint('${e.response}');
                  }
                  _saveUser();
                  Navigator.pop(context, changedUser);
                }
              },
              child: const Text('Save'))
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: CenterBackground(
          child: SingleChildScrollView(
            child: Form(
              key: _profileformKey,
              child: Column(
                children: [
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          iconSize: profileImgHeight,
                          onPressed: () async {
                            int? result = await showIconPicker(
                              context: context,
                              defalutIconId: changedUser.profile!.iconId,
                              isIcon: false,
                              svgs: allUserIcons,
                              crossCount: 3,
                            );
                            setState(() {
                              changedUser.profile!.iconId = result!;
                            });
                          },
                          icon: ClipOval(
                            child: Image.asset(
                              "$assetUserPath${(changedUser.profile!.iconId! + 1).toString()}.png",
                              width: profileImgWidth,
                              height: profileImgHeight,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 2 * defaultPadding),
                    child: Divider(),
                  ),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 0.5 * defaultPadding),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Name',
                                style: textMiddleSize,
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(height: 0.5 * defaultPadding),
                              Expanded(
                                child: TextFormField(
                                  initialValue: changedUser.profile!.name,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    hintText: "Name",
                                  ),
                                  validator: (value) {
                                    return value!.trim().isNotEmpty
                                        ? null
                                        : "please enter name";
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      changedUser.profile!.name = value;
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 0.5 * defaultPadding),
                    child: Divider(),
                  ),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 0.5 * defaultPadding),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Description',
                                style: textMiddleSize,
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(height: 0.5 * defaultPadding),
                              Expanded(
                                child: TextFormField(
                                  initialValue:
                                      changedUser.profile!.description,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    hintText: "Describe about yourself",
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      changedUser.profile!.description = value;
                                    });
                                  },
                                  validator: (value) {
                                    return value!.trim().isNotEmpty
                                        ? null
                                        : "please enter description";
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 0.5 * defaultPadding),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 0.5 * defaultPadding),
                    child: Divider(),
                  ),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 0.5 * defaultPadding),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Email',
                                style: textMiddleSize,
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(height: 0.5 * defaultPadding),
                              Expanded(
                                child: Text(
                                  changedUser.email!,
                                  style: textLargeSize,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 0.5 * defaultPadding),
                    child: Divider(),
                  ),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 0.5 * defaultPadding),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Phone',
                                style: textMiddleSize,
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(height: 0.5 * defaultPadding),
                              Expanded(
                                child: TextFormField(
                                  initialValue: changedUser.profile!.phone,
                                  textInputAction: TextInputAction.done,
                                  decoration: const InputDecoration(
                                    hintText: "XXX-XXX-XXXX",
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      changedUser.profile!.phone = value;
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 0.5 * defaultPadding),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
