import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repostaffs/constants.dart';
import 'package:repostaffs/screens/wrapper.dart';
import 'package:repostaffs/services/auth.dart';

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
