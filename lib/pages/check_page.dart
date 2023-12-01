import 'package:flutter/material.dart';

class CheckPage extends StatefulWidget {
  const CheckPage({super.key});

  @override
  CheckPageState createState() => CheckPageState();
}

class CheckPageState extends State<CheckPage> {
  var controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('谛听', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'input the url you want to check',
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                  ),
                  IconButton(
                    splashRadius: 16,
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      // TODO: refresh the page output the result
                    },
                  ),
                ],
              ),
            ),
          ),
          const Text(
            '片言 ———— 可以折狱',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
