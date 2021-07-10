import 'package:connectivity_widget/connectivity_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repostaffs/constants.dart';
import 'package:repostaffs/helpers/wrapper.dart';
import 'package:repostaffs/providers/auth.dart';
import 'package:repostaffs/screens/internet_error_dialog.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  ConnectivityUtils.instance
      .setCallback((response) => response.contains("This is a test!"));
  ConnectivityUtils.instance.setServerToPing(
      "https://gist.githubusercontent.com/Vanethos/dccc4b4605fc5c5aa4b9153dacc7391c/raw/355ccc0e06d0f84fdbdc83f5b8106065539d9781/gistfile1.txt");

  runApp(
    MultiProvider(
      providers: [
        Provider<AuthenticationProvider>(
          create: (_) => AuthenticationProvider(FirebaseAuth.instance),
        ),
        StreamProvider(
          initialData: null,
          create: (context) =>
              context.read<AuthenticationProvider>().authStateChanges,
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        iconTheme: IconThemeData(
          color: WHITE,
        ),
        buttonColor: WHITE,
        primaryColor: PRIMARY,
        canvasColor: SECONDARY,
        accentColor: PRIMARY,
      ),
      home: ConnectivityWidget(
        showOfflineBanner: false,
        builder: (context, isOnline) {
          return isOnline ? Wrapper() : InternetErrorDialog();
        },
      ),
    );
  }
}
