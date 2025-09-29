import 'package:z_tutor_suganta/utils/helpers/helper_function.dart';

class TicketDetails {
  final Ticket ticket;
  final List<Reply> replies;
  final bool canReply;
  final bool canClose;

  const TicketDetails({
    required this.ticket,
    required this.replies,
    required this.canReply,
    required this.canClose,
  });

  factory TicketDetails.fromJson(Map<String, dynamic> json) {
    return TicketDetails(
      ticket: Ticket.fromJson(json['ticket'] ?? {}),
      replies: (json['replies'] as List<dynamic>? ?? [])
          .map((e) => Reply.fromJson(e))
          .toList(),
      canReply: HelperFunction.parseBool(json['can_reply']) ,
      canClose: HelperFunction.parseBool(json['can_close']) ,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ticket': ticket.toJson(),
      'replies': replies.map((e) => e.toJson()).toList(),
      'can_reply': canReply,
      'can_close': canClose,
    };
  }
}

class Ticket {
  final int id;
  final String ticketNumber;
  final String subject;
  final String message;
  final String priority;
  final String status;
  final String category;
  final String? assignedTo;
  final DateTime? resolvedAt;
  final String? attachmentPath;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Ticket({
    required this.id,
    required this.ticketNumber,
    required this.subject,
    required this.message,
    required this.priority,
    required this.status,
    required this.category,
    this.assignedTo,
    this.resolvedAt,
    this.attachmentPath,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'] ?? 0,
      ticketNumber: json['ticket_number'] ?? '',
      subject: json['subject'] ?? '',
      message: json['message'] ?? '',
      priority: json['priority'] ?? '',
      status: json['status'] ?? '',
      category: json['category'] ?? '',
      assignedTo: json['assigned_to'],
      resolvedAt: json['resolved_at'] != null ? DateTime.tryParse(json['resolved_at']) : null,
      attachmentPath: json['attachment_path'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ticket_number': ticketNumber,
      'subject': subject,
      'message': message,
      'priority': priority,
      'status': status,
      'category': category,
      'assigned_to': assignedTo,
      'resolved_at': resolvedAt,
      'attachment_path': attachmentPath,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class Reply {
  final String message;
  final bool isAdminReply;
  final String? attachmentPath;
  final DateTime createdAt;
  final TicketUser user;

  const Reply({
    required this.message,
    required this.isAdminReply,
    this.attachmentPath,
    required this.createdAt,
    required this.user
  });

  factory Reply.fromJson(Map<String, dynamic> json) {
    return Reply(
      message: json['message'] ?? '',
      isAdminReply: HelperFunction.parseBool(json['is_admin_reply']),
      attachmentPath: json['attachment_path'],
      createdAt: DateTime.parse(json['created_at']),
      user: TicketUser.fromJson(json['user'] ?? {})
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'is_admin_reply': isAdminReply,
      'attachment_path': attachmentPath,
      'created_at': createdAt,
      'user':  user.toJson(),
    };
  }

  String get ticketUserName => user.name;
}

class TicketUser{
  final int id;
  final String name;

  const TicketUser({
    required this.id,
    required this.name
});

  factory TicketUser.fromJson(Map<String, dynamic> json){
    return TicketUser(
        id: json['id'] ?? 0,
        name:json['name'] ?? ''
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'name' : name
    };
  }
}



