import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

class NetImage extends StatefulWidget {
  const NetImage({super.key});

  @override
  State<NetImage> createState() => _NetImageState();
}

class _NetImageState extends State<NetImage> {
  String imageUrl =
      "https://images.pexels.com/photos/1212487/pexels-photo-1212487.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Image.network(imageUrl),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: InkWell(
                onTap: () async {
                  log("Download");
                  String url = imageUrl;
                  final tempdir = await getTemporaryDirectory();
                  final path = "${tempdir.path}/myfile.jpg";
                  await Dio().download(url, path);
                  await GallerySaver.saveImage(path, toDcim: true);
                },
                child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.deepPurple),
                    child: const Center(
                      child: Text(
                        "Download",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
