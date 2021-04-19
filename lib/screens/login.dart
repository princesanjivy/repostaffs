import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repostaffs/components/my_text.dart';
import 'package:repostaffs/constants.dart';
import 'package:repostaffs/screens/attendance_admin.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  String validate(String data) {
    if (data.isEmpty) return 'Required';
    return 'null';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: ' Repostaffs',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
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
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.mail_rounded,
                            color: Colors.white,
                          ),
                          labelText: 'Email',
                          labelStyle: GoogleFonts.poppins(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
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
                              color: Colors.white,
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

                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: MultiValidator(
                          [
                            EmailValidator(errorText: 'Invalid Mail ID'),
                            RequiredValidator(
                                errorText: 'This field cannot be left empty'),
                          ],
                        ),
                        style: GoogleFonts.poppins(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          letterSpacing: 1.0,
                        ),
                        // controller: ,
                        //validator,
                        autocorrect: true,

                        cursorColor: Colors.white,
                      ),
                      SizedBox(
                        height: 35.0,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock_rounded,
                            color: Colors.white,
                          ),
                          labelText: 'Password',
                          labelStyle: GoogleFonts.poppins(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
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
                              color: Colors.white,
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
                          color: Colors.white,
                          letterSpacing: 1.0,
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        // controller: ,
                        validator: RequiredValidator(
                            errorText: 'This field cannot be left empty'),
                        autocorrect: true,
                        autofocus: false,
                        cursorColor: Colors.white,
                      ),
                      SizedBox(
                        height: 55.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          /// change to whatever code you want
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AttendancePreview(),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          // elevation: MaterialStateProperty.all<double>(15),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(19),
                            ),
                          ),
                          minimumSize:
                              MaterialStateProperty.all<Size>(Size(120, 55)),
                          backgroundColor: MaterialStateProperty.all((PRIMARY)),
                          // fixedSize:
                          //     MaterialStateProperty.all<Size>(Size(120, 55)),
                        ),
                        child: MyText(
                          'Sign in',
                          color: Colors.white,
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
                            color: Colors.white,
                            fontWeight: 'Medium',
                            size: 16,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, 'Register');
                            }, //Register
                            child: MyText(
                              'Sign Up.',
                              color: Colors.white,
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
