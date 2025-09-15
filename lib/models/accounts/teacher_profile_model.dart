class TeacherProfileModel{
  final int? highestQualification;
  final String? institutionName;
  final int? fieldOfStudy;
  final int? graduationYear;
  final int? teachingExperienceYears;
  final int? hourlyRate;
  final int? monthlyRate;
  final int? teachingMode;
  final int? travelRadius;
  final String? teachingPhilosophy;
  final List<int>? subjectsTaught;
  final int? availabilityStatus;

  TeacherProfileModel({
   this.highestQualification,
   this.institutionName,
   this.fieldOfStudy,
   this.graduationYear,
   this.teachingExperienceYears,
   this.hourlyRate,
   this.monthlyRate,
   this.teachingMode,
   this.travelRadius,
   this.teachingPhilosophy,
   this.subjectsTaught,
   this.availabilityStatus
});

  factory TeacherProfileModel.fromJson(Map<String, dynamic> json) => TeacherProfileModel(
    highestQualification: int.tryParse(json['highest_qualification']?.toString() ?? ''),
    institutionName: json['institution_name'] as String?,
    fieldOfStudy: int.tryParse(json['field_of_study']?.toString() ?? ''),
    graduationYear: int.tryParse(json['graduation_year']?.toString() ?? ''),
    teachingExperienceYears: int.tryParse(json['teaching_experience_years']?.toString() ?? ''),
    hourlyRate: int.tryParse(json['hourly_rate_id']?.toString() ?? ''),
    monthlyRate: int.tryParse(json['monthly_rate_id']?.toString() ?? ''),
    teachingMode: int.tryParse(json['teaching_mode_id']?.toString() ?? ''),
    travelRadius: int.tryParse(json['travel_radius_km_id']?.toString() ?? ''),
    teachingPhilosophy: json['teaching_philosophy'] as String?,
    subjectsTaught: (json['subjects_taught'] as List<dynamic>?)
        ?.map((e) => int.tryParse(e.toString()) ?? 0)
        .toList(),
    availabilityStatus: int.tryParse(json['availability_status_id']?.toString() ?? ''),
  );


  Map<String, dynamic> toJson() => {
    "highest_qualification": highestQualification,
    "institution_name": institutionName,
    "field_of_study": fieldOfStudy,
    "graduation_year": graduationYear,
    "teaching_experience_years": teachingExperienceYears,
    "hourly_rate_id": hourlyRate,
    "monthly_rate_id": monthlyRate,
    "teaching_mode_id": teachingMode,
    "travel_radius_km_id": travelRadius,
    "teaching_philosophy": teachingPhilosophy,
    "subjects_taught": subjectsTaught,
    "availability_status_id": availabilityStatus
  };

  @override
  String toString() {

    return '''
    highest_qualification: $highestQualification,
    institution_name: $institutionName,
    field_of_study: $fieldOfStudy,
    graduation_year: $graduationYear,
    teaching_experience_years: $teachingExperienceYears,
    hourly_rate_id: $hourlyRate,
    monthly_rate_id: $monthlyRate,
    teaching_mode_id: $teachingMode,
    travel_radius_km_id: $travelRadius,
    teaching_philosophy: $teachingPhilosophy,
    subjects_taught: $subjectsTaught,
    availability_status_id: $availabilityStatus
     ''';
  }
  }

