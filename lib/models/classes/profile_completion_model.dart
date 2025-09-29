class ProfileCompletionModel {
  final int percentage;
  final Map<String, CompletionDetail> completionDetails;

  ProfileCompletionModel({
    required this.percentage,
    required this.completionDetails,
  });

  factory ProfileCompletionModel.fromJson(Map<String, dynamic> json) {
    return ProfileCompletionModel(
      percentage: json['percentage'] ?? 0,
      completionDetails: (json['completion_details'] as Map<String, dynamic>).map(
            (key, value) => MapEntry(key, CompletionDetail.fromJson(value)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'percentage': percentage,
      'completion_details': completionDetails.map(
            (key, value) => MapEntry(key, value.toJson()),
      ),
    };
  }


  List<CompletionDetail> getIncompleteFields() {
    return completionDetails.values.where((e) => !e.completed).toList();
  }
}

class CompletionDetail {
  final String label;
  final bool completed;

  CompletionDetail({
    required this.label,
    required this.completed,
  });

  factory CompletionDetail.fromJson(Map<String, dynamic> json) {
    return CompletionDetail(
      label: json['label'] ?? '',
      completed: json['completed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'completed': completed,
    };
  }
}
