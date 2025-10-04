import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/providers/classes/all_classes_provider.dart';
import 'package:z_tutor_suganta/utils/constants/text_strings.dart';
import 'package:z_tutor_suganta/utils/helpers/helper_function.dart';
import 'package:z_tutor_suganta/utils/helpers/logger_helper.dart';
import 'package:z_tutor_suganta/utils/theme/provider/theme_provider.dart';
import 'package:z_tutor_suganta/widgets/containers/primary_header_container.dart';

import '../../../configs/url.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../widgets/custom_app_bar.dart';

class ClassDetailScreen extends StatefulWidget {
  final int classId;

  const ClassDetailScreen({super.key, required this.classId});

  @override
  State<ClassDetailScreen> createState() => _ClassDetailScreenState();
}

class _ClassDetailScreenState extends State<ClassDetailScreen> {
  String capitalizeFirstWord(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  void initState() {
    super.initState();
    final provider = context.read<AllClassesProvider>();
    Future.microtask(() async {
      await provider.fetchClassDetails(context, classId: widget.classId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = context.watch<ThemeProvider>().isDarkMode;
    final provider = context.watch<AllClassesProvider>();
    final classDetails = provider.classDetails;

    if (classDetails == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: Column(
        children: [
          PrimaryHeaderContainer(
            child: Column(
              children: [
                MyAppBar(
                  showBackArrow: true,
                  title: Text(
                    AppText.classDetails,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        context.pushNamed('editClassScreen', extra:  classDetails);
                      },
                      child: Text(
                        AppText.edit,
                        style: Theme.of(context).textTheme.headlineSmall!
                            .copyWith(
                              color: AppColors.white,
                              decoration: TextDecoration.underline,
                            ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Sizes.defaultSpace),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              children: [
                Column(
                  children: [
                    Container(
                      width: HelperFunction.screenWidth(context),
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: dark ? AppColors.black : AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: dark ? AppColors.white : AppColors.grey,
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            classDetails.title,
                            style: Theme.of(context).textTheme.headlineMedium!
                                .copyWith(
                                  color: dark
                                      ? AppColors.white
                                      : AppColors.black,
                                ),
                          ),
                          SizedBox(height: Sizes.sm),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${AppText.teacherName} :   ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: dark
                                          ? AppColors.white.withOpacity(0.7)
                                          : AppColors.black.withOpacity(0.7),
                                    ),
                                  ),
                                  Text(
                                    classDetails.teacher.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: dark
                                          ? AppColors.white
                                          : AppColors.black,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: Sizes.sm),

                              Row(
                                children: [
                                  Text(
                                    "${AppText.status} :   ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: dark
                                          ? AppColors.white.withOpacity(0.7)
                                          : AppColors.black.withOpacity(0.7),
                                    ),
                                  ),
                                  Text(
                                    classDetails.status.toUpperCase(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: dark
                                          ? AppColors.white
                                          : AppColors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          Divider(
                            color: dark
                                ? AppColors.white.withOpacity(0.5)
                                : AppColors.black.withOpacity(0.5),
                          ),
                          SizedBox(height: Sizes.sm),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppText.subject,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: dark
                                          ? AppColors.white.withOpacity(0.7)
                                          : AppColors.black.withOpacity(0.7),
                                    ),
                                  ),
                                  Text(
                                    classDetails.subject.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: dark
                                          ? AppColors.white
                                          : AppColors.black,
                                    ),
                                  ),
                                ],
                              ),

                              Column(
                                children: [
                                  Text(
                                    AppText.price,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: dark
                                          ? AppColors.white.withOpacity(0.7)
                                          : AppColors.black.withOpacity(0.7),
                                    ),
                                  ),
                                  Text(
                                    classDetails.price,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: dark
                                          ? AppColors.white
                                          : AppColors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: Sizes.defaultSpace),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppText.dateTime,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: dark
                                          ? AppColors.white.withOpacity(0.7)
                                          : AppColors.black.withOpacity(0.7),
                                    ),
                                  ),
                                  Text(
                                    DateFormat(
                                      'EEEE, dd MMM yyyy',
                                    ).format(classDetails.date),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: dark
                                          ? AppColors.white
                                          : AppColors.black,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(FontAwesomeIcons.clock, size: 18),
                                      SizedBox(width: Sizes.sm),
                                      Text(
                                        classDetails.time,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: dark
                                              ? AppColors.white
                                              : AppColors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              Column(
                                children: [
                                  Text(
                                    AppText.maxStudents,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: dark
                                          ? AppColors.white.withOpacity(0.7)
                                          : AppColors.black.withOpacity(0.7),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.peopleGroup,
                                        size: 18,
                                      ),
                                      SizedBox(width: Sizes.sm),
                                      Text(
                                        classDetails.maxStudents.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: dark
                                              ? AppColors.white
                                              : AppColors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: Sizes.defaultSpace),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppText.duration,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: dark
                                          ? AppColors.white.withOpacity(0.7)
                                          : AppColors.black.withOpacity(0.7),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.clockRotateLeft,
                                        size: 18,
                                      ),
                                      SizedBox(width: Sizes.sm),
                                      Text(
                                        classDetails.duration.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: dark
                                              ? AppColors.white
                                              : AppColors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppText.classType,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: dark
                                          ? AppColors.white.withOpacity(0.7)
                                          : AppColors.black.withOpacity(0.7),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(FontAwesomeIcons.laptop, size: 18),
                                      SizedBox(width: Sizes.sm),
                                      Text(
                                        capitalizeFirstWord(classDetails.type),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: dark
                                              ? AppColors.white
                                              : AppColors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),

                          SizedBox(height: Sizes.defaultSpace),

                          Text(
                            AppText.locationMeetingLink,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: dark
                                  ? AppColors.white.withOpacity(0.7)
                                  : AppColors.black.withOpacity(0.7),
                            ),
                          ),

                          SizedBox(height: Sizes.sm),

                          Row(
                            children: [
                              Icon(FontAwesomeIcons.locationDot, size: 18),
                              SizedBox(width: Sizes.sm),
                              SelectableText(
                                classDetails.location ?? '',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: dark
                                      ? AppColors.white
                                      : AppColors.black,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: Sizes.defaultSpace),

                          Text(
                            AppText.description,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: dark
                                  ? AppColors.white.withOpacity(0.7)
                                  : AppColors.black.withOpacity(0.7),
                            ),
                          ),

                          Text(
                            classDetails.description ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: dark ? AppColors.white : AppColors.black,
                            ),
                          ),

                          SizedBox(height: Sizes.defaultSpace),

                          Divider(
                            color: dark
                                ? AppColors.white.withOpacity(0.5)
                                : AppColors.black.withOpacity(0.5),
                          ),
                          SizedBox(height: Sizes.defaultSpace),
                          Text(
                            "${AppText.importantNotes}  :",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: dark
                                  ? AppColors.white.withOpacity(0.7)
                                  : AppColors.black.withOpacity(0.7),
                            ),
                          ),

                          SizedBox(height: Sizes.sm),

                          SelectableText(
                            classDetails.notes ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: dark ? AppColors.white : AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: Sizes.spaceBtwSections),

                    Container(
                      width: HelperFunction.screenWidth(context),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 1,
                      ),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: dark ? AppColors.black : AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: dark ? AppColors.white : AppColors.grey,
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppText.classStatistics,
                            style: Theme.of(context).textTheme.headlineLarge!
                                .copyWith(
                                  color: dark
                                      ? AppColors.white
                                      : AppColors.black,
                                ),
                          ),
                          Divider(
                            color: dark
                                ? AppColors.white.withOpacity(0.5)
                                : AppColors.black.withOpacity(0.5),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    (classDetails.enrollments?.length
                                            .toString()) ??
                                        '0',
                                    style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  Text(
                                    AppText.enrolledStudents,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),

                              Container(
                                height: 60,
                                width: 2,
                                color: dark
                                    ? AppColors.white.withOpacity(0.5)
                                    : AppColors.black.withOpacity(0.5),
                                margin: EdgeInsets.symmetric(horizontal: 16),
                              ),
                              Column(
                                children: [
                                  Text(
                                    '${(classDetails?.maxStudents ?? 0) - (classDetails?.enrollments?.length ?? 0)}',
                                    style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  Text(
                                    AppText.availableSeats,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: Sizes.spaceBtwSections),

                    Container(
                      width: HelperFunction.screenWidth(context),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 1,
                      ),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: dark ? AppColors.black : AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: dark ? AppColors.white : AppColors.grey,
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppText.enrolledStudents,
                            style: Theme.of(context).textTheme.headlineLarge!
                                .copyWith(
                                  color: dark
                                      ? AppColors.white
                                      : AppColors.black,
                                ),
                          ),
                          Divider(
                            color: dark
                                ? AppColors.white.withOpacity(0.5)
                                : AppColors.black.withOpacity(0.5),
                          ),

                          if (classDetails.enrollments != null &&
                              classDetails.enrollments!.isNotEmpty)
                            ...classDetails.enrollments!.map((student) {
                              final imageUrl = student.profileImage != null
                                  ? "${ApiUrls.mediaUrl}/${student.profileImage}" // prepend base url
                                  : null;
                              return ListTile(
                                leading: CircleAvatar(
                                  radius: 22,
                                  backgroundColor: Colors.grey.shade300,
                                  backgroundImage: imageUrl != null
                                      ? NetworkImage(imageUrl)
                                      : null,
                                  child: imageUrl == null
                                      ? const Icon(
                                          Icons.person,
                                          color: Colors.white,
                                        )
                                      : null,
                                ),
                                title: Text(
                                  "${student.firstName??''} ${student.lastName?? ''}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: dark
                                        ? AppColors.white
                                        : AppColors.black,
                                  ),
                                ),
                              );
                            })
                          else
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "No students enrolled yet",
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineSmall,
                              ),
                            ),
                        ],
                      ),
                    ),

                    SizedBox(height: Sizes.spaceBtwSections),


                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          if (!classDetails.isCompleted)
                            ElevatedButton(
                              onPressed: ()async{
                                await provider.completeClass(context, classId: classDetails.id);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)
                                ),
                              ),
                              child: Text(
                                  AppText.markAsComplete,
                              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                color: AppColors.white
                              ),
                              )),

                          if (!classDetails.isCancelled)
                            ElevatedButton(
                              onPressed: ()async {
                                 await provider.cancelClass(context, classId: classDetails.id);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.red,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)
                                ),
                              ),
                              child: Text(
                                AppText.cancelClass,
                                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                    color: AppColors.white
                                ),
                              )),

                        ],
                      ),
                    ),


                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
