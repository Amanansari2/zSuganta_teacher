import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/models/accounts/tickets/ticket_model_list.dart';
import 'package:z_tutor_suganta/providers/support_screen/all_ticket_provider.dart';
import 'package:z_tutor_suganta/screen/accounts/support_ticket/widget/ticket_card.dart';
import 'package:z_tutor_suganta/utils/theme/provider/theme_provider.dart';
import 'package:z_tutor_suganta/widgets/containers/primary_header_container.dart';
import 'package:z_tutor_suganta/widgets/custom_app_bar.dart';

import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';

class SupportTicketListScreen extends StatefulWidget {
  const SupportTicketListScreen({super.key});

  @override
  State<SupportTicketListScreen> createState() => _SupportTicketListScreenState();
}

class _SupportTicketListScreenState extends State<SupportTicketListScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _allScrollController;
  late ScrollController _openScrollController;
  late ScrollController _resolvedScrollController;
  late ScrollController _urgentScrollController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _allScrollController = ScrollController();
    _openScrollController = ScrollController();
    _resolvedScrollController = ScrollController();
    _urgentScrollController = ScrollController();
    final provider = context.read<AllTicketProvider>();
    Future.microtask((){
      provider.fetchTickets(context);
    });
    attachPaginationListener(_allScrollController, provider);
    attachPaginationListener(_openScrollController, provider);
    attachPaginationListener(_resolvedScrollController, provider);
    attachPaginationListener(_urgentScrollController, provider);

  }

  @override
  void dispose() {
   _tabController.dispose();
   _allScrollController.dispose();
   _openScrollController.dispose();
   _resolvedScrollController.dispose();
   _urgentScrollController.dispose();
    super.dispose();
  }

  void attachPaginationListener(
      ScrollController controller, AllTicketProvider provider){
    controller.addListener((){
      if(controller.position.pixels >= controller.position.maxScrollExtent - 200){
        provider.fetchTickets(context, loadMore: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;
    return Consumer<AllTicketProvider>(
        builder: (context, provider, child){
          // attachPaginationListener(_allScrollController, provider);
          // attachPaginationListener(_openScrollController, provider);
          // attachPaginationListener(_resolvedScrollController, provider);
          // attachPaginationListener(_urgentScrollController, provider);

          return Scaffold(
            body: Column(
              children: [
                PrimaryHeaderContainer(
                    child: Column(
                      children: [
                        MyAppBar(
                          showBackArrow: true,
                          title: Text(
                            AppText.supportTickets,
                            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ),

                        Icon(
                          FontAwesomeIcons.ticket,
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
                        Tab( child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(AppText.all, style: Theme.of(context).textTheme.labelSmall,textAlign: TextAlign.center),
                          ],
                        ),),
                        Tab(child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(AppText.open, style: Theme.of(context).textTheme.labelSmall,textAlign: TextAlign.center),
                          ],
                        ),),
                        Tab(child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(AppText.resolved, style: Theme.of(context).textTheme.labelSmall,textAlign: TextAlign.center),
                          ],
                        ),),
                        Tab(child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(AppText.urgent, style: Theme.of(context).textTheme.labelSmall,textAlign: TextAlign.center),
                          ],
                        ),),
                      ],),
                ),

                Expanded(
                    child: TabBarView(
                        controller: _tabController,
                        children: [
                          buildTicketList(provider.allTickets, _allScrollController, provider),
                          buildTicketList(provider.openTickets, _openScrollController, provider),
                          buildTicketList(provider.resolvedTickets, _resolvedScrollController, provider),
                          buildTicketList(provider.urgentTickets, _urgentScrollController, provider),
                        ])),

                SizedBox(height: Sizes.defaultSpace,)
              ],
            ),
          );
        });
  }

  Widget buildTicketList(
      List<TicketData> tickets,
      ScrollController controller,
      AllTicketProvider provider
      ){
    if(tickets.isEmpty && provider.isLoading){
      return const Center( child : CircularProgressIndicator());
    }

    if(tickets.isEmpty){
      return const Center(child:  Text(AppText.noTicketFound),);
    }

    return ListView.builder(
        controller: controller,
        itemCount: tickets.length + (provider.isLoading ? 1 : 0),
        itemBuilder: (context, index){
          if(index == tickets.length){
            return const Padding(
              padding: EdgeInsets.all(12.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final ticket = tickets[index];
          return TicketCard(
            ticket: ticket,

              onPressed: () {
                context.pushNamed(
                  'ticketDetailScreen',
                  pathParameters: {'ticketId': ticket.id.toString()},
                );
              }

          );
        });
  }
}
