import 'package:demo/src/pages/group/group_main.dart';
import 'package:flutter/material.dart';
import 'package:demo/constants.dart';
import 'package:demo/src/pages/utils/have_account.dart';
import 'package:demo/src/pages/register/register.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _pwd = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _pwd.dispose();
    super.dispose();
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
              cursorColor: pinkHeavyColor,
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
              cursorColor: pinkHeavyColor,
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
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                    // TODO: navigate to home page
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) {
                    //       return const GroupMain();
                    //     },
                    //   ),
                    // );
                    // debugPrint('email: ${_email.text}');
                    // debugPrint('pwd: ${_pwd.text}');
                  }
                },
                child: const Text('Sign In'),
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
            })
          ],
        ));
  }
}
