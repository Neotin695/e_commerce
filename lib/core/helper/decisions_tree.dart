import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../view/admin/main_admin_screen.dart';
import '../../view/auth/login_screen.dart';
import '../../view/main/main_home_screen.dart';

class Decisions extends StatelessWidget {
  const Decisions({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          final user = snapshot.data;

          if (user!.email == 'mehani695@gmail.com') {
            return const MainAdminScreen();
          }
          return const MainHomeScreen();
        }
        return LoginScreen();
      },
    );
  }
}
