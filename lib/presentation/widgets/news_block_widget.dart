import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:test_vasiliy/core/utils.dart';
import 'package:test_vasiliy/data/models/news_model.dart';
import 'package:test_vasiliy/presentation/bloc/saved/saved_bloc.dart';

class NewsBlockWidget extends StatefulWidget {
  final List<NewsModel> records;

  const NewsBlockWidget({required this.records, Key? key}) : super(key: key);

  @override
  _NewsBlockWidgetState createState() => _NewsBlockWidgetState();
}

class _NewsBlockWidgetState extends State<NewsBlockWidget> {
  bool isFavorite = true;

  @override
  Widget build(BuildContext context) {
    var records = widget.records;

    if (records.isEmpty) {
      return const Center(
        child: Text("Нет записей"),

      );
    } else {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: records.length,
          itemBuilder: (BuildContext context, int index) {
            NewsModel record = records[index];
            bool isSaved = isNewsSaved(record);

            return Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: Column(
                children: [
                  Stack(
                    children: [
                      FullScreenWidget(
                        child: Center(
                          child: Hero(
                            tag: "smallImage",
                            child: Stack(
                              children: [
                                ClipRect(
                                  child: Image.network(
                                    record.enclosure['url'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  child: isSaved
                                      ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        BlocProvider.of<SavedBloc>(context)
                                            .add(SavedRemoveEvent(record));
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: Colors.white,
                                    ),
                                  )
                                      : IconButton(
                                    onPressed: () {
                                      setState(() {
                                        BlocProvider.of<SavedBloc>(context)
                                            .add(SavedSaveEvent(record));
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.favorite_border,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.6),
                                          spreadRadius: 10,
                                          blurRadius: 14,
                                          offset:
                                          Offset(0, 10), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      record.title['\$t'],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        child: isSaved
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    BlocProvider.of<SavedBloc>(context)
                                        .add(SavedRemoveEvent(record));
                                  });
                                },
                                icon: const Icon(
                                  Icons.favorite,
                                  color: Colors.white,
                                ),
                              )
                            : IconButton(
                                onPressed: () {
                                  setState(() {
                                    BlocProvider.of<SavedBloc>(context)
                                        .add(SavedSaveEvent(record));
                                  });
                                },
                                icon: const Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                      Positioned(
                        bottom: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.6),
                                spreadRadius: 10,
                                blurRadius: 14,
                                offset:
                                    Offset(0, 10), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Text(
                            record.title['\$t'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [],
                  ),
                ],
              ),
            );
          });
    }
  }
}
