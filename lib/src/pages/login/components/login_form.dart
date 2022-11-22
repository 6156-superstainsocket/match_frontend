import 'dart:convert';

import 'package:demo/models/customresponse.dart';
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

  @override
  void initState() {
    super.initState();
  }

  Future<void> signin(BuildContext context) async {
    _currentUser = await googleSignIn.signIn();
    if (_currentUser != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await _currentUser!.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      // Getting users credential
      UserCredential result = await auth.signInWithCredential(authCredential);
      debugPrint(result.user!.email);
      debugPrint(result.user!.displayName);
      debugPrint(result.user!.phoneNumber);
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _pwd.dispose();
    super.dispose();
  }

  Future<void> getUserInfo(int userId) async {
    Response response = await userDio.get('/users/$userId');
    CustomResponse data = CustomResponse.fromJson(response.data);
    if (response.statusCode != 200) {
      throw Exception('error: ${data.message}');
    }
    match_user.User user = match_user.User.fromJson(data.data);

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userStr', jsonEncode(user));
    prefs.setInt('userId', user.id);
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
            Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom)),
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
                return value!.trim().length > 5
                    ? null
                    : "The length of password should be greater than five";
              },
            ),
            Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom)),
            const SizedBox(height: defaultPadding),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: ElevatedButton(
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState!.validate()) {
                    // TODO: Process data.
                    try {
                      getUserInfo(2);
                    } on DioError catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.message)),
                      );
                    }
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const GroupMain();
                        },
                      ),
                    );
                    debugPrint('email: ${_email.text}');
                    debugPrint('pwd: ${_pwd.text}');
                  }
                },
                child: const Text('Sign In'),
              ),
            ),
            const Text('or'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: ElevatedButton.icon(
                onPressed: () {
                  signin(context);
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
