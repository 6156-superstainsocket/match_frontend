import 'package:demo/src/pages/login/login.dart';
import 'package:flutter/material.dart';
import 'package:demo/constants.dart';
import 'package:demo/src/pages/utils/have_account.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(child: Column(children: [
      TextFormField(
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        cursorColor: pinkColor,
        onSaved: (email) {},
        decoration: const InputDecoration(
          hintText: "Email",
          prefixIcon: Icon(Icons.email),
        ),
      ),
      const SizedBox(height: defaultPadding),
      TextFormField(
        textInputAction: TextInputAction.next,
        obscureText: true,
        cursorColor: pinkHeavyColor,
        onSaved: (password) {},
        decoration: const InputDecoration(
          hintText: "Password",
          prefixIcon: Icon(Icons.password),
        ),
      ),
      const SizedBox(height: defaultPadding),
      TextFormField(
        textInputAction: TextInputAction.done,
        obscureText: true,
        cursorColor: pinkHeavyColor,
        onSaved: (confirmPassword) {},
        decoration: const InputDecoration(
          hintText: "Confirm Password",
          prefixIcon: Icon(Icons.password),
        ),
      ),
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
          child: const Text('Sign Up'),
        ),
      ),
      const SizedBox(height: defaultPadding),
      AlreadyHaveAnAccountCheck(
        login: false,
        press: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const Login();
            },
          ),
        );
      })
    ],));
  }
}
