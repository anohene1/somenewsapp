import 'dart:collection';

import 'package:flutter/material.dart';

class NewsCategory {
  final String categoryName;
  bool isSelected;

  NewsCategory({required this.categoryName, this.isSelected = false});
}

class NewsCategories extends ChangeNotifier {
  List<NewsCategory> newsCategories = [
    NewsCategory(categoryName: 'Sport', isSelected: true),
    NewsCategory(categoryName: 'Entertainment'),
    NewsCategory(categoryName: 'Business'),
    NewsCategory(categoryName: 'World'),
    NewsCategory(categoryName: 'Health'),
    NewsCategory(categoryName: 'Politics'),
    NewsCategory(categoryName: 'Music'),
  ];

  UnmodifiableListView<NewsCategory> get allCategories {
    return UnmodifiableListView(newsCategories);
  }

  void deselectAllCategories() {
    newsCategories.forEach((category) {
      category.isSelected = false;
    });
    notifyListeners();
  }

  void selectCategory(NewsCategory newsCategory) {
    newsCategory.isSelected = true;
    notifyListeners();
  }
}
