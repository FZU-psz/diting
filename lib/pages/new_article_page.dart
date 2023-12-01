import 'dart:io';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:diting/utils/global.dart';

class NewArticlePage extends StatefulWidget {
  const NewArticlePage({super.key});

  @override
  State<StatefulWidget> createState() => NewArticlePageState();
}

class NewArticlePageState extends State<NewArticlePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
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

  void uploadArticle(String ip, String title, String content, File image,
      UserData userdata) async {
    var url = Uri.parse(
        'http://${ip}:8081/DiTing/essay/post'); // 替换为你的服务器端上传接口地址

    try {
      //如果
      var request = http.MultipartRequest('POST', url);
      request.fields['name'] = userdata.name;
      request.fields['avatar'] = userdata.avatar;
      request.fields['essayName'] = title;
      request.fields['essayContent'] = content;
      request.files
          .add(await http.MultipartFile.fromPath('essayAvatar', image.path));
      var response = await request.send().timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        
        // ignore: use_build_context_synchronously
        CherryToast.success(
          title: const Text("上传成功"),
        ).show(context);
        // print('Article uploaded successfully');

      } else {
        // ignore: use_build_context_synchronously
        CherryToast.error(
          title: const Text("上传失败"),
        ).show(context);
        // print('Error uploading article');
      }
    } catch (e) {
      // print(e);
      // ignore: use_build_context_synchronously
      CherryToast.warning(title: const Text("网络错误")).show(context);


    }
  }

  @override
  Widget build(BuildContext context) {
    var sharedDataNotifier = Provider.of<SharedDataNotifier>(context);
    var ip = sharedDataNotifier.ip;
    return Material(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('分享是一种美德'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                        hintText: "   文章标题",
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 2.0,
                          ),
                        )),
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    decoration: const InputDecoration(
                        hintText: "   文章内容",
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 2.0,
                          ),
                        )),
                    controller: _contentController,
                    maxLines: 10,
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      getImage();
                    },
                    child: Container(
                      width: 200.0,
                      height: 250,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15),
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
                    onPressed: () async {
                      // 在这里处理上传文章逻辑
                      String title = _titleController.text;
                      String content = _contentController.text;
                      File image = _image!;
                      // // 上传文章并处理结果
                      uploadArticle(ip, title, content, image, sharedDataNotifier.userData);
                      // CherryToast.info(title: Text("niha"),).show(context);
                    },
                    child: const Text('上传文章'),
                  ),
                ],
              ))),
    );
  }
}
