import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/providers/authentication/signin_provider.dart';
import 'package:z_tutor_suganta/widgets/texts/custom_text_form_field.dart';

import '../../utils/constants/app_colors.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/constants/text_strings.dart';
import '../../utils/theme/provider/theme_provider.dart';
import '../../utils/theme/theme_switcher_button.dart';
import '../../widgets/custom_button.dart';

class ResendEmailScreen extends StatelessWidget {
  const ResendEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = context.watch<ThemeProvider>().isDarkMode;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness:  dark? Brightness.light : Brightness.dark,
      statusBarIconBrightness: dark ? Brightness.light : Brightness.dark,
    ));

    return ChangeNotifierProvider(
        create: (_) => SignInProvider(),
       child: Consumer<SignInProvider>(
           builder: (context, provider, child){
             return Scaffold(

               body: SingleChildScrollView(
                 child: Padding(
                     padding: const EdgeInsets.all(Sizes.defaultSpace),
                   child: Form(
                     key: provider.formKey,
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [

                           SizedBox(height: Sizes.productImageHeight,),
                           Center(child: Image(image: AssetImage(AppImages.appLogo),height: Sizes.appLogoImageSize,)),

                           const SizedBox(height: Sizes.imageThumbSize,),

                           Center(
                             child: Text(AppText.emailNotVerified,
                               style: Theme.of(context).textTheme.titleLarge,
                             ),
                           ),

                           SizedBox(height: Sizes.spaceBtwItems,),

                           Center(
                             child: Text(AppText.verifyEmailLogin,
                               style: Theme.of(context).textTheme.titleLarge,
                             ),
                           ),

                           SizedBox(height: Sizes.spaceBtwSections,),

                           AppTextFiled(
                             controller: provider.resendEmailController,
                             keyboardType: TextInputType.emailAddress,
                             label: AppText.emailAddress,
                             hint: AppText.enterEmail,
                             isRequired: true,
                             prefixIcon: Icon(FontAwesomeIcons.envelope),
                             validator: (value){
                               if(value == null || value.trim().isEmpty){
                                 return'Email is required';
                               }
                               if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)){
                                 return 'Enter a valid email';
                               }
                               return null;
                             },
                           ),

                           const SizedBox(height:  Sizes.spaceBtwSections,),


                           Center(
                             child: CustomButton(
                               text: AppText.resendVerificationLink,
                               onPressed: (){
                                 provider.verifyEmail(context);
                               },
                               color:  dark ? AppColors.blue : AppColors.orange,
                               textColor: AppColors.white,
                               radius: 15,
                               fontSize: Sizes.lg,
                               width: 300,
                             ),
                           ),


                         ],
                       )),
                 ),
               ),
             );
           }),
    );
  }
}
