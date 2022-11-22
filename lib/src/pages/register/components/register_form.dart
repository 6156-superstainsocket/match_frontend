import 'package:demo/src/pages/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:demo/constants.dart';
import 'package:demo/src/pages/utils/have_account.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  Future<void> signup(BuildContext context) async {
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
    _pwdConfirm.dispose();
    _name.dispose();
    super.dispose();
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
                return value!.trim().length > 5
                    ? null
                    : "The length of password should be greater than five";
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
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState!.validate()) {
                    // TODO: Process data.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                    // debugPrint('email: ${_email.text}');
                    // debugPrint('pwd: ${_pwd.text}');
                    // debugPrint('pwd: ${_pwdConfirm.text}');
                    // debugPrint('firstname: ${_name.text}');
                  }
                },
                child: const Text('Sign Up'),
              ),
            ),
            const Text('or'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: ElevatedButton.icon(
                onPressed: () {
                  signup(context);
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
