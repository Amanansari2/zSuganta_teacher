import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/providers/accounts/email_mobile_provider.dart';
import 'package:z_tutor_suganta/utils/services/local_storage_service.dart';
import 'package:z_tutor_suganta/utils/theme/provider/theme_provider.dart';
import 'package:z_tutor_suganta/widgets/containers/primary_header_container.dart';

import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/texts/custom_text_form_field.dart';

class EmailMobileScreen extends StatelessWidget {
  const EmailMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = context.watch<ThemeProvider>().isDarkMode;
    return ChangeNotifierProvider(
        create: (_) {
          final provider = EmailMobileProvider();
          final currentUser = LocalStorageService.getUser();
          if(currentUser != null){
            provider.emailController.text = currentUser.email;
            provider.phoneController.text = currentUser.phone;
          }
          return provider;
        },
        child:  Consumer<EmailMobileProvider>(
            builder: (context, provider, child){
              return Scaffold(
                body: Column(
                  children: [
                    PrimaryHeaderContainer(
                        child: Column(
                          children: [
                            MyAppBar(
                              showBackArrow: true,
                              title: Text(
                                AppText.updateContact,
                                style: Theme.of(context).textTheme.headlineMedium!
                                    .apply(color: AppColors.white),
                              ),
                            ),

                            SizedBox(
                              width: double.infinity,
                              child: Icon(
                                FontAwesomeIcons.addressCard,
                                color: AppColors.white,
                                size: 110,
                              ),
                            ),
                            SizedBox(height: Sizes.spaceBtwSections),

                          ],
                        )),

                    Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                              padding: const EdgeInsets.all(Sizes.defaultSpace),
                               child: Form(
                                   key: provider.formKey,
                                   child: Column(
                                     children: [
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
                                           }else if (value.trim().length != 10) {
                                             return "Phone number must be 10 digits";
                                           }
                                           return null;
                                         },
                                         // onCountryChanged: (country){
                                         //   provider.updateCountry(country);
                                         // },
                                       ),

                                       const SizedBox(height: Sizes.defaultSpace),


                                       Center(
                                         child: CustomButton(
                                           text: AppText.resetPassword,
                                           onPressed:   () {
                                             if(!provider.isLoading) {
                                               provider.emailPhone(context);
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
                                   )

                               ),
                          ),
                        ))
                  ],
                ),
              );
            }),
    );
  }
}
