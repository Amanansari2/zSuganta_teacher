import 'package:flutter/material.dart';
import 'package:z_tutor_suganta/utils/constants/sizes.dart';
import 'package:z_tutor_suganta/utils/helpers/helper_function.dart';

class OnboardingPage extends StatelessWidget {
  
  final String image, title, subtitle;
  
  const OnboardingPage({super.key, required this.image, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(Sizes.defaultSpace),
     child: Column(
       children: [
         Image(
           width: HelperFunction.screenWidth(context) * 0.8,
             height: HelperFunction.screenHeight(context) * 0.6,
             image: AssetImage(image)),
         
         Text(title,
          style: Theme.of(context).textTheme.headlineMedium,
           textAlign: TextAlign.center,
         ),

         const SizedBox(height: Sizes.spaceBtwItems,),

         Text(subtitle,
          style: Theme.of(context).textTheme.bodyMedium,
           textAlign: TextAlign.center,
         )
       ],
     ),
    );
  }
}
