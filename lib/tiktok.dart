import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nature_wallpaper/constants/const_for_tiktok.dart';
import 'package:url_launcher/url_launcher.dart';

class Tiktok extends StatelessWidget {
  const Tiktok({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          children: [
            const Icon(
              Icons.tiktok,
              size: 75,
            ),
            const Text(
              "Tiktok",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              """Tap to copy some trending texts
   and paste them in search box""",
              maxLines: 3,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton.icon(
                icon: const Icon(Icons.fireplace),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.purple, elevation: 10),
                onPressed: () {
                  Clipboard.setData(const ClipboardData(text: copy1));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("$copy1 copied"),
                    duration: Duration(milliseconds: 500),
                  ));
                },
                label: const Text(copy1)),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.purple, elevation: 10),
                onPressed: () {
                  Clipboard.setData(const ClipboardData(text: copy2));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("$copy2 copied"),
                    duration: Duration(milliseconds: 500),
                  ));
                },
                child: const Text(copy2)),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.purple, elevation: 10),
                onPressed: () {
                  Clipboard.setData(const ClipboardData(text: copy3));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("$copy3 copied"),
                    duration: Duration(milliseconds: 500),
                  ));
                },
                child: const Text(copy3)),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.purple, elevation: 10),
                onPressed: () {
                  Clipboard.setData(const ClipboardData(text: copy4));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("$copy4 copied"),
                    duration: Duration(milliseconds: 500),
                  ));
                },
                child: const Text(copy4)),
            const Spacer(),
            Card(
              elevation: 5,
              color: Colors.deepPurple,
              child: ListTile(
                leading: const Icon(
                  Icons.tiktok,
                  color: Colors.white,
                ),
                title: const Text(
                  "Open tiktok to set Wallpaper",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(
                  Icons.keyboard_arrow_right_outlined,
                  color: Colors.white,
                ),
                onTap: () async {
                  const searchTerm = 'Live wallpaper';
                  String tiktokUrl = 'tiktok://search?/tag/?name=$searchTerm';
                  final Uri uri = Uri.parse(tiktokUrl);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(
                      uri,
                    );
                  } else {
                    throw {log('cannot launch')};
                  }
                },
              ),
            ),
            Card(
              elevation: 5,
              child: ListTile(
                onTap: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Wrap(
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Set live wallpaper",
                                    style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                                child: Text(
                                  'Step 1: Tap share on TikTok video',
                                  style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Image.asset(
                                'assets/wall.jpg',
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'Step 2: Tap  ',
                                      maxLines: 2,
                                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
                                    ),
                                    Icon(Icons.play_circle_outline_rounded),
                                    Expanded(
                                      child: Text(
                                        ' to set video as live wallpaper',
                                        maxLines: 2,
                                        style:
                                            TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Image.asset('assets/wall2.jpg'),
                            ],
                          ),
                        );
                      });
                },
                leading: const Icon(
                  Icons.wallpaper_rounded,
                  color: Colors.black,
                ),
                title: const Text(
                  "Find out how to set wallpaper",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                trailing: const Icon(
                  Icons.keyboard_arrow_up_outlined,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
