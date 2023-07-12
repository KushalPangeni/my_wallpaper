// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

class DownloadWallpaper extends StatefulWidget {
  final String imagepath;
  const DownloadWallpaper({super.key, required this.imagepath});

  @override
  State<DownloadWallpaper> createState() => _DownloadWallpaperState();
}

class _DownloadWallpaperState extends State<DownloadWallpaper> {
  double progress = 0.0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                clipBehavior: Clip.values[0],
                decoration: BoxDecoration(color: Colors.teal[50], borderRadius: BorderRadius.circular(14)),
                height: MediaQuery.of(context).size.height * 0.75,
                width: MediaQuery.of(context).size.width,
                child: CachedNetworkImage(
                  imageUrl: widget.imagepath,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              //Set as wallpaper & download
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: Colors.deepPurple),
                        child: ElevatedButton(
                          onPressed: () async {
                            log("Set as wallpaper");
                            _showModalBottomSheet(context);
                          },
                          child: const Text(
                            "Set wallpaper",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: Colors.deepPurple),
                        child: ElevatedButton(
                          onPressed: () async {
                            log("Download");
                            String url = widget.imagepath;
                            final tempdir = await getTemporaryDirectory();
                            final path = "${tempdir.path}/myfile.jpg";
                            await Dio().download(
                              url,
                              path,
                              onReceiveProgress: ((recievedBytes, totalBytes) {
                                setState(() {
                                  progress = ((recievedBytes / totalBytes) * 100);
                                });
                              }),
                            );
                            await GallerySaver.saveImage(path, albumName: "Wallpaper");
                            await Future.delayed(const Duration(seconds: 1));
                          },
                          child: const Text(
                            "Download",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Text(progress.toInt() == 100 ? "Download Complete" : ""),
            ],
          ),
        ),
      ),
    );
  }

  Future<Widget> downloaded() async {
    return const AlertDialog(
      title: Text("Downloaded"),
    );
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200.0,
          color: Colors.transparent,
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.music_note),
                title: const Text('Both Screen'),
                onTap: () async {
                  // Perform action when music is pressed
                  int location = WallpaperManagerFlutter.HOME_SCREEN;
                  int location2 = WallpaperManagerFlutter.LOCK_SCREEN;
                  var file = await DefaultCacheManager().getSingleFile(widget.imagepath);
                  log(file.toString());
                  await WallpaperManagerFlutter().setwallpaperfromFile(file, location);
                  await WallpaperManagerFlutter().setwallpaperfromFile(file, location2);
                  await Future.delayed(const Duration(seconds: 1));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('Home Screen'),
                onTap: () async {
                  // Perform action when photos is pressed
                  int location = WallpaperManagerFlutter.HOME_SCREEN;
                  var file = await DefaultCacheManager().getSingleFile(widget.imagepath);
                  log(file.toString());
                  await WallpaperManagerFlutter().setwallpaperfromFile(file, location);
                  await Future.delayed(const Duration(seconds: 1));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.videocam),
                title: const Text('Lock Screen'),
                onTap: () async {
                  // Perform action when videos is pressed
                  int location = WallpaperManagerFlutter.LOCK_SCREEN;
                  var file = await DefaultCacheManager().getSingleFile(widget.imagepath);
                  log(file.toString());
                  await WallpaperManagerFlutter().setwallpaperfromFile(file, location);
                  await Future.delayed(const Duration(seconds: 1));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
