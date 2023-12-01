import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:diting/entity/article.dart';
import 'package:dio/dio.dart';

class ArticleGet {
  static Future<List<Article>> loadMoreData(String ip) async {
    final url = 'http://${ip}:8081/DiTing/essay/showList?offset=0';
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        // print(jsonData['data']);
        final List<Article> newArticles = (jsonData['data'] as List)
            .map((item) => Article.fromJson(item))
            .toList();
        return newArticles;
      } else {
        List<Article> articles = [Article(), Article(), Article(), Article()];
        return articles;
      }
    } catch (e) {
      // 处理超时异常，返回默认数据
      List<Article> defaultArticles = [
        Article(),
        Article(),
        Article(),
        Article(),
        Article(),
        Article(),
        Article(),
        Article(),
      ];
      return defaultArticles;
    }
  }

  static Future<List<Article>> loadMoreDatabyId(String ip, String name) async {
    final url = 'http://${ip}:8081/DiTing/user/showEssay?offset=0&pageSize=10';
    try {
      final response = await http
          .post(Uri.parse(url),
              headers: <String, String>{
                "Content-Type": "application/x-www-form-urlencoded"
              },
              body: "name=${name}")
          .timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print(jsonData['data']);
        final List<Article> newArticles = (jsonData['data'] as List)
            .map((item) => Article.fromJson(item))
            .toList();
        return newArticles;
      } else {
        List<Article> articles = [Article(), Article(), Article(), Article()];
        return articles;
        // throw Exception('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      // 处理超时异常，返回默认数据
      print('Timeout error: $e');
      List<Article> defaultArticles = [
        Article(),
        Article(),
        Article(),
        Article(),
        Article(),
        Article(),
        Article(),
        Article(),
      ];
      return defaultArticles;
    }
  }
}

class ArticleGetDio {
  static Future<List<Article>> loadMoreData(String ip) async {
    final url = 'http://${ip}:8081/DiTing/essay/showList?offset=1';
    try {
      final dio = Dio();
      final response = await dio.get(url).timeout(Duration(seconds: 15));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.data);
        final List<Article> newArticles = (jsonData['data'] as List)
            .map((item) => Article.fromJson(item))
            .toList();

        return newArticles;
      } else {
        // throw Exception('Request failed with status: ${response.statusCode}.');
        List<Article> articles = [Article(), Article(), Article(), Article()];
        return articles;
      }
    } catch (e) {
      // 处理超时异常，返回默认数据
      print('Timeout error: $e');

      List<Article> defaultArticles = [
        Article(),
        Article(),
        Article(),
        Article()
      ];
      return defaultArticles;
    }
  }
}
