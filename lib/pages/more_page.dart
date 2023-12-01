import 'package:cherry_toast/cherry_toast.dart';
import 'package:diting/main.dart';
import 'package:flutter/material.dart';
import 'package:diting/utils/global.dart';
import 'package:provider/provider.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    var sharedDataNotifier = Provider.of<SharedDataNotifier>(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        // appBar: AppBar(),
        body: Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/back2.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: ListView(padding: const EdgeInsets.all(25), children: [
              const SizedBox(
                height: 250,
              ),
              Opacity(
                opacity: 0.3,
                child: ElevatedButton(
                    onPressed: () {
                      var controller = TextEditingController(text: '');
                      showAboutDialog(
                        applicationName: "Server IP",
                        context: context,
                        children: [
                          TextField(controller: controller),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                sharedDataNotifier.ip = controller.text;
                                CherryToast.success(
                                        title: Text(
                                            "Successfully set server IP to:${controller.text}"))
                                    .show(context);
                                Navigator.of(context).pop();
                              },
                              child: const Text('确定')),
                        ],
                      );
                    },
                    child: const Text(
                      "Setting The Server IP",
                      style: TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 48, 184, 214)),
                    )),
              ),
              const SizedBox(height: 20),
              Opacity(
                opacity: 0.3,
                child: ElevatedButton(
                  child: const Text(
                    "管理员登录",
                    style: TextStyle(
                        fontSize: 25, color: Color.fromARGB(255, 71, 167, 189)),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false, // 禁止点击空白处关闭对话框
                      builder: (BuildContext context) {
                        return const Center(
                          child: CircularProgressIndicator(), // 加载中的圆形进度条
                        );
                      },
                    );

                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainPage()),
                        (route) => false,
                      ).then((value) {
                        // 在新页面关闭后，关闭加载中的对话框
                        Navigator.pop(context);
                      });
                    });
                  },
                ),
              ),
            ])));
  }
}
