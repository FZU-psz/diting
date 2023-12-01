import 'package:cherry_toast/cherry_toast.dart';
import 'package:diting/pages/dangerwebsite_page.dart';
import 'package:diting/pages/globalset_page.dart';
import 'package:diting/pages/myarticle_page.dart';
import 'package:diting/pages/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:diting/utils/global.dart';
import 'package:provider/provider.dart';
import 'package:diting/pages/login.dart';

/*个人中心页*/
class PersonPage extends StatefulWidget {
  const PersonPage({super.key});
  @override
  State<PersonPage> createState() => _PersonPage();
}

class _PersonPage extends State<PersonPage> {
  @override
  Widget build(BuildContext context) {
    var sharedDataNotifier = Provider.of<SharedDataNotifier>(context);
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [Color(0xFFBBDEFB), Colors.white70], //背景渐变色：顶部蓝色到底部灰色
        begin: Alignment.topCenter, //颜色渐变从顶部居中开始
        end: Alignment.bottomCenter, //颜色渐变从底部居中结束
      )), //背景装饰：颜色渐变
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 90, 10, 40),
            child: Row(
              children: [
                GestureDetector(
                  child: ClipOval(
                    child: Image.network(sharedDataNotifier.userData.avatar,
                        width: 75, height: 75, fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                      // 显示默认头像或错误占位符
                      return Image.network(
                        "http://s4vhmosi8.hd-bkt.clouddn.com/FpSVKu6mlGLwBgnpmoNrT6lFACsK",
                        width: 75,
                        height: 75,
                        fit: BoxFit.cover,
                      );
                    }),
                  ),
                  //TO DO  upload user's avatar
                  onTap: () {},
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 45, 0),
                    child: Text(sharedDataNotifier.userData.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 23))),
                TextButton(
                  style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all(const Size(80, 60)), //按钮宽高设置
                    foregroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(100, 30, 144, 255)), //背景色
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))), //圆角
                  ),
                  child: const Text('编辑资料',
                      style: TextStyle(color: Colors.blueAccent)),
                  //To DO setting page
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SettingPage()));
                  },
                ),
              ],
            ),
          ),
          /*用户数据：关注+收藏+历史*/
          Container(
              margin: const EdgeInsets.all(8),
              height: 80,
              width: 360,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, //主轴方向（横向）间距
                children: [
                  Column(
                    children: [
                      Text('66',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16)),
                      Text('关注'),
                    ],
                  ),
                  Column(
                    children: [
                      Text('101',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16)),
                      Text('收藏'),
                    ],
                  ),
                  Column(
                    children: [
                      Text('278',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16)),
                      Text('点赞'),
                    ],
                  ),
                  Column(
                    children: [
                      Text('579',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16)),
                      Text('历史'),
                    ],
                  ),
                ],
              )),
          /*常用功能*/
          Container(
              margin: const EdgeInsets.all(5),
              height: 120,
              width: 360,
              decoration: BoxDecoration(
                color: const Color.fromARGB(200, 248, 248, 255), // 白色
                borderRadius: BorderRadius.circular(12), // 设置圆角
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, //垂直方向平分
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text('  常用功能',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14)),
                  ),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly, //主轴方向（横向）间距
                    children: [
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.message),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MyarticlePage()));
                            },
                            color: Colors.blue,
                          ),
                          const Text('我的发布'),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.dangerous),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const DangerousPage()));
                            },
                            color: Colors.redAccent,
                          ),
                          const Text('危险网站'),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.settings),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const GlobalsetPage()));
                            },
                            color: Colors.green,
                          ),
                          const Text('设置'),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.output),
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) {
                                return const login();
                              }), (route) => false);
                            },
                            color: Colors.deepOrangeAccent,
                          ),
                          const Text('退出'),
                        ],
                      )
                    ],
                  )
                ],
              )),
          ElevatedButton(
              onPressed: () {
                CherryToast.info(title: Text('ip:${sharedDataNotifier.ip}'))
                    .show(context);
              },
              child: const Text('查看当前服务的ip'))
        ],
      ),
    );
  }
}
