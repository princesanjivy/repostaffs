import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:repostaffs/constants.dart';
import 'package:repostaffs/screens/home_page.dart';
import 'package:repostaffs/screens/login.dart';
import 'package:repostaffs/screens/profile_pic.dart';
import 'package:repostaffs/screens/sign_up.dart';
import 'package:provider/provider.dart';
import 'package:repostaffs/services/auth.dart';
import 'package:repostaffs/screens/Wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          initialData: null,
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
        )
      ],
      child: MaterialApp(
        routes: {
          'LoginPage': (context) => Login(),
          'Register': (context) => SignUp(),
          'ProfilePic': (context) => Profile(),
        },
        theme: ThemeData(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          buttonColor: Colors.white,

          // textTheme: GoogleFonts.poppinsTextTheme().apply(
          //   bodyColor: Colors.white,
          // ),

          // textTheme: GoogleFonts.poppinsTextTheme().apply(
          //   bodyColor: Colors.white,
          // ),
          primaryColor: PRIMARY,
          canvasColor: SECONDARY,
          accentColor: PRIMARY,
        ),
        home: Wrapper(),
      ),
    );
  }
}
