import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:repostaffs/components/my_text.dart';
import 'package:repostaffs/constants.dart';
import 'package:repostaffs/providers/auth.dart';
import 'package:repostaffs/screens/sign_up.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String error = '';
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool _inProcess = false;

  final _formKey = GlobalKey<FormState>();

  // AuthService _auth = new AuthService();

  @override
  Widget build(BuildContext context) {
    return _inProcess
        ? Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 10.0,
                  ),
                  MyText(
                    'Signing in , Please Wait',
                    color: WHITE,
                    fontWeight: 'Medium',
                    size: 16,
                  )
                ],
              ),
            ),
          )
        : Scaffold(
            body: ListView(
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/logo.png',
                      height: 300,
                      width: 300,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: 'Sign in to',
                              style: GoogleFonts.poppins(
                                color: WHITE,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: ' Repostaffs',
                              style: GoogleFonts.poppins(
                                color: WHITE,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ]),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 45.0,
                    ),
                    Container(
                      width: 290.0,
                      height: 380.0,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.mail_rounded,
                                  color: WHITE,
                                ),
                                labelText: 'Email',
                                labelStyle: GoogleFonts.poppins(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w300,
                                  color: WHITE,
                                  letterSpacing: 1.0,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                filled: true,
                                fillColor: PRIMARY,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: WHITE,
                                  ),
                                ),
                                hintText: 'Enter your Email ID',
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white38,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: MultiValidator(
                                [
                                  EmailValidator(errorText: 'Invalid Mail ID'),
                                  RequiredValidator(
                                      errorText:
                                          'This field cannot be left empty'),
                                ],
                              ),
                              style: GoogleFonts.poppins(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w300,
                                color: WHITE,
                                letterSpacing: 1.0,
                              ),
                              controller: _email,
                              autocorrect: true,
                              cursorColor: WHITE,
                            ),
                            SizedBox(
                              height: 35.0,
                            ),
                            TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock_rounded,
                                  color: WHITE,
                                ),
                                labelText: 'Password',
                                labelStyle: GoogleFonts.poppins(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w300,
                                  color: WHITE,
                                  letterSpacing: 1.0,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                filled: true,
                                fillColor: PRIMARY,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: WHITE,
                                  ),
                                ),
                                hintText: 'Enter your Password',
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white38,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              style: GoogleFonts.poppins(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w300,
                                color: WHITE,
                                letterSpacing: 1.0,
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: _password,
                              validator: RequiredValidator(
                                  errorText: 'This field cannot be left empty'),
                              autocorrect: true,
                              autofocus: false,
                              cursorColor: WHITE,
                            ),
                            SizedBox(
                              height: 55.0,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    _inProcess = true;
                                  });
                                  dynamic result = await context
                                      .read<AuthenticationProvider>()
                                      .signIn(
                                          email: _email.text,
                                          password: _password.text);
                                  setState(() {
                                    _inProcess = false;
                                  });
                                  if (result == null) {
                                    await Fluttertoast.showToast(
                                      msg: 'Invalid Email/Password',
                                      backgroundColor: WHITE,
                                      textColor: PRIMARY,
                                    );
                                  }
                                }
                              },
                              style: ButtonStyle(
                                // elevation: MaterialStateProperty.all<double>(15),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(19),
                                  ),
                                ),
                                minimumSize: MaterialStateProperty.all<Size>(
                                    Size(120, 55)),
                                backgroundColor:
                                    MaterialStateProperty.all((PRIMARY)),
                              ),
                              child: MyText(
                                'Sign in',
                                color: WHITE,
                                fontWeight: 'Light',
                                size: 18,
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyText(
                                  'Don\'t have an account? ',
                                  color: WHITE,
                                  fontWeight: 'Medium',
                                  size: 16,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignUp(),
                                      ),
                                    );
                                  }, //Register
                                  child: MyText(
                                    'Sign Up.',
                                    color: WHITE,
                                    fontWeight: 'SemiBold',
                                    size: 20,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
  }
}
