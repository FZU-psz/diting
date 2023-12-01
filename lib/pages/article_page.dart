import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:diting/entity/article.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:diting/utils/global.dart';

// ignore: must_be_immutable
class ArticlePage extends StatefulWidget {
  Article article;
  ArticlePage({super.key, required this.article});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  bool _isLike = false;
  @override
  Widget build(BuildContext context) {
    var sharedDataNotifier = Provider.of<SharedDataNotifier>(context);
    var ip = sharedDataNotifier.ip;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_isLike == false) {
            try {
              final url = Uri.parse(
                  "http://192.168.8.184:8081/DiTing/essay/likes?id=${widget.article.essayid}");
              
              final response = await http.get(url).timeout(const Duration(seconds: 10));
              final Data = jsonDecode(response.body);
              // final code = Data["msg"];
              if (response.statusCode ==200) {
                // ignore: use_build_context_synchronously
                CherryToast.success(title: const Text("点赞成功")).show(context);
              }
            } catch (e) {
              // ignore: use_build_context_synchronously
              CherryToast.error(title:  const Text('点赞失败')).show(context);
            }
          }
          setState(() {
            widget.article.likeCount = widget.article.likeCount + 1;
            _isLike = !_isLike;
          });
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          Icons.thumb_up,
          color: _isLike ? Colors.redAccent : Colors.blueAccent,
        ),
      ),
      appBar: AppBar(
        title: Text(
          widget.article.essayName,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
          child: ListView(
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage(widget.article.essayAvatar),
                      fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.article.userAvatar),
                    radius: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(widget.article.userName,
                        style: const TextStyle(fontSize: 15)),
                  ),
                ],
              ),
              const Divider(),
              Text(widget.article.essayName,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(
                widget.article.essayContent,
                style: const TextStyle(fontSize: 15),
              )
            ],
          )),
      // bottomNavigationBar: AppBar(title:IconButton(icon: Icon(Icons.thumb_up),onPressed: (){},)),
    );
  }
}
