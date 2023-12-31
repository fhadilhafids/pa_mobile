import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pa_mobile/widgets/reusable_widget.dart' as reus;
import 'reset_password.dart';
import 'signup_screen.dart';
import 'home_page.dart';
import 'package:pa_mobile/utils/color_utils.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  String _emailError = '';
  String _passwordError = '';
  @override
  void initState() {
    super.initState();
    _emailTextController.addListener(() {
      setState(() {
        _emailError = '';
      });
    });

    _passwordTextController.addListener(() {
      setState(() {
        _passwordError = '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("1525d4"),
          hexStringToColor("2757a1"),
          hexStringToColor("5E61F4")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                Image.asset("assets/images/logo-light.png",
                    width: 300, height: 200),
                const SizedBox(
                  height: 30,
                ),
                reus.reusableTextField("Enter email", Icons.person_outline,
                    false, _emailTextController,
                    errorText: _emailError),
                const SizedBox(
                  height: 20,
                ),
                reus.reusableTextField(
                  "Enter Password",
                  Icons.lock_outline,
                  true,
                  _passwordTextController,
                  errorText: _passwordError,
                ),
                const SizedBox(
                  height: 5,
                ),
                forgetPassword(context),
                reus.firebaseUIButton(context, "Sign In", () {
                  if (_emailTextController.text.isEmpty) {
                    setState(() {
                      _emailError = 'Email is required';
                      _passwordError = '';
                    });
                    return;
                  }

                  if (_passwordTextController.text.isEmpty) {
                    setState(() {
                      _passwordError = 'Password is required';
                      _emailError = '';
                    });
                    return;
                  }

                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                    final snackBar = SnackBar(
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        title: 'Sign in Was Successful',
                        message: 'You will be moved to the main page',
                        contentType: ContentType.success,
                      ),
                    );

                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(snackBar).closed.then((reason) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyHomePage(
                                      title: 'IKOA',
                                    )));
                      });
                  }).onError((error, stackTrace) {
                    final snackBar = SnackBar(
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        title: 'Email / Password was incorrect',
                        message: 'Check your email / password correctly!',
                        contentType: ContentType.failure,
                      ),
                    );

                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(snackBar);
                  });
                }),
                signUpOption()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Forgot Password?",
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ResetPassword())),
      ),
    );
  }
}
