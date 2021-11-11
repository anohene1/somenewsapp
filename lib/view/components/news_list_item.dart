import 'package:flutter/material.dart';
import 'package:newsapp/model/models.dart';

class NewsListItem extends StatelessWidget {
  final Article article;
  final void Function() onTap;

  NewsListItem({required this.article, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 150,
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    article.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  // SizedBox(height: 20,),
                  Row(
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
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(article.media!), fit: BoxFit.cover)),
            )
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: 25),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: Colors.black12, width: 1))),
      ),
    );
  }
}
