// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/Models/errormsg.dart';
// import 'package:flutter_application_1/Service/apiService.dart';
// import 'package:flutter_application_1/UI/login/login_screen.dart';
// import 'package:flutter_application_1/UI/main/main.dart';
// import 'package:flutter_application_1/Widget/Components/formError.dart';
// import 'package:flutter_application_1/Widget/Components/rounded_button.dart';
// import 'package:flutter_application_1/constants.dart';
// import 'package:iconsax/iconsax.dart';

// class SignupScreen extends StatelessWidget {
//   const SignupScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           constraints: BoxConstraints(
//             maxHeight: MediaQuery.of(context).size.height,
//             maxWidth: MediaQuery.of(context).size.width,
//           ),
//           decoration: BoxDecoration(
//               gradient: LinearGradient(
//             colors: [
//               Colors.blue.shade800,
//               Colors.blue.shade600,
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.centerRight,
//           )),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 flex: 2,
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 50, horizontal: 24),
//                   child: Column(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Register",
//                           style: TextStyle(
//                             fontSize: 24.0,
//                             color: Colors.white,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10.0,
//                         ),
//                         Text(
//                           "Create your account!",
//                           style: TextStyle(
//                             fontSize: 20.0,
//                             color: Colors.white,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                       ]),
//                 ),
//               ),
//               Expanded(
//                 flex: 5,
//                 child: Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(40),
//                       topRight: Radius.circular(40),
//                     ),
//                   ),
//                   child: SignupForm(),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class SignupForm extends StatefulWidget {
//   @override
//   _SignupFormState createState() => _SignupFormState();
// }

// class _SignupFormState extends State<SignupForm> {
//   final _formKey = GlobalKey<FormState>();
//   late String email;
//   late String name;
//   late String password = '';
//   late String confirmPassword = '';
//   final List<String> errors = [];
//   late ErrorMSG res;

//   void _signup() async {
//     if (name.isNotEmpty &&
//         email.isNotEmpty &&
//         password != '' &&
//         password == confirmPassword) {
//       res = await APIService.signup(name, email, password);
//       if (res.success == true) {
//         // snackbar
//         final snackBar = SnackBar(
//           content: Text(
//             "Register Success!",
//             style: TextStyle(color: kPrimaryColor),
//           ),
//           backgroundColor: kSecondaryLightColor,
//           duration: Duration(seconds: 4),
//           elevation: 6.0,
//           behavior: SnackBarBehavior.floating,
//         );
//         ScaffoldMessenger.of(context).showSnackBar(snackBar);

