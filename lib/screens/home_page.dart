import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repostaffs/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<UserClass>(context);
    // String uid = user.uid;

    // AuthService _auth = new AuthService();
    final firebaseUser = context.watch<User>();

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Hello' + ' ' + firebaseUser.uid),
          SizedBox(
            height: 100,
          ),
          TextButton(
            onPressed: () {
              // _auth.signOut();
              context.read<AuthenticationService>().signOut();
            },
            child: Text('logout'),
          )
        ],
      ),
    );
  }
}
