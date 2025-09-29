import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/models/accounts/tickets/ticket_model_list.dart';
import 'package:z_tutor_suganta/utils/constants/sizes.dart';

import '../../../../models/accounts/tickets/ticket_details_model.dart' as Apptext;
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/theme/provider/theme_provider.dart';
import '../../../../widgets/custom_button.dart';

class TicketCard extends StatelessWidget {
  final TicketData ticket;
  final VoidCallback onPressed;
  const TicketCard({
    super.key,
  required this.ticket,
    required this.onPressed
  });

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
        return AppColors.red; // fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = context.watch<ThemeProvider>().isDarkMode;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: dark ? AppColors.black : AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: dark
                ? Colors.white
                : Colors.grey,
            blurRadius: 2,

          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  "${Apptext.Ticket}  #${ticket.ticketNumber}",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color:  dark? AppColors.white.withOpacity(0.5) : AppColors.black.withOpacity(0.5),
              ),
              ),

              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: _getPriorityColor(ticket.priority),
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Text(
                    ticket.priority.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: AppColors.white
                ),
                ),
              )
            ],
          ),

          SizedBox(height: Sizes.xs,),

          Text(
            capitalizeFirstWord(ticket.subject),
          style: Theme.of(context).textTheme.headlineSmall,
            maxLines: 1,
          ),

          SizedBox(height: Sizes.defaultSpace,),

          Text(
            capitalizeFirstWord(ticket.message),
            style: Theme.of(context).textTheme.bodySmall,
            maxLines: 3,
          ),
          Divider( color:  dark? AppColors.white.withOpacity(0.5) : AppColors.black.withOpacity(0.5),),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0, ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text(
                    AppText.status,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: dark? AppColors.white.withOpacity(0.5) : AppColors.black.withOpacity(0.5),
                    ),
                  ),
                    Text(
                      capitalizeFirstWord(ticket.status),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),

                    const SizedBox(height: Sizes.defaultSpace,),

                    Text(
                      AppText.assignedTo,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: dark? AppColors.white.withOpacity(0.5) : AppColors.black.withOpacity(0.5),
                      ),
                    ),
                    Text(
                      capitalizeFirstWord(ticket.assignedTo?? ''),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    ]
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppText.category,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color:  dark? AppColors.white.withOpacity(0.5) : AppColors.black.withOpacity(0.5),
                        ),
                      ),
                      Text(
                        capitalizeFirstWord(ticket.category),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),

                      const SizedBox(height: Sizes.defaultSpace,),

                      Text(
                        AppText.updatedAt,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color:  dark? AppColors.white.withOpacity(0.5) : AppColors.black.withOpacity(0.5),
                        ),
                      ),
                      Text(
                        capitalizeFirstWord(formatDate(ticket.updatedAt)),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ]
                )
              ],
            ),
          ),

          SizedBox(height: Sizes.defaultSpace,),
          Center(
            child: CustomButton(
              text: AppText.viewTicketDetails,
              onPressed: onPressed,
              color: dark ? AppColors.blue : AppColors.orange,
              textColor: AppColors.white,
              radius: 15,
              fontSize: Sizes.md,
              width: 300,
            ),
          ),
        ],
      ),
    );
  }
}
