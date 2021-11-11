import 'package:flutter/material.dart';
import 'package:newsapp/model/models.dart';

class NewsCategoryItem extends StatelessWidget {
  final NewsCategory newsCategory;
  final void Function() onTap;
  NewsCategoryItem({required this.newsCategory, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: 25),
        child: Text(
          newsCategory.categoryName,
          style: TextStyle(fontSize: 15),
        ),
        decoration: BoxDecoration(
            border: Border(
                bottom: newsCategory.isSelected
                    ? BorderSide(color: Colors.red, width: 2)
                    : BorderSide.none)),
      ),
    );
  }
}
