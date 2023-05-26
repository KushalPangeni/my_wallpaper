import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nature_wallpaper/constants/nature_constant.dart';
import 'package:nature_wallpaper/constants/quotes_constant.dart';
import 'package:nature_wallpaper/constants/snow.dart';
import 'package:nature_wallpaper/flowers/flower_const.dart';
import 'package:nature_wallpaper/random/constant.dart';
import 'package:nature_wallpaper/random/random.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wallpaper"),
        backgroundColor: Colors.deepPurple,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          navigator(
            "Random",
            context,
            const Wallpaper(
              listOfItems: wallpaperconst,
            ),
            "https://images.pexels.com/photos/1535162/pexels-photo-1535162.jpeg?auto=compress&cs=tinysrgb&w=1240&h=1920&dpr=1",
          ),
          navigator(
              "Flowers",
              context,
              const Wallpaper(
                listOfItems: flowerConst,
              ),
              "https://images.pexels.com/photos/1322185/pexels-photo-1322185.jpeg?auto=compress&cs=tinysrgb&w=1260&h=1920&dpr=1"),
          navigator(
            "Nature",
            context,
            const Wallpaper(
              listOfItems: natureConst,
            ),
            "https://images.pexels.com/photos/459203/pexels-photo-459203.jpeg?auto=compress&cs=tinysrgb&w=1260&h=1920&dpr=1",
          ),
          navigator(
            "Snow",
            context,
            const Wallpaper(
              listOfItems: snowConst,
            ),
            "https://images.pexels.com/photos/11039734/pexels-photo-11039734.jpeg?auto=compress&cs=tinysrgb&w=3275&h=4094&dpr=1",
          ),
          navigator(
            "Quotes",
            context,
            const Wallpaper(
              listOfItems: quoteConst,
            ),
            "https://images.pexels.com/photos/3078831/pexels-photo-3078831.jpeg",
          ),
        ],
      ),
    );
  }

  Widget navigator(
      String title, BuildContext context, var nav, String decorationImageUrl) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          log(title);
          Navigator.push(
              context, MaterialPageRoute(builder: ((context) => nav)));
        },
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.deepPurple,
                Colors.purple.shade300,
              ],
            ),
            // if(title=="Flowers")(
            //  image:  const DecorationImage(
            //         image: NetworkImage(
            //           "https://images.pexels.com/photos/1322185/pexels-photo-1322185.jpeg?auto=compress&cs=tinysrgb&w=1260&h=1920&dpr=1",
            //         ),
            //         fit: BoxFit.cover))
            image: DecorationImage(
                image: NetworkImage(decorationImageUrl), fit: BoxFit.cover)

            // image: title == "Flowers"
            //     ? const DecorationImage(
            //         image: NetworkImage(
            //           "https://images.pexels.com/photos/1322185/pexels-photo-1322185.jpeg?auto=compress&cs=tinysrgb&w=1260&h=1920&dpr=1",
            //         ),
            //         fit: BoxFit.cover)
            //     : const DecorationImage(
            //         image: NetworkImage(
            //           "https://images.pexels.com/photos/1141792/pexels-photo-1141792.jpeg?auto=compress&cs=tinysrgb&w=1240&h=1920&dpr=1",
            //         ),
            //         fit: BoxFit.cover),
            ,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
              child: Text(
            title,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
          )),
        ),
      ),
    );
  }
}
