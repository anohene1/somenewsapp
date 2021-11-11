import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/view/pages/pages.dart';
import 'package:provider/provider.dart';
import '../../model/models.dart';
import '../components/components.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class PageIndex extends ChangeNotifier {
  int index;
  PageIndex({this.index = 0});

  void setPageIndex(int number) {
    index = number;
    notifyListeners();
  }
}

DateTime now = DateTime.now();
final DateFormat formatter = DateFormat.MMMMEEEEd();
final formattedDate = formatter.format(now);

class _HomeScreenState extends State<HomeScreen> {
  List<Article> articles = [];
  bool isLoading = true;
  bool noNews = true;

  void getNews({String topic = 'sport'}) async {
    News news = News();
    await news.fetchNews(topic);
    articles = news.articles;
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getNews();
    noNews = articles.isNotEmpty ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      formattedDate,
                      style: TextStyle(color: Colors.red),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('SomeNewsApp',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.bold))
                  ],
                ),
              ),
            ),
            SliverAppBar(
              floating: true,
              pinned: true,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              expandedHeight: 35,
              flexibleSpace: Container(
                  margin: EdgeInsets.only(top: 10),
                  height: 35,
                  child: Consumer<NewsCategories>(
                    builder: (context, category, child) {
                      return ListView.builder(
                        itemCount: category.allCategories.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final newsCategory = category.allCategories[index];
                          return NewsCategoryItem(
                            newsCategory: newsCategory,
                            onTap: () {
                              category.deselectAllCategories();
                              category.selectCategory(newsCategory);
                              setState(() {
                                isLoading = true;
                                getNews(
                                    topic: newsCategory.categoryName
                                        .toLowerCase());
                              });
                            },
                          );
                        },
                      );
                    },
                  )),
            ),
            isLoading || !noNews
                ? SliverToBoxAdapter(child: SizedBox.shrink())
                : SliverToBoxAdapter(
                    child: CarouselSlider(
                    options: CarouselOptions(
                        height: 150.0, autoPlay: true, enlargeCenterPage: true),
                    items: articles.getRange(4, 8).map((article) {
                      return Builder(
                        builder: (BuildContext context) {
                          return CarouselCard(
                            article: article,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ArticlePage(article: article)));
                            },
                          );
                        },
                      );
                    }).toList(),
                  )),
            isLoading || !noNews
                ? SliverToBoxAdapter(child: SizedBox.shrink())
                : SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Latest',
                            style: TextStyle(color: Colors.red),
                          ),
                          InkWell(
                            child: Text(
                              'See all',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AllNewsPage(
                                            articles: articles,
                                          )));
                            },
                          )
                        ],
                      ),
                    ),
                  ),
            isLoading
                ? SliverToBoxAdapter(
                    child: Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 3.5),
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Colors.red,
                      strokeWidth: 2,
                    )),
                  ))
                : !noNews
                    ? SliverToBoxAdapter(
                        child: Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 3.5),
                        child: Center(
                            child: Text(
                                'Unfortunately, there are no news at the moment. Please check back later.')),
                      ))
                    : SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final article = articles[index];
                          return NewsListItem(
                            article: article,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ArticlePage(article: article)));
                            },
                          );
                        }, childCount: 5),
                      )
          ],
        ),
      ),
    ));
  }
}
