import 'dart:convert';
import 'dart:io';

import 'package:demo/models/account.dart';
import 'package:demo/models/token.dart';
import 'package:demo/models/user.dart' as match_user;
import 'package:demo/src/pages/group/group_main.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:demo/constants.dart';
import 'package:demo/src/pages/utils/have_account.dart';
import 'package:demo/src/pages/register/register.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _pwd = TextEditingController();
  GoogleSignInAccount? _currentUser;
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isSignedIn = false;

  @override
  void initState() {
    super.initState();
    _completeLogin();
  }

  void _completeLogin() {
    if (isSignedIn) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const GroupMain(),
        ),
      );
    }
  }

  Future<int> signin(BuildContext context) async {
    _currentUser = await googleSignIn.signIn();
    if (_currentUser != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await _currentUser!.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      // Getting users credential
      try {
        await auth.signInWithCredential(authCredential);
      } catch (e) {
        throw Exception('error: ${e.toString()}');
      }
      int userId;
      try {
        userId = await oauth2(googleSignInAuthentication.idToken);
      } catch (e) {
        throw Exception('error: ${e.toString()}');
      }
      return userId;
    }
    Account? account = await loadUser();
    if (account != null) {
      return account.profile!.id;
    }
    return -1;
  }

  @override
  void dispose() {
    _email.dispose();
    _pwd.dispose();
    super.dispose();
  }

  Future<int> oauth2(String? idToken) async {
    Response response;
    response = await userDio.post('/users/oauth2/', data: {
      "id_token": idToken,
    });

    Token data = Token.fromJson(response.data);
    if (response.statusCode != HttpStatus.ok) {
      throw Exception('error: ${data.detail}');
    }

    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('userId', data.user!.id);
    prefs.setString('accessToken', data.access!);
    prefs.setString('freshToken', data.refresh!);
    groupDio.options.headers['Authorization'] = 'Bearer ${data.access!}';
    userDio.options.headers['Authorization'] = 'Bearer ${data.access!}';

    debugPrint('token ${data.access!}');
    return data.user!.id;
  }

  Future<int> login() async {
    Response response;
    response = await userDio.post('/users/token/', data: {
      "username": _email.text,
      "email": _email.text,
      "password": _pwd.text,
    });

    Token data = Token.fromJson(response.data);
    if (response.statusCode != HttpStatus.ok) {
      throw Exception('error: ${data.detail}');
    }

    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('userId', data.user!.id);
    prefs.setString('accessToken', data.access!);
    prefs.setString('freshToken', data.refresh!);
    groupDio.options.headers['Authorization'] = 'Bearer ${data.access!}';
    userDio.options.headers['Authorization'] = 'Bearer ${data.access!}';

    debugPrint('token ${data.access!}');
    return data.user!.id;
  }

  Future<void> getUserInfo(int userId) async {
    Response response = await userDio.get('/users/$userId');
    Account data = Account.fromJson(response.data);
    if (response.statusCode != HttpStatus.ok) {
      throw Exception('error: ${data.detail}');
    }

    if (data.profile == null) {
      data.profile = match_user.User(id: 0, email: data.email);
    } else {
      data.profile!.email = data.email;
    }

    debugPrint('${data.profile!.toJson()}');
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userStr', jsonEncode(data));
    setState(() {
      isSignedIn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                hintText: "Email",
                prefixIcon: Icon(Icons.email),
              ),
              validator: (value) {
                return value!.trim().isNotEmpty
                    ? null
                    : "Please enter your email";
              },
            ),
            const SizedBox(height: defaultPadding),
            TextFormField(
              controller: _pwd,
              textInputAction: TextInputAction.done,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Password",
                prefixIcon: Icon(Icons.password),
              ),
              validator: (value) {
                return value!.trim().isNotEmpty
                    ? null
                    : "The length of password cannot be empty";
              },
            ),
            Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom)),
            const SizedBox(height: defaultPadding),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: ElevatedButton(
                onPressed: () async {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 10),
                        content: Row(
                          children: const <Widget>[
                            CircularProgressIndicator(),
                            Text("  Signing-In...")
                          ],
                        ),
                      ),
                    );

                    try {
                      await login().then((value) async {
                        await getUserInfo(value)
                            .whenComplete(() => _completeLogin());
                      });
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.toString())),
                      );
                    }
                  }
                },
                child: const Text('Sign In'),
              ),
            ),
            const Text('or'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: ElevatedButton.icon(
                onPressed: () async {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(seconds: 10),
                      content: Row(
                        children: const <Widget>[
                          CircularProgressIndicator(),
                          Text("  Signing-In...")
                        ],
                      ),
                    ),
                  );

                  try {
                    await signin(context).then((value) async {
                      if (value == -1) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Login with Google failed')),
                        );
                        return;
                      }
                      await getUserInfo(value)
                          .whenComplete(() => _completeLogin());
                    });
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString())),
                    );
                  }
                },
                label: const Text('Sign In with Google'),
                icon: Image.asset(
                  "assets/images/google.png",
                  width: tagWidth,
                  height: tagHeight,
                  fit: BoxFit.scaleDown,
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  side: const BorderSide(color: pinkColor),
                ),
              ),
            ),
            const SizedBox(height: defaultPadding),
            AlreadyHaveAnAccountCheck(press: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignUp();
                  },
                ),
              );
            }),
          ],
        ));
  }
}