//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) {
//               return MainScreen();
//             },
//           ),
//         );
//       } else {
//         // snackbar
//         final snackBar = SnackBar(
//           content: Text(res.message),
//           backgroundColor: kPrimaryColor,
//           duration: Duration(seconds: 4),
//           elevation: 6.0,
//           behavior: SnackBarBehavior.floating,
//         );
//         ScaffoldMessenger.of(context).showSnackBar(snackBar);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Form(
//         key: _formKey,
//         child: Padding(
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               TextFormField(
//                 onSaved: (newValue) => name = newValue.toString(),
//                 onChanged: (value) {
//                   if (value.isNotEmpty && errors.contains(kNameNullError)) {
//                     setState(() {
//                       errors.remove(kNameNullError);
//                     });
//                   }
//                   return null;
//                 },
//                 validator: (value) {
//                   if (value!.isEmpty && !errors.contains(kNameNullError)) {
//                     setState(() {
//                       errors.add(kNameNullError);
//                     });
//                   }
//                   return null;
//                 },
//                 decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide.none,
//                     ),
//                     filled: true,
//                     fillColor: Color(0xFFe7edeb),
//                     hintText: "Name",
//                     prefixIcon: Icon(
//                       Iconsax.user,
//                       color: Colors.grey[600],
//                     )),
//               ),
//               SizedBox(
//                 height: 20.0,
//               ),
//               TextFormField(
//                 keyboardType: TextInputType.emailAddress,
//                 onSaved: (newValue) => email = newValue.toString(),
//                 onChanged: (value) {
//                   if (value.isNotEmpty && errors.contains(kEmailNullError)) {
//                     setState(() {
//                       errors.remove(kEmailNullError);
//                     });
//                   } else if (emailValidatorRegExp.hasMatch(value) &&
//                       errors.contains(kInvalidEmailError)) {
//                     setState(() {
//                       errors.remove(kInvalidEmailError);
//                     });
//                   }
//                   return null;
//                 },
//                 validator: (value) {
//                   if (value!.isEmpty && !errors.contains(kEmailNullError)) {
//                     setState(() {
//                       errors.add(kEmailNullError);
//                     });
//                   } else if (!emailValidatorRegExp.hasMatch(value.toString()) &&
//                       !errors.contains(kInvalidEmailError) &&
//                       !errors.contains(kEmailNullError)) {
//                     setState(() {
//                       errors.add(kInvalidEmailError);
//                     });
//                   }
//                   return null;
//                 },
//                 decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide.none,
//                     ),
//                     filled: true,
//                     fillColor: Color(0xFFe7edeb),
//                     hintText: "Email",
//                     prefixIcon: Icon(
//                       Icons.mail_outline_rounded,
//                       color: Colors.grey[600],
//                     )),
//               ),
//               SizedBox(
//                 height: 20.0,
//               ),
//               TextFormField(
//                 obscureText: true,
//                 onSaved: (newValue) => password = newValue.toString(),
//                 onChanged: (value) {
//                   setState(() {
//                     password = value;
//                   });
//                   if (value.isNotEmpty && errors.contains(kPassNullError)) {
//                     setState(() {
//                       errors.remove(kPassNullError);
//                     });
//                   }
//                   return null;
//                 },
//                 validator: (value) {
//                   if (value!.isEmpty && !errors.contains(kPassNullError)) {
//                     setState(() {
//                       errors.add(kPassNullError);
//                     });
//                   }
//                   return null;
//                 },
//                 decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide.none,
//                     ),
//                     filled: true,
//                     fillColor: Color(0xFFe7edeb),
//                     hintText: "Password",
//                     prefixIcon: Icon(
//                       Iconsax.lock,
//                       color: Colors.grey[600],
//                     )),
//               ),
//               SizedBox(
//                 height: 20.0,
//               ),
//               TextFormField(
//                 obscureText: true,
//                 onSaved: (newValue) => confirmPassword = newValue.toString(),
//                 onChanged: (value) {
//                   setState(() {
//                     confirmPassword = value;
//                   });
//                   if (value.isNotEmpty && errors.contains(kPassNullError)) {
//                     setState(() {
//                       errors.remove(kPassNullError);
//                     });
//                   } else if (password == confirmPassword &&
//                       !errors.contains(kMatchPassError)) {
//                     setState(() {
//                       errors.remove(kMatchPassError);
//                     });
//                   }
//                   return null;
//                 },
//                 validator: (value) {
//                   if (password != confirmPassword &&
//                       !errors.contains(kMatchPassError)) {
//                     setState(() {
//                       errors.add(kMatchPassError);
//                     });
//                   }
//                   return null;
//                 },
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide.none,
//                   ),
//                   filled: true,
//                   fillColor: Color(0xFFe7edeb),
//                   hintText: "Confirm Password",
//                   prefixIcon: Icon(
//                     Iconsax.lock,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 10.0,
//               ),
//               Container(child: FormError(errors: errors)),
//               SizedBox(
//                 height: 15.0,
//               ),
//               RoundedButton(
//                   text: "Register",
//                   color: kPrimaryColor,
//                   press: () {
//                     if (_formKey.currentState != null &&
//                         _formKey.currentState!.validate()) {
//                       _formKey.currentState!.save();
//                       _signup();
//                     }
//                   }),
//               SizedBox(
//                 height: 10.0,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Any have an account? ",
//                     style: TextStyle(
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) {
//                             return LoginScreen();
//                           },
//                         ),
//                       );
//                     },
//                     child: Text(
//                       "Sign up",
//                       style: TextStyle(
//                           color: kPrimaryColor, fontWeight: FontWeight.w500),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 10.0,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   GestureDetector(
//                     onTap: () {},
//                     child: Text(
//                       "Forgot your Password",
//                       style: TextStyle(
//                           color: kPrimaryColor, fontWeight: FontWeight.w500),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
