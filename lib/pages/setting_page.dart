import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:diting/utils/global.dart';
import 'dart:convert';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  File? _image;
  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }
  
  
  @override
  Widget build(BuildContext context) {
    var sharedDataNotifier = Provider.of<SharedDataNotifier>(context);

    void uploadArticle(
      SharedDataNotifier sharedDataNotifier,
      File image,
    ) async {
      var url = Uri.parse(
          'http://${sharedDataNotifier.ip}:8081/DiTing/user/avatar'); // 替换为你的服务器端上传接口地址
      try {
        //
        // var sharedDataNotifier = Provider.of<SharedDataNotifier>(context);
        var request = http.MultipartRequest('POST', url);
        // request.headers['Content-Type'] = 'application/x-www-form-urlencoded';
        var multipartFile =
            await http.MultipartFile.fromPath('avatar', image.path);
        request.files.add(multipartFile);
        request.fields['telephone'] = sharedDataNotifier.userData.telephone;
        var response = await request.send();

        if (response.statusCode == 200) {
          // 头像上传成功
          CherryToast.success(
            title: const Text("上传成功"),
          ).show(context);
          var streamedResponse = await http.Response.fromStream(response);
          var responseBody = streamedResponse.body;
          var json = jsonDecode(responseBody);
          sharedDataNotifier.updataAvatar(json['data']);
        print("++++++++++++++++++++++++++++++++++++++++++++++++++");
        print(json['data']);
          // print('avatar uploaded successfully');
        } else {
          // 文章上传失败
          CherryToast.error(
            title: const Text("上传失败"),
          ).show(context);
        }
      } catch (e) {
        print(e);
        CherryToast.warning(title: const Text("网络错误")).show(context);
      }
    }

    return Scaffold(
        appBar: AppBar(),
        body: ListView(padding: const EdgeInsets.all(10), children: [
          const Text(
            "更改头像",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: () {
              getImage();
            },
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: _image != null
                  ? Image.file(
                      _image!,
                      fit: BoxFit.fitHeight,
                    )
                  : Icon(
                      Icons.camera_alt,
                      size: 48.0,
                      color: Colors.grey[400],
                    ),
            ),
          ),
          const SizedBox(height: 5),
          ElevatedButton(
            onPressed: () {
              // 在这里处理上传 头像
              File image = _image!;
              // // 上传头像并处理结果

              uploadArticle(sharedDataNotifier, image);
              // CherryToast.info(title: Text("niha"),).show(context);
            },
            child: const Text('确定'),
          ),
        ]));
  }
}
