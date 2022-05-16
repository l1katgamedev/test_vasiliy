import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_vasiliy/data/datasources/auth_service.dart';
import 'package:test_vasiliy/data/models/users_model.dart';
import 'package:test_vasiliy/presentation/screens/login_screen.dart';
import 'package:test_vasiliy/presentation/screens/splash_screen.dart';
import 'data/datasources/auth_service.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (_, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          return user == null ? LoginScreen() : SplashScreen();
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
