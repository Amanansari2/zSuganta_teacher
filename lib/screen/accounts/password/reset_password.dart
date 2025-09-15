import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/providers/accounts/reset_password_provider.dart';
import 'package:z_tutor_suganta/utils/theme/provider/theme_provider.dart';
import 'package:z_tutor_suganta/widgets/containers/primary_header_container.dart';

import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/texts/custom_text_form_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = context.watch<ThemeProvider>().isDarkMode;
    return ChangeNotifierProvider(
        create: (_) => ResetPasswordProvider(),
      child: Consumer<ResetPasswordProvider>(
          builder: (context, provider, child){
            return Scaffold(
              body: Column(
                children: [
                  PrimaryHeaderContainer(
                      child:  Column(
                        children: [
                          MyAppBar(
                            showBackArrow: true,
                            title: Text(
                              AppText.updateSocial,
                              style: Theme.of(context).textTheme.headlineMedium!
                                  .apply(color: AppColors.white),
                            ),
                          ),

                          SizedBox(
                            width: double.infinity,
                            child: Icon(
                              FontAwesomeIcons.shieldHalved,
                              color: AppColors.white,
                              size: 110,
                            ),
                          ),
                          SizedBox(height: Sizes.spaceBtwSections),
                        ],
                      ),
                  ),

                  Expanded(
                      child: SingleChildScrollView(
                       child: Padding(
                           padding: const EdgeInsets.all(Sizes.defaultSpace),
                            child: Form(
                                key: provider.formKey,
                                child: Column(
                                  children: [

                                    AppTextFiled(
                                      controller: provider.oldPasswordController,
                                      label: AppText.oldPassword,
                                      hint: AppText.oldPasswordHint,
                                      isRequired: true,
                                      obscureText: true,
                                      prefixIcon: Icon(FontAwesomeIcons.lock),
                                      validator: (value){
                                        if(value == null || value.trim().isEmpty){
                                          return "Old password is required";
                                        }
                                        if(value.length < 8){
                                          return "Old password must be at least 8 characters";
                                        }
                                        return null;
                                      },
                                    ),


                                    const SizedBox(height: Sizes.defaultSpace),


                                    AppTextFiled(
                                      controller: provider.newPasswordController,
                                      label: AppText.newPassword,
                                      hint: AppText.passwordHint,
                                      isRequired: true,
                                      obscureText: true,
                                      prefixIcon: Icon(FontAwesomeIcons.lock),
                                      validator: (value){
                                        if(value == null || value.trim().isEmpty){
                                          return "New password is required";
                                        }
                                        if(value.length < 8){
                                          return "New password must be at least 8 characters";
                                        }
                                        if (!RegExp(r'[0-9]').hasMatch(value)) {
                                          return "New password must contain at least one number";
                                        }
                                        if (!RegExp(r'[!@#\$&*~%^_+=\-]').hasMatch(value)) {
                                          return "New password must contain at least one special character";
                                        }
                                        if (!RegExp(r'[A-Z]').hasMatch(value)) {
                                          return "New password must contain at least one uppercase letter";
                                        }
                                        return null;
                                      },
                                    ),

                                    const SizedBox(height: Sizes.defaultSpace,),

                                    AppTextFiled(
                                      controller: provider.confirmPasswordController,
                                      label: AppText.confirmPassword,
                                      hint: AppText.enterConfirmPassword,
                                      isRequired: true,
                                      obscureText: true,
                                      prefixIcon: Icon(FontAwesomeIcons.lock),
                                      validator: (value) {
                                        if(value == null || value.trim().isEmpty){
                                          return "Confirm password is required";
                                        }
                                        if(value != provider.newPasswordController.text){
                                          return "New password and confirm password do not match";
                                        }
                                        return null;
                                      },
                                    ),

                                    const SizedBox(height: Sizes.defaultSpace),

                                    Center(
                                      child: CustomButton(
                                        text: AppText.resetPassword,
                                        onPressed:   () {
                                          if(!provider.isLoading) {
                                            provider.resetPassword(context);
                                          }

                                        },
                                        color: dark ? AppColors.blue : AppColors.orange,
                                        textColor: AppColors.white,
                                        radius: 15,
                                        fontSize: Sizes.lg,
                                        width: 300,
                                      ),
                                    ),

                                  ],
                                )),
                       ),

                      ))
                ],
              ),
            );
          }),
    );
  }
}
