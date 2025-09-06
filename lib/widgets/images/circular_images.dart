import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/constants/app_colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/theme/provider/theme_provider.dart';

class CircularImages extends StatelessWidget {
  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final double width, height, padding;
  const CircularImages({
    super.key,
    this.fit = BoxFit.cover,
    required this.image,
    this.isNetworkImage = false,
    this.overlayColor,
    this.width = 56,
    this.height  = 56,
    this.padding = Sizes.sm,
  });

  @override
  Widget build(BuildContext context) {
    final dark = context.watch<ThemeProvider>().isDarkMode;
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
           child: Image(
            fit: fit,
            image: isNetworkImage ? NetworkImage(image) : AssetImage(image) as ImageProvider,
            color: overlayColor,
           ),
         ),

    );
  }
}
