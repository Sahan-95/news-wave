import 'package:flutter/material.dart';

import '../../managers/injection_container.dart';
import '../../managers/local_storage_manager.dart';
import '../home_screen/home_screen.dart';
import '../login_screen/login_screen.dart';

class CheckLoggedInStatus extends StatelessWidget {
  const CheckLoggedInStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkUserLoggedIn(),
      builder: (context, snapshot) {
        // Check if the data is still loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasData && snapshot.data == true) {
          // If first name and last name are found, navigate home screen
          return const HomeScreen();
        } else {
          // Otherwise, navigate login screen
          return const LoginScreen();
        }
      },
    );
  }

  Future<bool> _checkUserLoggedIn() async {
    // Check if both first name and last name are stored
    final firstName = await getIt<SharedPreferencesService>().getFirstName();
    final lastName = await getIt<SharedPreferencesService>().getLastName();

    // If both are not null, user is considered logged in
    return firstName != null && lastName != null;
  }
}
