import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:diting/utils/global.dart';

class GlobalsetPage extends StatefulWidget {
  const GlobalsetPage({super.key});

  @override
  State<GlobalsetPage> createState() => _GlobalsetPageState();
}

class _GlobalsetPageState extends State<GlobalsetPage> {
  @override
  Widget build(BuildContext context) {
    var sharedDataNotifier = Provider.of<SharedDataNotifier>(context);
    return Scaffold(
        appBar: AppBar(),
        resizeToAvoidBottomInset: false,
        body: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.network_wifi_3_bar),
              title: const Text('Setting Server IP'),
              onTap: () {
                var controller = TextEditingController(text: '');
                showAboutDialog(
                  applicationName: "Server IP",
                  context: context,
                  children: [
                    TextField(controller: controller),
                    ElevatedButton(
                        onPressed: () {
                          sharedDataNotifier.ip = controller.text;
                          CherryToast.success(title: Text('Successfully set server IP to:${sharedDataNotifier.ip}')).show(context);
                        },
                        child: const Text('确定')),
                  ],
                );
              },
            ),
          ],
        ));
  }
}
