import 'package:flutter/material.dart';

class UserData {
  int userId;
  String name;
  String telephone;
  String avatar ="http://s4vhmosi8.hd-bkt.clouddn.com/FpSVKu6mlGLwBgnpmoNrT6lFACsK";
  String password = '123';

  UserData({
    this.userId = 1,
    this.name = 'diting',
    this.avatar =
        "http://s4vhmosi8.hd-bkt.clouddn.com/FpSVKu6mlGLwBgnpmoNrT6lFACsK",
    this.telephone = '199',
    this.password = '123',
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
        userId: json['id'],
        name: json['name'],
        telephone: json['telephone'],
        avatar: json['avatar'],
        password: json['password']);
  }
}

class SharedDataNotifier extends ChangeNotifier {
  UserData userData = UserData();
  String ip = '';
  void updateIp(String ip) {
    this.ip = ip;
  }
  void updataAvatar(String avatar)
  {
    this.userData.avatar = avatar;
      notifyListeners(); // 通知订阅者进行重新构建
  }
}
