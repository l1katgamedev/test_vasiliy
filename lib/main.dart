import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:test_vasiliy/data/datasources/auth_service.dart';
import 'package:test_vasiliy/data/repositories/news_repository.dart';
import 'package:test_vasiliy/presentation/bloc/news/news_bloc.dart';
import 'package:test_vasiliy/presentation/bloc/saved/saved_bloc.dart';
import 'package:test_vasiliy/presentation/screens/login_screen.dart';
import 'package:test_vasiliy/presentation/screens/register_screen.dart';
import 'package:test_vasiliy/wrapper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<NewsBloc>(
          create: (BuildContext context) => NewsBloc(NewsRepository()),
        ),
        BlocProvider<SavedBloc>(
          create: (BuildContext context) => SavedBloc(NewsRepository()),
        ),
        Provider<AuthService>(create: (_) => AuthService(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const Wrapper(),
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
        },
      ),
    );
  }
}
