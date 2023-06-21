import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/errormsg.dart';
import 'package:flutter_application_1/UI/home/components/body.dart';
import 'package:flutter_application_1/UI/home/homeScreen.dart';
import 'package:flutter_application_1/UI/main/main.dart';
import 'package:flutter_application_1/Widget/Components/formError.dart';
import 'package:flutter_application_1/Widget/Components/rounded_button.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:iconsax/iconsax.dart';

class Body extends StatelessWidget {
  final Function? onLogin; // Tambahkan tanda tanya (?) setelah tipe data Function

  Body({this.onLogin});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: size.height,
          maxWidth: size.width,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade800,
              Colors.blue.shade600,
            ],
            begin: Alignment.topLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Login Katalog Tahara Koi",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: LoginForm(
                  onLogin: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  final Function onLogin;
  LoginForm({required this.onLogin});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  List<String> errors = [];

  void _loginAsUser() {
    widget.onLogin();
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        final snackBar = SnackBar(
          content: Text(
            "Login Success!",
            style: TextStyle(color: kPrimaryColor),
          ),
          backgroundColor: kSecondaryLightColor,
          duration: Duration(seconds: 4),
          elevation: 6.0,
          behavior: SnackBarBehavior.floating,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        widget.onLogin();
      } on FirebaseAuthException catch (e) {
        final snackBar = SnackBar(
          content: Text(e.message!),
          backgroundColor: kPrimaryColor,
          duration: Duration(seconds: 4),
          elevation: 6.0,
          behavior: SnackBarBehavior.floating,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              onSaved: (newValue) => email = newValue!,
              onChanged: (value) {
                if (value.isNotEmpty && errors.contains(kEmailNullError)) {
                  setState(() {
                    errors.remove(kEmailNullError);
                  });
                } else if (emailValidatorRegExp.hasMatch(value) &&
                    errors.contains(kInvalidEmailError)) {
                  setState(() {
                    errors.remove(kInvalidEmailError);
                  });
                }
              },
              validator: (value) {
                if (value!.isEmpty && !errors.contains(kEmailNullError)) {
                  setState(() {
                    errors.add(kEmailNullError);
                  });
                } else if (!emailValidatorRegExp.hasMatch(value) &&
                    !errors.contains(kInvalidEmailError) &&
                    !errors.contains(kEmailNullError)) {
                  setState(() {
                    errors.add(kInvalidEmailError);
                  });
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Color(0xFFe7edeb),
                hintText: "Email",
                prefixIcon: Icon(
                  Icons.mail_outline_rounded,
                  color: Colors.grey[600],
                ),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            TextFormField(
              obscureText: true,
              onSaved: (newValue) => password = newValue!,
              onChanged: (value) {
                if (value.isNotEmpty && errors.contains(kPassNullError)) {
                  setState(() {
                    errors.remove(kPassNullError);
                  });
                }
              },
              validator: (value) {
                if (value!.isEmpty && !errors.contains(kPassNullError)) {
                  setState(() {
                    errors.add(kPassNullError);
                  });
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Color(0xFFe7edeb),
                hintText: "Password",
                prefixIcon: Icon(
                  Iconsax.lock,
                  color: Colors.grey[600],
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(child: FormError(errors: errors)),
            SizedBox(
              height: 15.0,
            ),
            RoundedButton(
              text: "Login",
              color: kPrimaryColor,
              press: _login,
            ),
            SizedBox(
              height: 10.0,
            ),
            TextButton(
              onPressed: _loginAsUser,
              child: Text(
                "Masuk sebagai user",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
