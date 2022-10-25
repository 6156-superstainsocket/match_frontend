import 'package:flutter/material.dart';
import 'package:demo/constants.dart';
import 'package:demo/src/pages/utils/have_account.dart';
import 'package:demo/src/pages/register/register.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(child: Column(children: [
      TextFormField(
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        cursorColor: pinkHeavyColor,
        onSaved: (email) {},
        decoration: const InputDecoration(
          hintText: "Email",
          prefixIcon: Icon(Icons.email),
        ),
      ),
      const SizedBox(height: defaultPadding),
      TextFormField(
        textInputAction: TextInputAction.done,
        obscureText: true,
        cursorColor: pinkHeavyColor,
        onSaved: (password) {},
        decoration: const InputDecoration(
          hintText: "Password",
          prefixIcon: Icon(Icons.password),
        ),
      ),
      const SizedBox(height: defaultPadding),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: defaultPadding),
        child: ElevatedButton(
          onPressed: () {
            // Validate will return true if the form is valid, or false if
            // the form is invalid.
            // if (_formKey.currentState!.validate()) {
            //   // Process data.
            // }
          },
          child: const Text('Sign In'),
        ),
      ),
      const SizedBox(height: defaultPadding),
      AlreadyHaveAnAccountCheck(press: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const SignUp();
            },
          ),
        );
      })
    ],));
  }
}
