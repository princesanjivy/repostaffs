import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repostaffs/components/my_text.dart';
import 'package:repostaffs/constants.dart';
import 'package:repostaffs/screens/profile_pic.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _name = TextEditingController();
  TextEditingController _mobno = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _conpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70.0),
                child: MyText(
                  'Create an account',
                  color: WHITE,
                  fontWeight: 'Medium',
                  size: 24.0,
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Container(
                width: 290.0,
                height: 800.0,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: WHITE,
                          ),
                          labelText: 'Name',
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
                        style: GoogleFonts.poppins(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w300,
                          color: WHITE,
                          letterSpacing: 1.0,
                        ),
                        controller: _name,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: RequiredValidator(
                            errorText: 'This Field cannot be left empty'),
                        autocorrect: true,
                        cursorColor: WHITE,
                      ),
                      SizedBox(
                        height: 35.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.call,
                            color: WHITE,
                          ),
                          labelText: 'Mobile Number',
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
                          hintText: 'Enter your Mobile Number',
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
                        controller: _mobno,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: 'This Field cannot be left empty'),
                          MinLengthValidator(10,
                              errorText:
                                  'This Field should contain atleast 10 numbers'),
                          MaxLengthValidator(10,
                              errorText: 'Only 10 numbers are allowed'),
                        ]),
                        autocorrect: true,
                        cursorColor: WHITE,
                      ),
                      SizedBox(
                        height: 35.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email_rounded,
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
                        style: GoogleFonts.poppins(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w300,
                          color: WHITE,
                          letterSpacing: 1.0,
                        ),
                        controller: _email,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: 'This Field cannot be left empty'),
                          EmailValidator(errorText: 'Invalid Mail ID'),
                        ]),
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
                        controller: _password,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String val) {
                          if (val.length < 6) {
                            return 'Password must be 6 or more characters in length';
                          }
                          return null;
                        },
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
                          labelText: 'Confirm Password',
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
                        controller: _conpassword,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String value) {
                          if (value.compareTo(_password.text) != 0) {
                            return 'Password and Confirm Password does not match';
                          } else if (value.isEmpty) {
                            return 'This field cannot be left empty';
                          }
                          return null;
                        },
                        autocorrect: true,
                        cursorColor: WHITE,
                      ),
                      SizedBox(
                        height: 35.0,
                      ),
                      ElevatedButton(
                        child: MyText(
                          'Sign Up',
                          color: WHITE,
                          fontWeight: 'Light',
                          size: 18,
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Profile(
                                  email: _email.text,
                                  name: _name.text,
                                  mobNo: _mobno.text,
                                  password: _password.text,
                                ),
                              ),
                            );
                          }
                        },
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all<double>(15),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            (RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                19,
                              ),
                            )),
                          ),
                          minimumSize:
                              MaterialStateProperty.all<Size>(Size(120, 55)),
                          backgroundColor: MaterialStateProperty.all((PRIMARY)),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyText(
                            'Have an account? ',
                            color: WHITE,
                            fontWeight: 'Medium',
                            size: 16,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            }, //Register
                            child: MyText(
                              'Log In.',
                              color: WHITE,
                              fontWeight: 'SemiBold',
                              size: 20,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
