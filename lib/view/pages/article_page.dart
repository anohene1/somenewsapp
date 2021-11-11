import 'package:flutter/material.dart';
import 'package:newsapp/model/models.dart';
import 'package:share/share.dart';

class ArticlePage extends StatelessWidget {
  final Article article;

  const ArticlePage({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            expandedHeight: 400,
            actions: [
              IconButton(
                  onPressed: () {
                    Share.share(
                        "${article.title} \n \n Read more here: ${article.link!}");
                  },
                  icon: Icon(Icons.share))
            ],
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(article.media!), fit: BoxFit.cover)),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                article.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 12,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    article.findTime(article.publishedDate),
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Author: ${article.author.toString()}',
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                child: Text(article.summary!,
                    style: TextStyle(
                        fontSize: 18, color: Colors.black54, height: 1.7)),
              ),
            )
          ]))
        ],
      ),
    );
  }
}
