import 'package:z_tutor_suganta/utils/helpers/helper_function.dart';

class ClassDetailedModel {
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
  final String? notes;
  final SubjectDetailed subject;
  final TeacherDetailed teacher;
  final ExamDetailed exam;
  final ExamCategoryDetailed examCategory;
  final List<Enrollment>? enrollments;
  final bool isCancelled;
  final bool isCompleted;

  ClassDetailedModel({
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
    this.notes,
    required this.subject,
    required this.teacher,
    required this.exam,
    required this.examCategory,
    this.enrollments,
    required this.isCancelled,
    required this.isCompleted,

  });

  factory ClassDetailedModel.fromJson(Map<String, dynamic> json) {
    return ClassDetailedModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      maxStudents: json['max_students'],
      status: json['status'],
      date: DateTime.parse(json['date']),
      time: json['time'],
      duration: json['duration'],
      type: json['type'],
      location: json['location'],
      instituteId: json['institute_id'],
      notes: json['notes'],
      subject: SubjectDetailed.fromJson(json['subject']),
      teacher: TeacherDetailed.fromJson(json['teacher']),
      exam: ExamDetailed.fromJson(json['exam']),
      examCategory: ExamCategoryDetailed.fromJson(json['exam_category']),
      enrollments: (json['enrollments'] as List<dynamic>?)
          ?.map((e) => Enrollment.fromJson(e))
          .toList(),
      isCancelled: HelperFunction.parseBool(json['is_cancelled']),
      isCompleted: HelperFunction.parseBool(json['is_completed']),

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'max_students': maxStudents,
      'status': status,
      'date': date,
      'time': time,
      'duration': duration,
      'type': type,
      'location': location,
      'institute_id': instituteId,
      'notes': notes,
      'subject': subject.toJson(),
      'teacher': teacher.toJson(),
      'exam': exam.toJson(),
      'exam_category': examCategory.toJson(),
      'enrollments' : enrollments?.map((e) => e.toJson()).toList(),
      'is_cancelled': isCancelled,
      'is_completed': isCompleted,
    };
  }
}

class SubjectDetailed {
  final int id;
  final String name;

  SubjectDetailed({required this.id, required this.name});

  factory SubjectDetailed.fromJson(Map<String, dynamic> json) {
    return SubjectDetailed(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };
}

class TeacherDetailed {
  final int id;
  final String name;

  TeacherDetailed({required this.id, required this.name});

  factory TeacherDetailed.fromJson(Map<String, dynamic> json) {
    return TeacherDetailed(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };
}

class ExamDetailed {
  final int id;
  final String name;

  ExamDetailed({required this.id, required this.name});

  factory ExamDetailed.fromJson(Map<String, dynamic> json) {
    return ExamDetailed(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };
}

class ExamCategoryDetailed {
  final int id;
  final String name;

  ExamCategoryDetailed({required this.id, required this.name});

  factory ExamCategoryDetailed.fromJson(Map<String, dynamic> json) {
    return ExamCategoryDetailed(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };
}

class Enrollment{
  final int id;
  final String firstName;
  final String? lastName;
  final String? profileImage;

  Enrollment({required this.id, required this.firstName,this.lastName,  this.profileImage});

  factory Enrollment.fromJson(Map<String, dynamic> json) {
    return Enrollment(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      profileImage: json['profile_image']
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'first_name': firstName,
    'last_name': lastName,
    'profile_image' : profileImage
  };
}
