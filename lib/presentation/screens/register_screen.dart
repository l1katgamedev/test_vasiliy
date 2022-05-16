import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_vasiliy/data/datasources/auth_service.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    final authServvice = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: Colors.black87,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: "Password",
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
             await authServvice.createUserWithEmailAndPassword(emailController.text, passwordController.text);
              Navigator.pushNamed(context, '/login');
            },
            child: Text('Register'),
          ),
        ],
      ),
    );
  }
}
