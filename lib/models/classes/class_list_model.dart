class ClassModelList {
  final List<ClassList> data;
  final Pagination pagination;

  ClassModelList({
    required this.data,
    required this.pagination,
  });

  factory ClassModelList.fromJson(Map<String, dynamic> json) {
    return ClassModelList(
      data: (json['sessions'] as List ?? [])
          .map((e) => ClassList.fromJson(e))
          .toList(),
      pagination: Pagination.fromJson(json['pagination']),
    );
  }
}

class ClassList {
  final int id;
  final String title;
  final String? description;
  final String price;
  final int maxStudents;
  final String status;
  final DateTime date;
  final String time;
  final int duration;
  final String type;
  final String? location;
  final int? instituteId;
  final Subject subject;
  final Teacher teacher;
  final Exam exam;
  final ExamCategory examCategory;

  ClassList({
    required this.id,
    required this.title,
    this.description,
    required this.price,
    required this.maxStudents,
    required this.status,
    required this.date,
    required this.time,
    required this.duration,
    required this.type,
    this.location,
    this.instituteId,
    required this.subject,
    required this.teacher,
    required this.exam,
    required this.examCategory,
  });

  factory ClassList.fromJson(Map<String, dynamic> json) {
    return ClassList(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? '',
      price: json['price'],
      maxStudents: json['max_students'],
      status: json['status'],
      date: DateTime.parse(json['date']),
      time: json['time'],
      duration: json['duration'],
      type: json['type'],
      location: json['location'] ?? '',
      instituteId: json['institute_id'],
      subject: Subject.fromJson(json['subject']),
      teacher: Teacher.fromJson(json['teacher']),
      exam: Exam.fromJson(json['exam']),
      examCategory: ExamCategory.fromJson(json['exam_category']),
    );
  }
}

class Subject {
  final int id;
  final String name;

  Subject({required this.id, required this.name});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Teacher {
  final int id;
  final String name;

  Teacher({required this.id, required this.name});

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Exam {
  final int id;
  final String name;

  Exam({required this.id, required this.name});

  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
      id: json['id'],
      name: json['name'],
    );
  }
}

class ExamCategory {
  final int id;
  final String name;

  ExamCategory({required this.id, required this.name});

  factory ExamCategory.fromJson(Map<String, dynamic> json) {
    return ExamCategory(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Pagination {
  final int currentPage;
  final int lastPage;

  Pagination({
    required this.currentPage,
    required this.lastPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['current_page'],
      lastPage: json['last_page'],
    );
  }
}
