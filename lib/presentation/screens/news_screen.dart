import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:test_vasiliy/data/datasources/auth_service.dart';
import 'package:test_vasiliy/presentation/bloc/news/news_bloc.dart';
import 'package:test_vasiliy/presentation/screens/login_screen.dart';
import 'package:test_vasiliy/presentation/screens/profile_screen.dart';
import 'package:test_vasiliy/presentation/widgets/news_block_widget.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    BlocProvider.of<NewsBloc>(context).add(NewsLoadEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Новости'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileScreen()));
                },
                icon: const Icon(Icons.person)),
            IconButton(
              onPressed: () async {
                Navigator.popAndPushNamed(
                  context, '/login'
                );
                await authService.signOut();
              },
              icon: const Icon(Icons.exit_to_app),
            ),
          ],
          backgroundColor: Colors.black87,
        ),
        body: BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
          if (state is NewsLoadedState) {
            return RefreshIndicator(
              child: NewsBlockWidget(
                records: state.records,
              ),
              onRefresh: () async {
                BlocProvider.of<NewsBloc>(context).add(NewsLoadEvent());
              },
            );
          }

          if (state is NewsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          return const Center(child: Text("Ошибка сети"));
        }));
  }
}
