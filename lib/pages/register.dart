import 'dart:convert';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import './home.dart';
import 'package:diting/utils/global.dart';
import 'package:provider/provider.dart';
import 'package:diting/pages/more_page.dart';
class register extends StatefulWidget {
  const register({super.key});
  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _tel = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var sharedDataNotifier = Provider.of<SharedDataNotifier>(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/back2.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 250,
                    child: Center(
                      child: Image.asset(
                        'assets/title.png',
                        width: 300,
                        height: 200,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.white.withOpacity(0.3),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(children: [
                              Container(
                                height: 35,
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: TextField(
                                  controller: _username,
                                  decoration: InputDecoration(
                                      labelText: "请输入用户名",
                                      icon: const Icon(Icons.people),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 35,
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: TextField(
                                  controller: _tel,
                                  decoration: InputDecoration(
                                      labelText: "请输入电话号码",
                                      icon: const Icon(Icons.phone_android),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50))),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 35,
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: TextField(
                                  obscureText: true,
                                  controller: _password,
                                  decoration: InputDecoration(
                                      labelText: "请输入密码",
                                      icon: const Icon(Icons.password),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50))),
                                ),
                              ),
                              Container(
                                width: 120,
                                child: TextButton(
                                    child: const Text(
                                      '注册',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Color.fromARGB(
                                              255, 165, 159, 159)),
                                    ),
                                    onPressed: () async {
                                      if (_username.text.isEmpty) {
                                        CherryToast.warning(
                                                title: const Text("用户名称为空"))
                                            .show(context);
                                      } else if (_tel.text.isEmpty) {
                                        CherryToast.warning(
                                                title: const Text("电话号码为空"))
                                            .show(context);
                                      } else if (_password.text.isEmpty) {
                                        CherryToast.warning(
                                                title: const Text("密码为空"))
                                            .show(context);
                                      } else {
                                        try {
                                          
                                          final url = Uri.parse(
                                              "http://${sharedDataNotifier.ip}:8081/DiTing/user/register");
                                          final response = await http.post(url,
                                              headers: <String, String>{
                                                "Content-Type":
                                                    "application/x-www-form-urlencoded"
                                              },
                                              body:
                                                  "name=${_username.text}&telephone=${_tel.text}&password=${_password.text}");
                                          final Data =
                                              jsonDecode(response.body);
                                          final code = Data["code"];

                                          if (code == 200) {
                                            // ignore: use_build_context_synchronously
                                            CherryToast.success(
                                              title: const Text("注册成功,5s后跳转到登录界面"),
                                            ).show(context);
                                            Future.delayed(const Duration(seconds: 5),
                                                () {
                                              Navigator.pop(context);
                                            });
                                          }
                                        } catch (error) {
                                          // ignore: use_build_context_synchronously
                                          CherryToast.error(title: const  Text("注册失败"))
                                              .show(context);
                                          // print("登录失败");
                                        }
                                      }
                                      ;
                                    }),
                              ),
                            ]))),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 50, right: 50),
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "已有帐号，登录",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 230, 225, 225)),
                            )),
                        TextButton(onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return const MorePage();
                              }));
                        }, child:const Text(
                          "更多",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ))
                        
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}
