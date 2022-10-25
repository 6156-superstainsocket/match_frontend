import 'package:flutter/material.dart';
import 'package:demo/src/pages/utils/center_background.dart';
import 'components/login_form.dart';
import 'package:demo/src/pages/utils/logo.dart';
import 'package:demo/constants.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return CenterBackground(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Logo(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: defaultPadding),
              child: Text(
                'Match',
                style: logoTitleFont,
              ),
            ),
            const SizedBox(height: 3 * defaultPadding),
            Row(
              children: const [
                Spacer(),
                Expanded(
                  flex: 8,
                  child: LoginForm(),
                ),
                Spacer(),
              ],
            ),
          ],
        ),
      )
    );
  }
}