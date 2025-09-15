import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../models/accounts/sessions_model.dart';

class SessionCard extends StatelessWidget {
  final SessionData session;
  final VoidCallback onDelete;

  const SessionCard({
    Key? key,
    required this.session,
    required this.onDelete,
  }) : super(key: key);

  String formatDate(DateTime? dt) =>
      dt != null ? dt.toLocal().toString().split('.').first : '—';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isActive = session.isActive;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: theme.brightness == Brightness.dark
                ? Colors.black26
                : Colors.grey,
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  session.deviceName,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isActive ? Colors.green[100] : Colors.red[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  isActive ? 'Active' : 'Inactive',
                  style: TextStyle(
                    color: isActive ? Colors.green[800] : Colors.red[800],
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),

          const SizedBox(height: 12),

          /// IP Address
          _buildInfoRow(context, FontAwesomeIcons.earthAsia, 'IP', session.ipAddress),

          /// Device Type
          _buildInfoRow(context, FontAwesomeIcons.computer, 'Device Type', session.deviceType),

          /// Location
          _buildInfoRow(context, FontAwesomeIcons.locationDot, 'Location', session.location),

          /// Created At
          _buildInfoRow(context, FontAwesomeIcons.calendarCheck, 'Created At', formatDate(session.createdAt)),

          /// Last Activity
          _buildInfoRow(context, FontAwesomeIcons.clockRotateLeft, 'Last Activity', formatDate(session.lastActivity)),

          /// Login Time
          _buildInfoRow(context, FontAwesomeIcons.rightToBracket, 'Login At', formatDate(session.loginAt)),

          /// Logout Time
          _buildInfoRow(context, FontAwesomeIcons.rightFromBracket, 'Logout At', formatDate(session.logoutAt)),

          const SizedBox(height: 16),

          /// Delete Button Row
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: onDelete,
              tooltip: 'Delete Session',
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String label, String value) {
    final textStyle = Theme.of(context).textTheme.bodySmall;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          const SizedBox(width: 8),
          Text('$label: ', style: textStyle?.copyWith(fontWeight: FontWeight.w600)),
          Expanded(
            child: Text(value, style: textStyle, overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}
