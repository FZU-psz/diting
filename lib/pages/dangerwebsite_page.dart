import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:diting/utils/global.dart';
import 'package:provider/provider.dart';

class DangerousPage extends StatefulWidget {
  const DangerousPage({super.key});

  @override
  State<DangerousPage> createState() => _DangerousPageState();
}

class _DangerousPageState extends State<DangerousPage> {
  List<String> scamWebsites = [];
  String ip = '';

  final ScrollController _scrollController = ScrollController();
  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Reach the bottom of the ListView
      addwebsite();
    }
  }

  @override
  void initState() {
    super.initState();

      var sharedDataNotifier = Provider.of<SharedDataNotifier>(context,listen: false);
      ip = sharedDataNotifier.ip;

    addwebsite();
    _scrollController.addListener(_scrollListener);
  }

  void addwebsite() async {
    List<String> addlist = await _fetchScamWebsites(ip);
    setState(() {
      scamWebsites.addAll(addlist);
    });
  }

  Future<List<String>> _fetchScamWebsites(String ip) async {
    try {
      final response = await http
          .get(Uri.parse(
              'http://${ip}:8081/DiTing/website/showList?offset=0&pageSize=10'))
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        // 这里假设 'data' 是包含所需信息的键
        final List<dynamic> sitesList = responseBody['data'];
        List<String> addlist = sitesList
            .where((site) => site['tag'] == 'danger')
            .map((site) => site['url'].toString())
            .toList();
        // print(addlist);
        return addlist;
      } else {
        // ignore: use_build_context_synchronously
        CherryToast.error(title: const Text("请求失败")).show(context);
        List<String> list = [
          'http://www.diting.com/',
          'http://www.diting.com/',
          'http://www.diting.com/',
          'http://www.diting.com/',
          'http://www.diting.com/',
          'http://www.diting.com/',
          'http://www.diting.com/',
          'http://www.diting.com/',
        ];
        return list;
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      print(e);
      CherryToast.error(title: const Text("网络错误")).show(context);
      List<String> list = [
        'http://www.diting.com/',
        'http://www.diting.com/',
        'http://www.diting.com/',
        'http://www.diting.com/',
        'http://www.diting.com/',
        'http://www.diting.com/',
        'http://www.diting.com/',
        'http://www.diting.com/',
        'http://www.diting.com/',
        'http://www.diting.com/',
        'http://www.diting.com/',
        'http://www.diting.com/',
        'http://www.diting.com/',
        'http://www.diting.com/',
        'http://www.diting.com/',
        'http://www.diting.com/',
      ];
      return list;
      // ignore: use_build_context_synchronously
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(children: [
          Text("危险网站  "),
          Icon(
            Icons.dangerous,
            color: Colors.redAccent,
          ),
        ]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
            child: ListView.separated(
          controller: _scrollController,
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemCount: scamWebsites.length,
          itemBuilder: (context, index) {
            if (index == scamWebsites.length - 1) {
              return const ListTile(
                title: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return Text(
                scamWebsites[index],
                style: const TextStyle(fontSize: 18),
              );
            }
          },
        )),
      ),
    );
  }
}
