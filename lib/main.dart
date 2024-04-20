import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/rendering.dart';
import 'package:qverbo/Pages/bookings.dart';
import 'package:qverbo/Pages/explore.dart';
import 'services/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
  debugPaintSizeEnabled = false;
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 80,
                    width: 50,
                    child: Image.asset('assets/QvrBo.png')),
                Text(
                  'Qvrbo',
                  style: TextStyle(
                      fontSize: 28,
                      color: const Color.fromARGB(255, 4, 36, 141),
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            centerTitle: true,
          ),
        ),
        body: selectedIndex == 0 ? explore() : Bookings(),
        bottomNavigationBar: Expanded(
          child: BottomNavigationBar(
            currentIndex: selectedIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'Explore'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark_added_rounded), label: 'Saved'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark_added_rounded), label: 'Bookings'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark_added_rounded), label: 'Profile'),
            ],
            onTap: (value) {
              setState(() {
                selectedIndex = value;
              });
            },
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
          ),
        ),
      ),
    );
  }
}
