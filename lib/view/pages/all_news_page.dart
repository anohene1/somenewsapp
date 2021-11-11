import 'package:flutter/material.dart';
import 'package:newsapp/model/models.dart';
import 'package:newsapp/view/components/components.dart';
import 'package:newsapp/view/pages/pages.dart';

class AllNewsPage extends StatelessWidget {
  final List<Article> articles;

  const AllNewsPage({Key? key, required this.articles}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(itemBuilder: (context, index) {
          final article = articles[index];
          return NewsListItem(
              article: article,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ArticlePage(article: article)));
              });
        }),
      ),
    );
  }
}
