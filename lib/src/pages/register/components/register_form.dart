import 'package:demo/src/pages/login/login.dart';
import 'package:flutter/material.dart';
import 'package:demo/constants.dart';
import 'package:demo/src/pages/utils/have_account.dart';

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
  final _firstname = TextEditingController();
  final _lastname = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _pwd.dispose();
    _pwdConfirm.dispose();
    _firstname.dispose();
    _lastname.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: TextFormField(
                  controller: _firstname,
                  textInputAction: TextInputAction.next,
                  cursorColor: pinkColor,
                  decoration: const InputDecoration(
                    hintText: "Firstname",
                  ),
                  validator: (value) {
                    return value!.trim().isNotEmpty ? null : "Empty field";
                  },
                )),
                const SizedBox(
                  width: 20.0,
                ),
                Flexible(
                    child: TextFormField(
                  controller: _lastname,
                  textInputAction: TextInputAction.next,
                  cursorColor: pinkColor,
                  decoration: const InputDecoration(
                    hintText: "Lastname",
                  ),
                  validator: (value) {
                    return value!.trim().isNotEmpty ? null : "Empty field";
                  },
                ))
              ],
            ),
            const SizedBox(height: defaultPadding),
            TextFormField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: pinkColor,
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
            TextFormField(
              controller: _pwdConfirm,
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: pinkHeavyColor,
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
                    // debugPrint('firstname: ${_firstname.text}');
                    // debugPrint('lastname: ${_lastname.text}');
                  }
                },
                child: const Text('Sign Up'),
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
