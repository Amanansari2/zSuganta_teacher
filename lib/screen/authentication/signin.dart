import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/providers/authentication/signin_provider.dart';
import 'package:z_tutor_suganta/utils/constants/app_colors.dart';
import 'package:z_tutor_suganta/utils/constants/sizes.dart';
import 'package:z_tutor_suganta/utils/theme/provider/theme_provider.dart';
import 'package:z_tutor_suganta/utils/theme/theme_switcher_button.dart';
import 'package:z_tutor_suganta/widgets/texts/custom_text_form_field.dart';
import 'package:z_tutor_suganta/widgets/custom_button.dart';

import '../../utils/constants/image_strings.dart';
import '../../utils/constants/text_strings.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

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
          builder: (context, provider, child) {
            return Scaffold(

              body: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(Sizes.defaultSpace),
                child: Form(
                  key: provider.formKey ,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        SizedBox(height: Sizes.imageThumbSize,),
                        Center(child: Image(image: AssetImage(AppImages.appLogo),height: Sizes.appLogoImageSize,)),

                        const SizedBox(height: Sizes.imageThumbSize,),

                        Text(AppText.welcomeBack,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),

                        const SizedBox(height: Sizes.spaceBtwItems,),

                        Text(AppText.signIntoYourAccount,
                          style: Theme.of(context).textTheme.headlineSmall,
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
                                return 'Email is required';
                              }
                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                return "Enter a valid email";
                              }
                              return null;
                            },
                        ),


                        const SizedBox(height: Sizes.defaultSpace,),

                        AppTextFiled(
                          controller: provider.passwordController,
                          label: AppText.password,
                          hint: AppText.passwordHint,
                          isRequired: true,
                          obscureText: true,
                          prefixIcon: Icon(FontAwesomeIcons.lock),
                          validator: (value){
                            if(value == null || value.trim().isEmpty){
                              return "Password is required";
                            }
                            if(value.length < 8){
                              return "Password must be at least 8 characters";
                            }

                            return null;
                          },
                        ),


                        const SizedBox(height: Sizes.xs),

                        Align(
                          alignment: Alignment.topRight,
                          child: TextButton(
                              onPressed: (){
                                context.pushNamed('forgotPassword');
                              },
                              child: Text(
                                AppText.forgotPassword,
                              style: TextStyle(
                                color: dark? AppColors.blue : AppColors.orange,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                                fontSize: Sizes.fontSizeLg
                              ),
                              )),
                        ),




                        const SizedBox(height: Sizes.defaultSpace,),


                        Center(
                          child: CustomButton(
                            text: AppText.signIn,
                            onPressed: (){
                              provider.signIn(context);
                            },
                            color: dark ? AppColors.blue : AppColors.orange,
                            textColor: AppColors.white,
                            radius: 15,
                            fontSize: Sizes.lg,
                            width: 300,
                          ),
                        ),





                        const SizedBox(height: Sizes.iconMd),
                        const SizedBox(height: Sizes.defaultSpace,),

                        Center(
                          child: RichText(
                              text: TextSpan(
                                text: AppText.dontHaveAnAccount,
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: dark
                                      ?  AppColors.white
                                      : AppColors.black
                                ),

                                children: [
                                  TextSpan(
                                    text: AppText.signInhere,
                                    style: TextStyle(
                                      color: dark ? AppColors.blue : AppColors.orange,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = (){
                                      context.pushNamed('signUp');
                                      }
                                  )
                                ]
                              ),

                          ),
                        ),






                      ],
                    )),
                ),
              ) ,
            );
          }
        )

    );
  }
}
