import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../authentication/login.dart';
import '../session/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? mobileno, name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loaddata();
  }

  loaddata() async {
    mobileno = await Store.getUsername();
    name = await Store.getname();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Profile Screen"),
            Text(mobileno ?? "Loading"),
            Text(name ?? "Loading"),
            TextButton(
                onPressed: () async {
                  bool? shouldLogout = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      return CupertinoAlertDialog(
                        title: Text('Confirm Logout'),
                        content: Text('Are you sure you want to logout?'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                          ),
                          TextButton(
                            child: Text('Logout'),
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                          ),
                        ],
                      );
                    },
                  );

                  if (shouldLogout == true) {
                    // Perform logout action here
                    print('User confirmed logout');

                    await Store.clear();

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                    // Add your logout logic (e.g., clearing session, navigating to login screen)
                  }
                },
                child: Text("Logout")),
            TextButton(
                onPressed: () async {
                  bool? shouldLogout = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      return CupertinoAlertDialog(
                        title: Text('Confirm Delete'),
                        content:
                            Text('Are you sure you want to delete account?'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                          ),
                          TextButton(
                            child: Text('Delete'),
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                          ),
                        ],
                      );
                    },
                  );

                  if (shouldLogout == true) {
                    // Perform logout action here
                    print('User confirmed logout');

                    await Store.clear();

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                    // Add your logout logic (e.g., clearing session, navigating to login screen)
                  }
                },
                child: Text("Delete Account"))
          ],
        ),
      ),
    );
  }
}
