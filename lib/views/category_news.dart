import 'package:flutter/material.dart';

import '../helper/blog_tile.dart';
import '../helper/news.dart';
import '../models/article_model.dart';

class CategoryNews extends StatefulWidget {
  final String category;
  const CategoryNews({super.key, required this.category});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel> articles = [];
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNew();
  }
  getCategoryNew() async {
    NewsCategory newsClass = NewsCategory();
    await newsClass.getCategoryNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("News"),
            Text(
              "Tak",
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
        actions: [
          Opacity(
            opacity: 0,
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Icon(Icons.save)
            ),
          )

        ],
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading
          ? const Center(
        child: CircularProgressIndicator(),
      ) : SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              /// Blogs
              Container(
                padding: const EdgeInsets.only(top: 15, left: 16, right: 16),
                child: ListView.builder(
                  itemCount: articles.length,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return BlogTile(
                      imageUrl: articles[index].urlToImage,
                      title: articles[index].title,
                      desc: articles[index].description,
                      url: articles[index].url,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

