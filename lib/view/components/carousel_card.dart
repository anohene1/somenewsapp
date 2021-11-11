import 'package:flutter/material.dart';
import 'package:newsapp/model/models.dart';

class CarouselCard extends StatelessWidget {
  final Article article;
  final void Function() onTap;

  CarouselCard({required this.article, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                  image: NetworkImage(article.media!), fit: BoxFit.cover)),
          child: Stack(
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black26, Colors.black54])),
              ),
              Positioned(
                child: Text(
                  article.title,
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white.withOpacity(0.8),
                      fontWeight: FontWeight.bold),
                ),
                top: 20,
                left: 20,
                right: 40,
              ),
              Positioned(
                child: Text(
                  article.author.toString(),
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.white70,
                  ),
                ),
                bottom: 20,
                left: 20,
                right: 100,
              ),
              Positioned(
                child: Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 12,
                      color: Colors.white70,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      article.findTime(article.publishedDate),
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                bottom: 20,
                right: 20,
              )
            ],
          )),
    );
  }
}
