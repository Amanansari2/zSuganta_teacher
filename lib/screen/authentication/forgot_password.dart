import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/providers/authentication/forgot_password_provider.dart';
import 'package:z_tutor_suganta/utils/constants/app_colors.dart';
import 'package:z_tutor_suganta/utils/constants/sizes.dart';
import 'package:z_tutor_suganta/widgets/texts/custom_text_form_field.dart';
import 'package:z_tutor_suganta/widgets/custom_button.dart';

import '../../utils/constants/image_strings.dart';
import '../../utils/constants/text_strings.dart';
import '../../utils/theme/provider/theme_provider.dart';
import '../../utils/theme/theme_switcher_button.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = context.watch<ThemeProvider>().isDarkMode;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness:  dark? Brightness.light : Brightness.dark,
      statusBarIconBrightness: dark ? Brightness.light : Brightness.dark,
    ));

    return ChangeNotifierProvider(
        create: (_) => ForgotPasswordProvider(),
      child: Consumer<ForgotPasswordProvider>(
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
                           child: Text(AppText.forgotPassword,
                             style: Theme.of(context).textTheme.headlineLarge,
                           ),
                         ),

                         const SizedBox(height: Sizes.spaceBtwItems,),

                         Center(
                           child: Text(AppText.forgotPasswordTitle,
                             style: Theme.of(context).textTheme.bodyLarge,
                           ),
                         ),

                         const SizedBox(height: Sizes.spaceBtwSections,),

                         AppTextFiled(
                             controller: provider.emailController,
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
                               text: AppText.sendResetLink,
                               onPressed: (){
                                 provider.forgotPassword(context);
                               },
                           color:  dark ? AppColors.blue : AppColors.orange,
                             textColor: AppColors.white,
                             radius: 15,
                             fontSize: Sizes.lg,
                             width: 300,
                           ),
                         ),

                         const SizedBox(height: Sizes.iconMd,),
                         const SizedBox(height: Sizes.defaultSpace,),


                         Center(
                           child: RichText(
                               text: TextSpan(
                                 text: AppText.rememberYourPassword,
                                 style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                   color: dark
                                       ? AppColors.white
                                       : AppColors.black
                                 ),
                                 children: [
                                   TextSpan(
                                     text: AppText.signInhere,
                                     style: TextStyle(
                                       color: dark? AppColors.blue : AppColors.orange,
                                       decoration: TextDecoration.underline,
                                       fontWeight: FontWeight.bold
                                     ),
                                     recognizer: TapGestureRecognizer()
                                       ..onTap =(){
                                       context.pushNamed('signIn');
                                       }
                                   )
                                 ]
                               )
                           ),
                         )

                       ],
                     )
                 ),
                ),
              ),
            );
          }),

    );
  }
}
