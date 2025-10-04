import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:z_tutor_suganta/providers/authentication/signup_provider.dart';
import 'package:z_tutor_suganta/utils/constants/app_colors.dart';
import 'package:z_tutor_suganta/utils/constants/image_strings.dart';
import 'package:z_tutor_suganta/utils/constants/sizes.dart';
import 'package:z_tutor_suganta/utils/constants/text_strings.dart';
import 'package:z_tutor_suganta/widgets/texts/custom_text_form_field.dart';
import 'package:z_tutor_suganta/widgets/custom_button.dart';

import '../../utils/theme/provider/theme_provider.dart';
import '../../widgets/custom_dropdown.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // final dark = HelperFunction.isDarkMode(context);
    final dark = context.watch<ThemeProvider>().isDarkMode;

    return ChangeNotifierProvider(
        create: (_) => SignUpProvider(),
    child:  Consumer<SignUpProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(Sizes.defaultSpace),
              child: Form(
                key: provider.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     SizedBox(height: 30,),


                    Center(child: Image(image: AssetImage(AppImages.appLogo),height: Sizes.appLogoImageSize,)),
                    const SizedBox(height: Sizes.defaultSpace,),


                    Center(
                      child: Text(AppText.getStartedNow,
                      style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),

                    const SizedBox(height: Sizes.spaceBtwItems,),

                    Center(
                      child: Text(AppText.createYourAccount,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),

                    const SizedBox(height: Sizes.spaceBtwSections,),

                    AppTextFiled(
                      controller: provider.firstNameController,
                        label: AppText.firstName,
                        hint: AppText.enterFirstName,
                        isRequired: true,
                      prefixIcon:  Icon(FontAwesomeIcons.user),
                      validator:(value){
                          if(value == null || value.trim().isEmpty){
                            return "First name is required";
                          }
                          return null;
                      } ,
                    ),

                    const SizedBox(height: Sizes.defaultSpace,),


                    AppTextFiled(
                      controller: provider.lastNameController,
                        label: AppText.lastName,
                        hint: AppText.enterLastName,
                        isRequired: true,
                      prefixIcon:  Icon(FontAwesomeIcons.user),
                        validator: (value){
                          if(value == null || value.trim().isEmpty){
                            return "Last name is required";
                          }
                          return null;
                        },
                    ),

                    const SizedBox(height: Sizes.defaultSpace,),


                    AppTextFiled(
                      controller: provider.emailController,
                      keyboardType: TextInputType.emailAddress,
                      label: AppText.emailAddress,
                      hint: AppText.enterEmail,
                      isRequired: true,
                      prefixIcon:  Icon(FontAwesomeIcons.envelope),
                      validator: (value){
                        if(value == null || value.trim().isEmpty){
                          return "Email is required";
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return "Enter a valid email";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: Sizes.defaultSpace,),


                    AppTextFiled(
                      controller: provider.phoneController,
                      keyboardType: TextInputType.phone,
                      label: AppText.phoneNumber,
                      hint: AppText.enterPhone,
                      isRequired: true,
                      prefixIcon: Icon(FontAwesomeIcons.phone),
                      // countryCode: provider.countryCode,
                      // flagEmoji: provider.flagEmoji,
                      validator: (value){
                        if(value == null || value.trim().isEmpty){
                          return "Phone number is required";
                        }
                        return null;
                      },
                      // onCountryChanged: (country){
                      //   provider.updateCountry(country);
                      // },
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
                          if (!RegExp(r'[0-9]').hasMatch(value)) {
                            return "Password must contain at least one number";
                          }
                          if (!RegExp(r'[!@#\$&*~%^_+=\-]').hasMatch(value)) {
                            return "Password must contain at least one special character";
                          }
                          if (!RegExp(r'[A-Z]').hasMatch(value)) {
                            return "Password must contain at least one uppercase letter";
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
                        if(value != provider.passwordController.text){
                          return "Passwords do not match";
                        }
                        return null;
                      },
                    ),


                    const SizedBox(height: Sizes.defaultSpace,),

                    CustomDropdown<String>(
                      items: provider.roles.keys.toList(),
                      selected: provider.selectedRoleKey,
                      onChanged: (value) => provider.updateRole(value),
                      itemLabel: (key) => provider.roles[key] ?? key,
                      validator: (key) => key == null || key.isEmpty ? 'Please select a role' : null,
                      hint: "Select Role",
                      dropdownColor:  dark ? AppColors.darkGrey : AppColors.lightGrey,
                      hintColor: dark ? AppColors.white : AppColors.black,
                      textColor:dark ? AppColors.white : AppColors.black,
                    ),


                    const SizedBox(height: Sizes.defaultSpace),


                    //---------------------------------

                    FormField<bool>(
                      initialValue: provider.agreeToTerms,
                      validator: (value) {
                        if (value != true) {
                          return 'You must agree to the terms and privacy policy';
                        }
                        return null;
                      },
                      builder: (state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: provider.agreeToTerms,
                                  onChanged: (value) {
                                    provider.toggleAgreeToTerms(value ?? false);
                                    state.didChange(value);
                                  },
                                  activeColor: dark ? AppColors.blue : AppColors.orange,
                                ),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      text: AppText.iAgreeTo,
                                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        color: dark ? AppColors.white : AppColors.black,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: AppText.termsOfUse,
                                          style: TextStyle(
                                            color: dark ? AppColors.blue : AppColors.orange,
                                            decoration: TextDecoration.underline,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () async {
                                              final uri = Uri.parse("https://www.suganta.com/terms-and-conditions");
                                              if (await canLaunchUrl(uri)) {
                                                await launchUrl(uri, mode: LaunchMode.externalApplication);
                                              }
                                            },
                                        ),
                                        TextSpan(text: AppText.and),
                                        TextSpan(
                                          text: AppText.privacyPolicy,
                                          style: TextStyle(
                                            color: dark ? AppColors.blue : AppColors.orange,
                                            decoration: TextDecoration.underline,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () async {
                                              final uri = Uri.parse("https://www.suganta.com/privacy-and-policies");
                                              if (await canLaunchUrl(uri)) {
                                                await launchUrl(uri, mode: LaunchMode.externalApplication);
                                              }
                                            },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (state.hasError)
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Text(
                                  state.errorText!,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),


                    //---------------------------------

                    const SizedBox(height: Sizes.defaultSpace),


                    Center(
                      child: CustomButton(
                        text: AppText.signUp,
                        onPressed:   () {
                          if(!provider.isLoading) {
                            provider.signup(context);
                          }

                        },
                        color: dark ? AppColors.blue : AppColors.orange,
                        textColor: AppColors.white,
                        radius: 15,
                        fontSize: Sizes.lg,
                        width: 300,
                      ),
                    ),


                    const SizedBox(height: Sizes.iconMd),


                    const SizedBox(height: Sizes.defaultSpace),


                    Center(
                      child: RichText(
                          text: TextSpan(
                              text: AppText.alreadyHaveAnAccount,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: dark
                                    ? AppColors.white
                                    : AppColors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: AppText.signIn,
                                  style: TextStyle(
                                    color:dark ? AppColors.blue : AppColors.orange,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = ()  {
                                    context.pushNamed('signIn');
                                    },
                                )
                              ]
                          )
                      ),
                    ),

                    const SizedBox(height: Sizes.spaceBtwSections),


                  ],
                ),
              ),
            ),
          ),

        );
      }
    )
    );
  }
}
