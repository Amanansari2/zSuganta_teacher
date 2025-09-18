import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/screen/accounts/sessions/widget/session_card.dart';
import 'package:z_tutor_suganta/utils/theme/theme_switcher_button.dart';

import '../../../models/accounts/sessions_model.dart';
import '../../../providers/accounts/sessions_provider.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../utils/theme/provider/theme_provider.dart';
import '../../../widgets/containers/primary_header_container.dart';
import '../../../widgets/custom_app_bar.dart';

class SessionsScreen extends StatefulWidget {
  const SessionsScreen({super.key});

  @override
  State<SessionsScreen> createState() => _SessionsScreenState();
}

class _SessionsScreenState extends State<SessionsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _allScrollController;
  late ScrollController _activeScrollController;
  late ScrollController _inactiveScrollController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _allScrollController = ScrollController();
    _activeScrollController = ScrollController();
    _inactiveScrollController = ScrollController();
    Future.microtask(() {
      context.read<SessionsProvider>().fetchSessions(context);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _allScrollController.dispose();
    _activeScrollController.dispose();
    _inactiveScrollController.dispose();
    super.dispose();
  }

  void attachPaginationListener(ScrollController controller, SessionsProvider provider) {
    controller.addListener(() {
      if (controller.position.pixels >= controller.position.maxScrollExtent - 200) {
        provider.fetchSessions(context,loadMore: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;

    return Consumer<SessionsProvider>(
      builder: (context, provider, child) {
        // Attach scroll listeners (once)
        attachPaginationListener(_allScrollController, provider);
        attachPaginationListener(_activeScrollController, provider);
        attachPaginationListener(_inactiveScrollController, provider);

        return Scaffold(
          body: Column(
            children: [
              PrimaryHeaderContainer(
                child: Column(
                  children: [
                    MyAppBar(
                      showBackArrow: true,
                      title: Text(
                        AppText.allSessions,
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: Sizes.spaceBtwSections),
                    Icon(
                      FontAwesomeIcons.userLock,
                      color: AppColors.white,
                      size: 110,
                    ),
                    const SizedBox(height: Sizes.spaceBtwSections),
                  ],
                ),
              ),
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
                  tabs: const [
                    Tab(text: "All"),
                    Tab(text: "Active"),
                    Tab(text: "Inactive"),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    buildSessionList(provider.allSessions, _allScrollController, provider),
                    buildSessionList(provider.activeSessions, _activeScrollController, provider),
                    buildSessionList(provider.inactiveSessions, _inactiveScrollController, provider),
                  ],
                ),
              ),

            ],
          ),
        );
      },
    );
  }

  Widget buildSessionList(
      List<SessionData> sessions,
      ScrollController controller,
      SessionsProvider provider,
      ) {
    if (sessions.isEmpty && provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (sessions.isEmpty) {
      return const Center(child: Text("No sessions found"));
    }

    return ListView.builder(
      controller: controller,
      itemCount: sessions.length + (provider.isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == sessions.length) {
          return const Padding(
            padding: EdgeInsets.all(12.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final session = sessions[index];
        return SessionCard(
          session: session,
          onDelete: () {
            context.read<SessionsProvider>().deleteSession(context, session.id);
          },
        );
      },
    );
  }

}
