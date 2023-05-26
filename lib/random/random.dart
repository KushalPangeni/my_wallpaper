import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nature_wallpaper/download_wallpaper.dart';

class Wallpaper extends StatelessWidget {
  final List listOfItems;
  const Wallpaper({super.key, required this.listOfItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wallpaper"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: listOfItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 5,
              childAspectRatio: 0.7),
          itemBuilder: ((context, index) {
            log(listOfItems.length.toString());
            return wallpaper(listOfItems[index], context);
          }),
        ),
      ),
    );
  }

  Widget wallpaper(String imagepath, BuildContext context) {
    return InkWell(
      onTap: () {
        log("Done");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => DownloadWallpaper(imagepath: imagepath)),
          ),
        );
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            color: Colors.teal[50], borderRadius: BorderRadius.circular(4)),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: imagepath,
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
              child:
                  CircularProgressIndicator(value: downloadProgress.progress)),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
