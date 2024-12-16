import 'package:flutter/material.dart';

class ImageUtils {
  static getImageFromAssets(String name) {
    return Image.asset("assets/png/$name.png", fit: BoxFit.cover, height: 300, alignment: Alignment.center);
  }
}
