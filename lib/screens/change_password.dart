import 'package:firebase_auth/firebase_auth.dart';
import 'package:pa_mobile/screens/signin_screen.dart';
import 'package:pa_mobile/widgets/reusable_widget.dart';
import 'package:pa_mobile/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class changePassword extends StatefulWidget {
  const changePassword({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _changePasswordState createState() => _changePasswordState();
}

// ignore: camel_case_types
class _changePasswordState extends State<changePassword> {
  final TextEditingController _oldpasswordTextController =
      TextEditingController();
  final TextEditingController _newpasswordTextController =
      TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  String _oldPasswordError = '';
  String _newPasswordError = '';
  @override
  void initState() {
    super.initState();
    _oldpasswordTextController.addListener(() {
      setState(() {
        _oldPasswordError = '';
      });
    });

    _newpasswordTextController.addListener(() {
      setState(() {
        _newPasswordError = '';
      });
    });
  }

  Future<void> _changePassword() async {
    try {
      var currentUser = _auth.currentUser;
      if (currentUser != null) {
        var cred = EmailAuthProvider.credential(
            email: currentUser.email!,
            password: _oldpasswordTextController.text);
        await currentUser.reauthenticateWithCredential(cred);
        await currentUser.updatePassword(_newpasswordTextController.text);
        _oldpasswordTextController.clear();
        _newpasswordTextController.clear();
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Change Password Was Successful',
            message: 'You can now sign in to the app with new password',
            contentType: ContentType.success,
          ),
        );

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar).closed.then((reason) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const SignInScreen()));
          });
      } else {
        _oldpasswordTextController.clear();
        _newpasswordTextController.clear();
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'User not found',
            message: '',
            contentType: ContentType.failure,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } catch (error) {
      _oldpasswordTextController.clear();
      _newpasswordTextController.clear();
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Change Password Was Failed',
          message: _handleChangePasswordError(error),
          contentType: ContentType.failure,
        ),
      );

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _oldpasswordTextController.dispose();
    _newpasswordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Change Password",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
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
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Old Password", Icons.lock_outline, true,
                    _oldpasswordTextController,
                    errorText: _oldPasswordError),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("New Password", Icons.lock_outline, true,
                    _newpasswordTextController,
                    errorText: _newPasswordError),
                const SizedBox(
                  height: 20,
                ),
                firebaseUIButton(context, "Change Password", () async {
                  if (_oldpasswordTextController.text.isEmpty) {
                    setState(() {
                      _oldPasswordError = 'Old Password is required';
                      _newPasswordError = '';
                    });
                    return;
                  }

                  if (_newpasswordTextController.text.isEmpty) {
                    setState(() {
                      _newPasswordError = 'New Password is required';
                      _oldPasswordError = '';
                    });
                    return;
                  }
                  await _changePassword();
                }),
                _isLoading
                    ? const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(),
                      )
                    : Container(),
              ],
            ),
          ))),
    );
  }

  String _handleChangePasswordError(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'email-already-in-use':
          _oldpasswordTextController.clear();
          _newpasswordTextController.clear();
          return 'Email is already in use. Please use a different email.';

        default:
          _oldpasswordTextController.clear();
          _newpasswordTextController.clear();
          return 'Change Password failed. Try again later.';
      }
    } else {
      _oldpasswordTextController.clear();
      _newpasswordTextController.clear();
      return 'An error occurred during Change Password.';
    }
  }
}
