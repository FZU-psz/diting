// import 'dart:js';


// import 'dart:js';

import 'package:diting/pages/forum_page.dart';
import 'package:diting/pages/new_article_page.dart';
import 'package:diting/pages/person_page.dart';
import 'package:diting/pages/spalsh_page.dart';
import 'package:diting/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:diting/pages/search_page.dart';
import 'package:diting/pages/login.dart';
import 'package:provider/provider.dart';



void main() async{
  //debugPaintSizeEnabled = true;
  runApp(
    ChangeNotifierProvider(
      create: (_) => SharedDataNotifier(),
      child: MaterialApp(
      title: 'Diting',
      home: const  MainPage(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue.shade400),
      ),
      initialRoute: './splash',
      routes: {
        './splash':(context) => const SplashPage(),
        './login': (context) =>  const login(),
        './ManPage':(context) =>  const MainPage(),
        '/new_article': (context) => const NewArticlePage(),
      },
    ),
    )
  );
}

class MainPage extends StatefulWidget {
  const MainPage({super.key,});

  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  
  var controller = PageController(initialPage: 0);
  List<Widget> pages = [
    SearchPage(),
    ForumPage(),
    const PersonPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      resizeToAvoidBottomInset: false,
      // drawer: const SideBar(),
      floatingActionButton: _currentIndex == 0
          ? null
          : FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/new_article');
              },
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: const Icon(Icons.add),
            ),
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 28,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search_off_outlined),
            label: '明辨',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum_outlined),
            label: '看看',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: '个人',
          ),
        ],
      ),
    );
  }
}

// class SideBar extends StatelessWidget {
//   const SideBar({
//     super.key,
//   });

//   Widget _buildDrawerHeader() {
//     var unloginHead = const DrawerHeader(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text('谛听', style: TextStyle(fontSize: 32)),
//           Text('登陆', style: TextStyle(fontSize: 24)),
//         ],
//       ),
//     );

//     if (Global.user == null) {
//       return unloginHead;
//     }

//     var loginedHead = UserAccountsDrawerHeader(
//         accountName: Text(Global.user!.uname), accountEmail: Text(Global.user!.email));

//     return loginedHead;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         children: [
//           _buildDrawerHeader(),
//           ListTile(title: const Text('Settings'), onTap: () {}),
//         ],
//       ),
//     );
//   }
// }
