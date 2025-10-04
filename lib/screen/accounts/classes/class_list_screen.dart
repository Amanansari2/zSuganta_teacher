import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/models/classes/class_list_model.dart';
import 'package:z_tutor_suganta/providers/classes/all_classes_provider.dart';
import 'package:z_tutor_suganta/screen/accounts/classes/widget/class_card.dart';
import 'package:z_tutor_suganta/utils/theme/provider/theme_provider.dart';
import 'package:z_tutor_suganta/utils/theme/theme_switcher_button.dart';
import 'package:z_tutor_suganta/widgets/containers/primary_header_container.dart';

import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../widgets/custom_app_bar.dart';

class ClassListScreen extends StatefulWidget {
  const ClassListScreen({super.key});

  @override
  State<ClassListScreen> createState() => _ClassListScreenState();
}

class _ClassListScreenState extends State<ClassListScreen> with SingleTickerProviderStateMixin {

  late TabController _tabController;
  late ScrollController _allClassController;
  late ScrollController _upcomingClassController;
  late ScrollController _completedClassController;
  late ScrollController _canceledClassController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _allClassController = ScrollController();
    _upcomingClassController = ScrollController();
    _completedClassController = ScrollController();
    _canceledClassController = ScrollController();
    final provider = context.read<AllClassesProvider>();
    Future.microtask((){
    provider.fetchClasses(context);
    provider.fetchUpcomingClasses(context);
    provider.fetchCompletedClasses(context);
    provider.fetchCancelledClasses(context);
    });
    attachPaginationListener(_allClassController, provider);
    attachUpcomingPaginationListener(_upcomingClassController, provider);
    attachCompletedPaginationListener(_completedClassController, provider);
    attachCancelledPaginationListener(_canceledClassController, provider);
  }

  @override
  void dispose() {
   _tabController.dispose();
   _allClassController.dispose();
   _upcomingClassController.dispose();
   _completedClassController.dispose();
   _canceledClassController.dispose();
    super.dispose();
  }

  void attachPaginationListener(
      ScrollController controller, AllClassesProvider provider){
    controller.addListener((){
      if(controller.position.pixels >= controller.position.maxScrollExtent - 200){
        provider.fetchClasses(context, loadMore: true);
      }
    });
  }

  void attachUpcomingPaginationListener(
      ScrollController controller, AllClassesProvider provider){
    controller.addListener((){
      if(controller.position.pixels >= controller.position.maxScrollExtent - 200){
        provider.fetchUpcomingClasses(context, loadMore: true);
      }
    });
  }

  void attachCompletedPaginationListener(
      ScrollController controller, AllClassesProvider provider){
    controller.addListener((){
      if(controller.position.pixels >= controller.position.maxScrollExtent - 200){
        provider.fetchCompletedClasses(context, loadMore: true);
      }
    });
  }

  void attachCancelledPaginationListener(
      ScrollController controller, AllClassesProvider provider){
    controller.addListener((){
      if(controller.position.pixels >= controller.position.maxScrollExtent - 200){
        provider.fetchCancelledClasses(context, loadMore: true);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;
    return Consumer<AllClassesProvider>(
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
                            AppText.classes,
                            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ),

                        Icon(
                          FontAwesomeIcons.chalkboardTeacher,
                          color: AppColors.white,
                          size: 110,
                        ),




                        const SizedBox(height: Sizes.spaceBtwSections),


                      ],
                    )),

                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.blue : AppColors.orange,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TabBar(
                    dividerColor: Colors.transparent,
                    controller: _tabController,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: isDark ? AppColors.orange : AppColors.blue,
                    ),
                    labelColor: AppColors.white,
                    unselectedLabelColor: AppColors.white,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs:  [
                      Tab( child: Text(AppText.all, style: Theme.of(context).textTheme.labelSmall, textAlign: TextAlign.center),),
                      Tab(child: Text(AppText.upcoming, style: Theme.of(context).textTheme.labelSmall, textAlign: TextAlign.center),),
                      Tab(child: Text(AppText.completed, style: Theme.of(context).textTheme.labelSmall, textAlign: TextAlign.center),),
                      Tab(child: Text(AppText.canceled, style: Theme.of(context).textTheme.labelSmall, textAlign: TextAlign.center),),
                    ],),
                ),

                Expanded(
                    child: TabBarView(
                        controller: _tabController,
                        children: [
                          buildClassList(provider.allClasses, _allClassController, provider),
                          buildClassList(provider.upcomingClasses, _upcomingClassController, provider),
                          buildClassList(provider.completedClasses, _completedClassController, provider),
                          buildClassList(provider.cancelledClasses, _canceledClassController, provider),
                        ])),

                SizedBox(height:  Sizes.defaultSpace,)

              ],
            ),
          );
        });
  }

  Widget buildClassList(
      List<ClassList> classes,
      ScrollController controller,
      AllClassesProvider provider
      ){
    if(classes.isEmpty && provider.isLoading){
      return const Center(child : CircularProgressIndicator());
    }

    if(classes.isEmpty){
      return Center(child:  Text(
          AppText.noClassesFound,
         style: Theme.of(context).textTheme.headlineLarge,
      ));
    }

    return ListView.builder(
        controller: controller,
        itemCount: classes.length + (provider.isLoading ? 1 : 0),
        itemBuilder: (context, index){
          if(index == classes.length){
            return const Padding(
              padding: EdgeInsets.all(12),
              child: Center( child:  CircularProgressIndicator(),),
            ) ;
          }

          final aClass = classes[index];
          return ClassCard(
            classData : aClass,
          onPressed : (){
              context.pushNamed(
                  'classDetailScreen',
                  pathParameters: {'classId' : aClass.id.toString()}
              );
          }
          );
        });
  }


}
