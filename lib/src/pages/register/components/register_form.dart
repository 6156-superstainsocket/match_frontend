import 'dart:convert';
import 'dart:io';

import 'package:demo/models/customresponse.dart';
import 'package:demo/src/pages/group/group_main.dart';
import 'package:demo/src/pages/login/login.dart';
import 'package:demo/models/user.dart' as match_user;
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:demo/constants.dart';
import 'package:demo/src/pages/utils/have_account.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _pwd = TextEditingController();
  final _pwdConfirm = TextEditingController();
  final _name = TextEditingController();
  GoogleSignInAccount? _currentUser;
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isSignedUp = false;

  Future<int> signup(BuildContext context) async {
    _currentUser = await googleSignIn.signIn();
    if (_currentUser != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await _currentUser!.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      // Getting users credential
      UserCredential result;
      try {
        result = await auth.signInWithCredential(authCredential);
      } catch (e) {
        throw Exception('error: ${e.toString()}');
      }
      int userId;
      try {
        userId = await register(true, result);
        debugPrint('$userId');
      } catch (e) {
        debugPrint(e.toString());
        throw Exception('error: ${e.toString()}');
      }
      return userId;
    }
    match_user.User? usr = await loadUser();
    if (usr != null) {
      return usr.id;
    }
    return -1;
  }

  @override
  void dispose() {
    _email.dispose();
    _pwd.dispose();
    _pwdConfirm.dispose();
    _name.dispose();
    super.dispose();
  }

  Future<int> register(bool isGoogle, UserCredential? userCredential) async {
    Response response;
    if (!isGoogle) {
      response = await userDio.post('/users/register', data: {
        "name": _name.text,
        "username": _email.text,
        "email": _email.text,
        "password": _pwd.text,
        "is_google": false,
      });
    } else {
      response = await userDio.post('/users/register', data: {
        "name": userCredential!.user!.displayName,
        "username": userCredential.user!.email,
        "email": userCredential.user!.email,
        "is_google": true,
      });
    }

    CustomResponse data = CustomResponse.fromJson(response.data);
    if (response.statusCode != HttpStatus.ok) {
      throw Exception('error: ${data.message}');
    }
    match_user.User user = match_user.User.fromJson(data.data);

    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('userId', user.id);

    return user.id;
  }

  Future<void> getUserInfo(int userId) async {
    Response response = await userDio.get('/users/$userId');
    CustomResponse data = CustomResponse.fromJson(response.data);
    if (response.statusCode != HttpStatus.ok) {
      throw Exception('error: ${data.message}');
    }
    match_user.User user = match_user.User.fromJson(data.data);

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userStr', jsonEncode(user));
    prefs.setInt('userId', user.id);
    setState(() {
      isSignedUp = true;
    });
  }

  void _completeRegister() {
    if (isSignedUp) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const GroupMain(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _name,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                hintText: "Name",
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                return value!.trim().isNotEmpty
                    ? null
                    : "Please enter your name";
              },
            ),
            const SizedBox(height: defaultPadding),
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
            Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom)),
            const SizedBox(height: defaultPadding),
            TextFormField(
              controller: _pwd,
              textInputAction: TextInputAction.next,
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
            TextFormField(
              controller: _pwdConfirm,
              textInputAction: TextInputAction.done,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Confirm Password",
                prefixIcon: Icon(Icons.password),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please re-enter your password';
                } else if (value != _pwd.text) {
                  return 'Inconsistent password';
                }
                return null;
              },
            ),
            Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom)),
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
                            Text("  Signing-Up...")
                          ],
                        ),
                      ),
                    );

                    try {
                      await register(false, null).then((value) async {
                        await getUserInfo(value)
                            .whenComplete(() => _completeRegister());
                      });
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.toString())),
                      );
                    }
                  }
                },
                child: const Text('Sign Up'),
              ),
            ),
            const Text('or'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: ElevatedButton.icon(
                onPressed: () async {
                  try {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 10),
                        content: Row(
                          children: const <Widget>[
                            CircularProgressIndicator(),
                            Text("  Signing-Up...")
                          ],
                        ),
                      ),
                    );

                    await signup(context).then((value) async {
                      if (value == -1) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('SignUp with Google failed')),
                        );
                        return;
                      }
                      await getUserInfo(value)
                          .whenComplete(() => _completeRegister());
                    });
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString())),
                    );
                  }
                },
                label: const Text('Sign Up with Google'),
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
            AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const Login();
                      },
                    ),
                  );
                })
          ],
        ));
  }
}
