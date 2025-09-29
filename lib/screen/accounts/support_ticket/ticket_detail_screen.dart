import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:z_tutor_suganta/providers/support_screen/ticket_details_provider.dart';
import 'package:z_tutor_suganta/utils/constants/sizes.dart';
import 'package:z_tutor_suganta/utils/constants/text_strings.dart';
import 'package:z_tutor_suganta/utils/theme/provider/theme_provider.dart';
import 'package:z_tutor_suganta/widgets/containers/primary_header_container.dart';
import 'package:z_tutor_suganta/widgets/custom_app_bar.dart';

import '../../../configs/url.dart';
import '../../../utils/constants/app_colors.dart';
import '../../support/widgets/file_pick_row.dart';

class TicketDetailScreen extends StatefulWidget {
  final int ticketId;
  const TicketDetailScreen({super.key, required this.ticketId});

  @override
  State<TicketDetailScreen> createState() => _TicketDetailScreenState();
}

class _TicketDetailScreenState extends State<TicketDetailScreen> {
  final ScrollController _scrollController = ScrollController();

  String formatDate(DateTime? dt) =>
      dt != null ? dt.toLocal().toString().split('.').first : '—';

  String capitalizeFirstWord(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'low':
        return AppColors.grey;
      case 'medium':
        return AppColors.yellow;
      case 'high':
        return AppColors.orange;
      case 'urgent':
        return AppColors.red;
      default:
        return AppColors.red;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'open':
        return AppColors.aqua;
      case 'in_progress':
        return AppColors.yellow;
      case 'closed':
        return AppColors.grey;
      case 'waiting_for_user':
        return AppColors.sky;
      case 'resolved':
        return AppColors.green;
      default:
        return AppColors.aqua;
    }
  }

  @override
  void initState() {
    super.initState();
    final provider = context.read<TicketDetailsProvider>();
    Future.microtask(() async {
      await provider.fetchTicketDetails(context, ticketId: widget.ticketId);
      if (mounted) setState(() {});
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 100,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = context.watch<ThemeProvider>().isDarkMode;
    final provider = context.watch<TicketDetailsProvider>();
    final ticketDetails = provider.ticketDetails;

    if (ticketDetails == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final ticket = ticketDetails.ticket;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          PrimaryHeaderContainer(
            child: Column(
              children: [
                MyAppBar(
                  showBackArrow: true,
                  title: Text(
                    ticket.ticketNumber,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: AppColors.white),
                  ),
                ),
                SizedBox(height: Sizes.defaultSpace),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
              itemCount: 1 + ticketDetails.replies.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  // Ticket details card
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
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
                          capitalizeFirstWord(ticket.subject),
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: dark ? AppColors.white : AppColors.black),
                        ),
                        SizedBox(height: Sizes.sm),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${AppText.priority} :   ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: dark
                                          ? AppColors.white.withOpacity(0.7)
                                          : AppColors.black.withOpacity(0.7)),
                                ),
                                Text(
                                  ticket.priority.toUpperCase(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: _getPriorityColor(ticket.priority)),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "${AppText.status} :   ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: dark
                                          ? AppColors.white.withOpacity(0.7)
                                          : AppColors.black.withOpacity(0.7)),
                                ),
                                Text(
                                  ticket.status.toUpperCase(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: _getStatusColor(ticket.status)),
                                )
                              ],
                            ),
                          ],
                        ),
                        Divider(
                          color: dark
                              ? AppColors.white.withOpacity(0.5)
                              : AppColors.black.withOpacity(0.5),
                        ),
                        SizedBox(height: Sizes.xs),
                        Row(
                          children: [
                            Text(
                              "${AppText.category} : "    ,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: dark
                                      ? AppColors.white.withOpacity(0.6)
                                      : AppColors.black.withOpacity(0.6)),
                            ),
                            Text(
                              capitalizeFirstWord(ticket.category),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: dark ? AppColors.white : AppColors.black),
                            )
                          ],
                        ),
                        SizedBox(height: Sizes.xs),
                        Row(
                          children: [
                            Text(
                              "${AppText.createdAt} : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: dark
                                      ? AppColors.white.withOpacity(0.6)
                                      : AppColors.black.withOpacity(0.6)),
                            ),
                            Text(
                              capitalizeFirstWord(formatDate(ticket.createdAt)),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: dark ? AppColors.white : AppColors.black),
                            )
                          ],
                        ),
                        SizedBox(height: Sizes.xs),
                        Row(
                          children: [
                            Text(
                              "${AppText.updatedAt} : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: dark
                                      ? AppColors.white.withOpacity(0.6)
                                      : AppColors.black.withOpacity(0.6)),
                            ),
                            Text(
                              capitalizeFirstWord(formatDate(ticket.updatedAt)),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: dark ? AppColors.white : AppColors.black),
                            )
                          ],
                        ),
                        SizedBox(height: Sizes.xs),
                        if (ticketDetails.canClose)
                          Center(
                            child: ElevatedButton(
                                onPressed: () async{
                                  await provider.closeTicket(context, ticketId: ticket.id);
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: AppColors.red),
                                child: Text(AppText.closeTicket,
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14))),
                          ),
                        SizedBox(height: Sizes.sm),
                      ],
                    ),
                  );
                } else {
                  // Replies
                  final reply = ticketDetails.replies[index - 1];
                  return Align(
                    alignment: reply.isAdminReply ? Alignment.centerLeft : Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: reply.isAdminReply
                            ? (dark ? AppColors.blue : AppColors.orange)
                            : AppColors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(reply.ticketUserName,
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          SelectableText(reply.message),
                          if(reply.attachmentPath != null && reply.attachmentPath!.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: InkWell(
                                onTap: () async {
                                  final fullUrl = '${ApiUrls.mediaUrl}${reply.attachmentPath}';
                                  final uri = Uri.parse(fullUrl);
                                  if(await canLaunchUrl(uri)){
                                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("Cannot open attachment")),
                                    );
                                  }
                                },
                                child: Row(
                                  children: [
                                    const Icon(Icons.attach_file, size: 16, color: Colors.white),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        reply.attachmentPath!.split('/').last,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          decoration: TextDecoration.underline,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          const SizedBox(height: 4),
                          Text(
                            reply.createdAt.toLocal().toString().split('.').first,
                            style: TextStyle(
                                fontSize: 12, color: dark ? AppColors.white.withOpacity(0.8) : AppColors.black.withOpacity(0.8)),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: ticketDetails.canReply
          ? Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: dark ? AppColors.black : AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: provider.replyController,
                        decoration: InputDecoration(
                          hintText: AppText.typeYourReply,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                        ),
                        onTap: () {

                          Future.delayed(const Duration(milliseconds: 200),
                                  () => _scrollController.jumpTo(
                                  _scrollController.position.maxScrollExtent));
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: ()  async{

                        Future.delayed(const Duration(milliseconds: 100),
                                () => _scrollController.jumpTo(
                                _scrollController.position.maxScrollExtent));

                        await provider.replyTicket(context, ticketId: ticket.id);
                        provider.replyController.clear();
                        setState(() {
                          provider.uploadedFile = null;
                        });

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: dark ? AppColors.blue : AppColors.orange,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Icon(Icons.send, color: AppColors.white),
                    ),
                  ],
                ),
                SizedBox(height: Sizes.sm,),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                  child: FilePickerRow(
                    file: provider.uploadedFile,
                    onFileSelected: (file) {
                      provider.uploadedFile = file;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      )
          : null,

    );
  }
}
