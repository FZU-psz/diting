import 'dart:ui';

import 'package:diting/entity/article.dart';
import 'package:flutter/material.dart';
import 'package:diting/pages/article_page.dart';
import 'package:diting/utils/articleget.dart';
import 'package:provider/provider.dart';
import 'package:diting/utils/global.dart';

// ignore: must_be_immutable
class MyarticlePage extends StatefulWidget {
  String? ip = '';
  MyarticlePage({super.key, this.ip});

  @override
  MyarticlePageState createState() => MyarticlePageState();
}

class MyarticlePageState extends State<MyarticlePage> {
  List<Article> articles = [];
  final ScrollController _scrollController = ScrollController();
  var _ip='';
  var _name='diting';
  void _loadMoreData(String ip,String name) async {
      List<Article> newArticles = await ArticleGet.loadMoreDatabyId(ip,_name);
      setState(() {
        // Simulating data loading
        articles.addAll(newArticles);
      });
    }
    void _scrollListener() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // Reach the bottom of the ListView
        _loadMoreData(_ip,_name);
      }
    }

    @override
    void initState() {
      super.initState();
       var sharedDataNotifier = Provider.of<SharedDataNotifier>(context,listen: false);
       _ip = sharedDataNotifier.ip;
       _name = sharedDataNotifier.userData.name;
          _loadMoreData(sharedDataNotifier.ip,sharedDataNotifier.userData.name);
      _scrollController.addListener(_scrollListener);
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Row(children: [
          Text("我的发布  "),
          Icon(
            Icons.message,
            color: Colors.blue,
          )
        ])),
        body: ListView.separated(
          controller: _scrollController,
          separatorBuilder: (BuildContext context, int index) {
            // 在每一行之间添加间隙
            return const SizedBox(height: 10); // 调整间隙的大小
          },
          itemCount: articles.length,
          itemBuilder: (context, index) {
            if (index == articles.length - 1) {
              return const ListTile(
                title: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return ArticalCard(article: articles[index]);
            }
          },
        ));
  }
}

class ArticalCard extends StatefulWidget {
  const ArticalCard({super.key, required this.article});
  final Article article;

  @override
  State<StatefulWidget> createState() => ArticalCardState();
}

class ArticalCardState extends State<ArticalCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.article.essayName,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(widget.article.userAvatar),
                              radius: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(widget.article.userName,
                                  style: const TextStyle(fontSize: 12)),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            widget.article.essayContent,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: ClipRect(
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.network(
                          widget.article.essayAvatar,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticlePage(
                      article: widget.article,
                    )));
      },
    );
  }
}
