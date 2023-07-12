import 'package:flutter/material.dart';
import 'package:nature_wallpaper/homepage.dart';
import 'package:nature_wallpaper/tiktok.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List screens = [const Tiktok(), const Homepage()];
  int screenNo = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Wallpaper",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: screens[screenNo],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: screenNo,
          selectedItemColor: Colors.black,
          onTap: (value) {
            setState(() {
              screenNo = value;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.tiktok), label: "Tiktok"),
            BottomNavigationBarItem(icon: Icon(Icons.now_wallpaper_rounded), label: "Inclusive"),
          ]),
    );
  }
}
