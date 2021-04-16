import 'package:flutter/material.dart';
import 'package:repostaffs/LoginPage.dart';
import 'package:repostaffs/constants.dart';
import 'package:repostaffs/constants.dart';
import 'package:repostaffs/Sign_Up.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:repostaffs/components/my_text.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.only(left: 0, top: 75),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyText(
                    'Create an account',
                    color: Colors.white,
                    fontWeight: 'Medium',
                    size: 24.0,
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    width: 290.0,
                    height: 630.0,
                    child: Form(
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              labelText: 'Name',
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
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.call,
                                color: Colors.white,
                              ),
                              labelText: 'Mobile Number',
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
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email_rounded,
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
                              hintText: 'Enter your Email ID',
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
                              labelText: 'Confirm Password',
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
                          ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all<double>(15),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                (RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    19,
                                  ),
                                )),
                              ),
                              minimumSize: MaterialStateProperty.all<Size>(
                                  Size(120, 55)),
                              backgroundColor:
                                  MaterialStateProperty.all((PRIMARY)),
                            ),
                            child: MyText(
                              'Sign Up',
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
                                  Navigator.pop(context);
                                }, //Register
                                child: MyText(
                                  'Log In.',
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
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
