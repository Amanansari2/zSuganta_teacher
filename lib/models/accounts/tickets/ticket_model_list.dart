class TicketModelList{
  final int currentPage;
  final int lastPage;
  final List <TicketData> data;

  const TicketModelList({
  required this.currentPage,
  required this.lastPage,
  required this.data
});

  factory TicketModelList.fromJson(Map<String, dynamic> json){
    final ticketList = (json['ticket_list'] as List<dynamic>?) ?? [];
    final pagination = json['pagination'] as Map<String, dynamic>? ?? {};

    return TicketModelList(
        currentPage: pagination['current_page'] ?? 1,
        lastPage: pagination['last_page'] ?? 1,
      data: ticketList.map((e) => TicketData.fromJson(e)).toList(),
    );
  }
}

class TicketData{
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
   final DateTime updatedAt;
   final DateTime createdAt;

   const TicketData({
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
     required this.updatedAt
});

   factory TicketData.fromJson(Map<String, dynamic> json){
     return TicketData(
         id: json['id'],
         ticketNumber: json['ticket_number'],
         subject: json['subject'],
         message: json['message'],
         priority: json['priority'],
         status: json['status'],
         category: json['category'],
         assignedTo: json['assigned_to'],
         attachmentPath: json['attachment_path'],
         resolvedAt: json['resolved_at'] != null ? DateTime.tryParse(json['resolved_at']) : null,
         createdAt: DateTime.parse(json['created_at']),
         updatedAt: DateTime.parse(json['updated_at'])
     );
   }
}