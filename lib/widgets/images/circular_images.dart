import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../configs/url.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/theme/provider/theme_provider.dart';

class CircularImages extends StatelessWidget {
  final BoxFit? fit;
  final String? image;
  final String fallbackAsset;
  final Color? overlayColor;
  final double width, height, padding;
  const CircularImages({
    super.key,
    this.fit = BoxFit.cover,
    required this.fallbackAsset,
    required this.image,
    this.overlayColor,
    this.width = 56,
    this.height  = 56,
    this.padding = Sizes.sm,
  });

  ImageProvider _getImageProvider(String? img) {
    if (img == null || img.isEmpty) {
      // fallback asset
      return AssetImage(fallbackAsset);
    }

    // if it's a local file picked by user
    final file = File(img);
    if (file.existsSync()) return FileImage(file);

    // assume backend only gives filename, prepend full media URL
    return NetworkImage("${ApiUrls.mediaUrl}$img");
  }

  @override
  Widget build(BuildContext context) {
    final dark = context.watch<ThemeProvider>().isDarkMode;


    // ImageProvider provider;
    // if (image == null || image!.isEmpty) {
    //   // fallback
    //   provider = AssetImage(fallbackAsset);
    // } else if (image!.startsWith('http')) {
    //   // network image
    //   provider = NetworkImage(image!);
    // } else if (File(image!).existsSync()) {
    //   // local picked file
    //   provider = FileImage(File(image!));
    // } else {
    //   // if path invalid, fallback
    //   provider = AssetImage(fallbackAsset);
    // }

    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: dark ? AppColors.blue : AppColors.orange,
        borderRadius: BorderRadius.circular(100),
      ),
         child: CircleAvatar(
           radius: width / 2,
           backgroundImage: _getImageProvider(image),
         ),

    );
  }
}
