class SessionsModel {
  final int currentPage;
  final int lastPage;
  final List<SessionData> data;

  const SessionsModel({
    required this.currentPage,
    required this.lastPage,
    required this.data,
  });

  factory SessionsModel.fromJson(Map<String, dynamic> json) {
    final sessionsList = json['sessions'] as List<dynamic>? ?? [];
    final pagination = json['pagination'] as Map<String, dynamic>? ?? {};

    return SessionsModel(
      currentPage: pagination['current_page'] ?? 1,
      lastPage: pagination['last_page'] ?? 1,
      data: sessionsList.map((e) => SessionData.fromJson(e)).toList(),
    );
  }
}


class SessionData {
  final int id;
  final String ipAddress;
  final DateTime lastActivity;
  final DateTime createdAt;
  final bool isActive;
  final String deviceType;
  final String deviceName;
  final String location;
  final DateTime loginAt;
  final DateTime? logoutAt;


  const SessionData({
    required this.id,
    required this.ipAddress,
    required this.lastActivity,
    required this.createdAt,
    required this.isActive,
    required this.deviceType,
    required this.deviceName,
    required this.location,
    required this.loginAt,
    this.logoutAt
  });

  factory SessionData.fromJson(Map<String, dynamic> json) {
    return SessionData(
        id: json['id'] ?? 0,
        ipAddress: json['ip_address'] ?? '',
        lastActivity: DateTime.parse(json['last_activity']),
        createdAt: DateTime.parse(json['created_at']),
        isActive: json['is_active'] ?? false,
        deviceType: json['device_type'] ?? '',
        deviceName: json['device_name'] ?? '',
        location: json['location'] ?? '',
        loginAt: DateTime.parse(json['login_at']),
        logoutAt: json['logout_at'] != null ? DateTime.parse(json['logout_at']) : null,
    );
  }
}
