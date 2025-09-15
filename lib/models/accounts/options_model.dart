class FilterOption {
  final int id;
  final String label;

  FilterOption({required this.id, required this.label});

  factory FilterOption.fromJson(Map<String, dynamic> json) {
    return FilterOption(
      id: json['id'],
      label: json['label'],
    );
  }
}


class SubjectOptions{
  final int id;
  final String name;

  SubjectOptions({required this.id, required this.name});

  factory SubjectOptions.fromJson(Map<String, dynamic> json){
    return SubjectOptions(
        id: json['id'],
        name: json['name']
    );
  }
}