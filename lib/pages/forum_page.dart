import 'package:diting/entity/article.dart';
import 'package:flutter/material.dart';
import 'package:diting/pages/article_page.dart';
import 'package:diting/utils/articleget.dart';
import 'package:provider/provider.dart';
import 'package:diting/utils/global.dart';

// ignore: must_be_immutable
class ForumPage extends StatefulWidget {
  String? ip = '';
  ForumPage({super.key, this.ip});

  @override
  ForumPageState createState() => ForumPageState();
}

class ForumPageState extends State<ForumPage> {
  List<Article> articles = [];
  String _ip = '';
  ScrollController _scrollController = ScrollController();
  void _loadMoreData(String ip) async {
    List<Article> newArticles = await ArticleGet.loadMoreData(_ip);

    setState(() {
      // Simulating data loading
      articles.addAll(newArticles);
    });
  }

  @override
  void initState() {
    super.initState();
    var sharedDataNotifier =
        Provider.of<SharedDataNotifier>(context, listen: false);
    _ip = sharedDataNotifier.ip;

    _loadMoreData(sharedDataNotifier.ip);

    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Reach the bottom of the ListView
      _loadMoreData('192.168.8.184');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
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
    );
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
