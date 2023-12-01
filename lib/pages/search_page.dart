import 'package:cherry_toast/cherry_toast.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:diting/utils/global.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SearchPage extends StatefulWidget {
  SearchPage({super.key});

  String ip = '';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();
  var _ip='';
  void initState(){
    var sharedDataNotifier = Provider.of<SharedDataNotifier>(context,listen: false);
      _ip = sharedDataNotifier.ip;
  }
  Widget buildTags(List<String> words) {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: words.map((e) {
        return DecoratedBox(
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: InkWell(
              child: Text(e, style: const TextStyle(fontSize: 12)),
              onTap: () {
                _controller.text += e;
              },
            ),
          ),
        );
      }).toList(),
    );
  }

  bool switchvalue = false;
  @override
  Widget build(BuildContext context) {
    var sharedDataNotifier = Provider.of<SharedDataNotifier>(context);
    // UserData userdata = sharedDataNotifier.userData;
    String _ip = sharedDataNotifier.ip;
    return MaterialApp(
      title: '谛听',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                title: const Text('LAN Server IP(for classifiter)'),
                onTap: () {
                  var controller = TextEditingController(text: '');
                  showAboutDialog(
                    context: context,
                    children: [
                      TextField(controller: controller),
                      ElevatedButton(
                          onPressed: () {
                            _ip = controller.text;
                          },
                          child: const Text('确定')),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/back2.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Align(
              //     // alignment: Alignment.centerRight,
              //     child: Switch(
              //   value: switchvalue,
              //   activeColor: Colors.green,
              //   onChanged: (switchvalue) {},
              // )),
              Image.asset(
                'assets/title.png',
                width: 300,
                height: 200,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.white.withOpacity(0.6),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                    child: Column(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _controller,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: '输入需要鉴别的网址',
                                    contentPadding: EdgeInsets.all(4),
                                  ),
                                ),
                              ),
                              IconButton(
                                splashRadius: 16,
                                icon: const Icon(Icons.search),
                                onPressed: () async {
                                  try {
                                    final String url = _controller.text;
                                    final body =
                                        'url=${Uri.encodeComponent(url)}';
                                    final response = await http
                                        .post(
                                          Uri.parse(
                                              'http://${_ip}:8081/DiTing/website/tag'),
                                          headers: {
                                            'Content-Type':
                                                'application/x-www-form-urlencoded'
                                          },
                                          body: body,
                                        )
                                        .timeout(const Duration(seconds: 15));
                                    if (!mounted) return;
                                    if (response.statusCode == 200) {
                                      final responseBody =
                                          json.decode(response.body);
                                      final data =
                                          responseBody['data'] as String;
                                      if (data == 'danger') {
                                        CherryToast.error(
                                                title: const Text("危险!"))
                                            .show(context);
                                      } else {
                                        CherryToast.success(
                                                title: const Text("正常"))
                                            .show(context);
                                      }
                                    } else {
                                      CherryToast.warning(
                                              title: const Text("服务器异常"))
                                          .show(context);
                                      // throw Exception('Failed to judge the website');
                                    }
                                  } catch (e) {
                                    CherryToast.warning(
                                      title: const Text("网络异常"),
                                    ).show(context);
                                    print(e.toString());
                                    // 可以考虑在这里添加一些用户友好的错误处理逻辑
                                  }

                                  // try {
                                  //   Dio client = Dio();
                                  //   var resp = client.post(
                                  //       'http://${widget.ip}:8080/diting',
                                  //       data: _controller.text);
                                  //   resp.then((v) {
                                  //     var value = v.data;
                                  //     if (value != '正常') {
                                  //       CherryToast.error(
                                  //         title: Text(value),
                                  //       ).show(context);
                                  //     } else {
                                  //       CherryToast.info(
                                  //         title: Text(value),
                                  //       ).show(context);
                                  //     }
                                  //   });
                                  // } catch (e, trace) {
                                  //   print(e);
                                  //   print(trace);
                                  //   // ignore: use_build_context_synchronously
                                  //   CherryToast.error(
                                  //     title: Text('网络错误'),
                                  //   ).show(context);
                                  // }
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        buildTags(
                            ['https://', 'http://', '/', 'www', '.com', '.cn']),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 120,
              ),
              Image.asset('assets/slogen.png', width: 400, height: 100),
            ],
          )),
        ),
      ),
    );
  }
}
