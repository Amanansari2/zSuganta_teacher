import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/providers/support_screen/support_screen_provider.dart';
import 'package:z_tutor_suganta/screen/support/widgets/file_pick_row.dart';
import 'package:z_tutor_suganta/screen/support/widgets/text_widgets.dart';
import 'package:z_tutor_suganta/utils/constants/text_strings.dart';
import 'package:z_tutor_suganta/utils/helpers/user_sessions.dart';
import 'package:z_tutor_suganta/utils/theme/provider/theme_provider.dart';

import '../../models/accounts/options_model.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/sizes.dart';
import '../../widgets/containers/primary_header_container.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/texts/custom_text_form_field.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = context.watch<ThemeProvider>().isDarkMode;
    return ChangeNotifierProvider<SupportScreenProvider>(
      create: (context) {
        final provider = SupportScreenProvider();
        provider.init(context.read<UserSessionProvider>());
        return provider;
      },

      child: Consumer<SupportScreenProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: Column(
              children: [
                PrimaryHeaderContainer(
                  child: Column(
                    children: [
                      MyAppBar(
                        showBackArrow: false,
                        title: Text(
                          AppText.support,
                          style: Theme.of(context).textTheme.headlineLarge!
                              .apply(color: AppColors.white),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.defaultSpace,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppText.needAssistance,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .apply(color: AppColors.white),
                                  ),
                                  SizedBox(height: Sizes.sm),
                                  Text(
                                    AppText.fillFormBelow,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .apply(color: AppColors.white),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: Sizes.defaultSpace),
                            SizedBox(
                              child: Icon(
                                FontAwesomeIcons.headset,
                                color: AppColors.white,
                                size: 110,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: Sizes.spaceBtwSections),
                    ],
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Sizes.defaultSpace,
                    ),
                    child: Form(
                      key: provider.formKey,
                      child: ListView(
                        children: [
                          Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: RichText(
                                  text: TextSpan(
                                    text: AppText.category,
                                    style: TextStyle(
                                      fontSize: Sizes.fontSizeLg,
                                      fontWeight: FontWeight.w600,
                                      color: dark
                                          ? AppColors.white
                                          : AppColors.black,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: ' *',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(height: Sizes.spaceBtwItems),

                              CustomDropdown<TicketOptions>(
                                key: ValueKey(provider.selectedCategory?.id),
                                items: provider.categories,
                                selected: provider.selectedCategory,
                                onChanged: (val) {
                                  provider.setCategory(val);
                                },
                                itemLabel: (item) => item.label,
                                hint: AppText.selectCategory,
                                isLoading:
                                    provider.categories.isEmpty &&
                                    provider.isLoading,
                                iconColor: dark
                                    ? AppColors.blue
                                    : AppColors.orange,
                                textColor: dark
                                    ? AppColors.white
                                    : AppColors.black,
                                validator: (value) {
                                  if (value == null) {
                                    return "Category type is required";
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),

                          const SizedBox(height: Sizes.defaultSpace),

                          Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: RichText(
                                  text: TextSpan(
                                    text: AppText.priority,
                                    style: TextStyle(
                                      fontSize: Sizes.fontSizeLg,
                                      fontWeight: FontWeight.w600,
                                      color: dark
                                          ? AppColors.white
                                          : AppColors.black,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: ' *',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(height: Sizes.spaceBtwItems),

                              CustomDropdown<TicketOptions>(
                                key: ValueKey(provider.selectedPriorities?.id),
                                items: provider.priorities,
                                selected: provider.selectedPriorities,
                                onChanged: (val) {
                                  provider.setPriorities(val);
                                },
                                itemLabel: (item) => item.label,
                                hint: AppText.priorityLevel,
                                isLoading:
                                    provider.priorities.isEmpty &&
                                    provider.isLoading,
                                iconColor: dark
                                    ? AppColors.blue
                                    : AppColors.orange,
                                textColor: dark
                                    ? AppColors.white
                                    : AppColors.black,
                                validator: (value) {
                                  if (value == null) {
                                    return "Priority is required";
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),

                          const SizedBox(height: Sizes.defaultSpace),

                          AppTextFiled(
                            maxLines: 12,
                            maxLength: 5000,
                            showCounter: true,
                            controller: provider.messageController,
                            label: AppText.message,
                            hint: AppText.messageDetailed,
                            isRequired: true,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "message is required";
                              }
                              if (value.trim().length < 20) {
                                return "Minimum 10 characters are required";
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: Sizes.defaultSpace),

                          FilePickerRow(
                            onFileSelected: (file) {
                              provider.uploadedFile = file;
                            },
                          ),

                          const SizedBox(height: Sizes.defaultSpace),
                          const SizedBox(height: Sizes.defaultSpace),

                          Center(
                            child: CustomButton(
                              text: AppText.updateProfile,
                              onPressed: () {
                                if (!provider.isLoading) {
                                  // provider.updateProfile(context);
                                }
                              },
                              color: dark ? AppColors.blue : AppColors.orange,
                              textColor: AppColors.white,
                              radius: 15,
                              fontSize: Sizes.md,
                              width: 300,
                            ),
                          ),

                          const SizedBox(height: Sizes.defaultSpace),
                          const SizedBox(height: Sizes.defaultSpace),

                          Divider(),

                          const SizedBox(height: Sizes.size50),

                          Text(
                            AppText.needHelp,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          const SizedBox(height: Sizes.spaceBtwItems),

                          Text(
                            AppText.everythingNeedToKnow,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),

                          const SizedBox(height: Sizes.spaceBtwSections),

                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: dark ? AppColors.black : AppColors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: dark ? Colors.white : Colors.grey,
                                    blurRadius:  3,
                                  ),
                                ],
                              ),

                              child: Column(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.lightbulb,
                                    size: 50,
                                    color: dark
                                        ? AppColors.blue
                                        : AppColors.orange,
                                  ),
                                  const SizedBox(height: Sizes.spaceBtwItems),
                                  Text(
                                    AppText.tips,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineLarge,
                                  ),

                                  const SizedBox(height: Sizes.defaultSpace),

                                  iconTextItem(
                                    context: context,
                                    label: AppText.provideInformation,
                                  ),

                                  const SizedBox(height: Sizes.defaultSpace),

                                  iconTextItem(
                                    context: context,
                                    label: AppText.includeScreenshot,
                                  ),

                                  const SizedBox(height: Sizes.defaultSpace),

                                  iconTextItem(
                                    context: context,
                                    label: AppText.patientResponse,
                                  ),

                                  const SizedBox(height: Sizes.defaultSpace),

                                  iconTextItem(
                                    context: context,
                                    label: AppText.followupNeeded,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: Sizes.spaceBtwSections),

                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: dark ? AppColors.black : AppColors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: dark ? Colors.white : Colors.grey,
                                    blurRadius: 3,
                                  ),
                                ],
                              ),

                              child: Column(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.ticket,
                                    size: 50,
                                    color: dark
                                        ? AppColors.blue
                                        : AppColors.orange,
                                  ),
                                  const SizedBox(height: Sizes.spaceBtwItems),
                                  Text(
                                    AppText.ticketStatus,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineLarge,
                                  ),

                                  const SizedBox(height: Sizes.defaultSpace),

                                  singleTextItem(
                                    context: context,
                                    color: AppColors.aqua,
                                    colorText: AppText.open,
                                    label: AppText.newTicketAwaitingResponse,
                                  ),

                                  const SizedBox(height: Sizes.defaultSpace),

                                  singleTextItem(
                                    context: context,
                                    color: AppColors.yellow,
                                    colorText: AppText.inProgress,
                                    label: AppText.adminWorking,
                                  ),

                                  const SizedBox(height: Sizes.defaultSpace),

                                  singleTextItem(
                                    context: context,
                                    color: AppColors.sky,
                                    colorText: AppText.waiting,
                                    label: AppText.waitingYourResponse,
                                  ),

                                  const SizedBox(height: Sizes.defaultSpace),

                                  singleTextItem(
                                    context: context,
                                    color: AppColors.green,
                                    colorText: AppText.resolved,
                                    label: AppText.issueResolved,
                                  ),

                                  const SizedBox(height: Sizes.defaultSpace),

                                  singleTextItem(
                                    context: context,
                                    color: AppColors.grey,
                                    colorText: AppText.closed,
                                    label: AppText.ticketClosed,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: Sizes.spaceBtwSections),

                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: dark ? AppColors.black : AppColors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: dark ? Colors.white : Colors.grey,
                                    blurRadius: 3,
                                  ),
                                ],
                              ),

                              child: Column(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.clockFour,
                                    size: 50,
                                    color: dark
                                        ? AppColors.blue
                                        : AppColors.orange,
                                  ),
                                  const SizedBox(height: Sizes.spaceBtwItems),
                                  Text(
                                    AppText.responseTimes,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineLarge,
                                  ),

                                  const SizedBox(height: Sizes.defaultSpace),

                                  doubleTextItem(
                                    context: context,
                                    color: AppColors.red,
                                    colorText: AppText.urgent,
                                    label: AppText.within2hours,
                                    description: AppText.criticalIssue,
                                  ),

                                  const SizedBox(height: Sizes.defaultSpace),

                                  doubleTextItem(
                                    context: context,
                                    color: AppColors.lightOrange,
                                    colorText: AppText.high,
                                    label: AppText.within24hours,
                                    description: AppText.importantIssue,
                                  ),

                                  const SizedBox(height: Sizes.defaultSpace),

                                  doubleTextItem(
                                    context: context,
                                    color: AppColors.yellow,
                                    colorText: AppText.medium,
                                    label: AppText.within48hours,
                                    description: AppText.generalInquiries,
                                  ),

                                  const SizedBox(height: Sizes.defaultSpace),

                                  doubleTextItem(
                                    context: context,
                                    color: AppColors.grey,
                                    colorText: AppText.low,
                                    label: AppText.within72hours,
                                    description: AppText.featureRequest,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: Sizes.spaceBtwSections),

                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: dark ? AppColors.black : AppColors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: dark ? Colors.white : Colors.grey,
                                    blurRadius: 3,
                                  ),
                                ],
                              ),

                              child: Column(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.tags,
                                    size: 50,
                                    color: dark
                                        ? AppColors.blue
                                        : AppColors.orange,
                                  ),
                                  const SizedBox(height: Sizes.spaceBtwItems),
                                  Text(
                                    AppText.categories,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineLarge,
                                  ),

                                  const SizedBox(height: Sizes.defaultSpace),

                                  singleTextItem(
                                    context: context,
                                    color: AppColors.aqua,
                                    colorText: AppText.subject,
                                    label: AppText.subjectQuestion,
                                  ),

                                  const SizedBox(height: Sizes.defaultSpace),

                                  singleTextItem(
                                    context: context,
                                    color: AppColors.yellow,
                                    colorText: AppText.exam,
                                    label: AppText.examIssue,
                                  ),

                                  const SizedBox(height: Sizes.defaultSpace),

                                  singleTextItem(
                                    context: context,
                                    color: AppColors.sky,
                                    colorText: AppText.requestNewSubject,
                                    label: AppText.addSubjectPlatform,
                                  ),

                                  const SizedBox(height: Sizes.defaultSpace),

                                  singleTextItem(
                                    context: context,
                                    color: AppColors.green,
                                    colorText: AppText.technical,
                                    label: AppText.platformIssue,
                                  ),

                                  const SizedBox(height: Sizes.defaultSpace),

                                  singleTextItem(
                                    context: context,
                                    color: AppColors.grey,
                                    colorText: AppText.general,
                                    label: AppText.otherInquiries,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: Sizes.spaceBtwSections),

                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: dark ? AppColors.black : AppColors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: dark ? Colors.white : Colors.grey,
                                    blurRadius: 3,
                                  ),
                                ],
                              ),

                              child: Column(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.exclamationTriangle,
                                    size: 50,
                                    color: dark
                                        ? AppColors.blue
                                        : AppColors.orange,
                                  ),
                                  const SizedBox(height: Sizes.spaceBtwItems),
                                  Text(
                                    AppText.priorityLevels,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineLarge,
                                  ),

                                  const SizedBox(height: Sizes.defaultSpace),

                                  singleTextItem(
                                    context: context,
                                    color: AppColors.red,
                                    colorText: AppText.urgent,
                                    label: AppText.criticalAttention,
                                  ),

                                  const SizedBox(height: Sizes.defaultSpace),

                                  singleTextItem(
                                    context: context,
                                    color: AppColors.yellow,
                                    colorText: AppText.high,
                                    label: AppText.importantResponse,
                                  ),

                                  const SizedBox(height: Sizes.defaultSpace),

                                  singleTextItem(
                                    context: context,
                                    color: AppColors.sky,
                                    colorText: AppText.medium,
                                    label: AppText.normalPriority,
                                  ),

                                  const SizedBox(height: Sizes.defaultSpace),

                                  singleTextItem(
                                    context: context,
                                    color: AppColors.grey,
                                    colorText: AppText.low,
                                    label: AppText.minorRush,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: Sizes.defaultSpace),
                          const SizedBox(height: Sizes.defaultSpace),
                          const SizedBox(height: Sizes.defaultSpace),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
