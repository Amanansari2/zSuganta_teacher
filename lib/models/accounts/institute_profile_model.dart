class InstituteProfileModel{
  final String? instituteName;
  final int? instituteTypeId;
  final int? instituteCategoryId;
  final int? establishmentYearId;
  final String? principalName;
  final String? principalPhone;
  final int? totalStudentId;
  final int? totalTeacherId;
  final String? instituteDescription;

  InstituteProfileModel({
   this.instituteName,
   this.instituteTypeId,
   this.instituteCategoryId,
   this.establishmentYearId,
   this.principalName,
   this.principalPhone,
   this.totalStudentId,
   this.totalTeacherId,
   this.instituteDescription

});

  factory InstituteProfileModel.fromJson(Map<String, dynamic> json) => InstituteProfileModel(
    instituteName: json['institute_name'] as String?,
    instituteTypeId: int.tryParse(json['institute_type_id']?.toString() ?? ''),
    instituteCategoryId: int.tryParse(json['institute_category_id']?.toString() ?? ''),
    establishmentYearId: int.tryParse(json['establishment_year_id']?.toString() ?? ''),
    principalName: json['principal_name'] as String?,
    principalPhone: json['principal_phone'] as String?,
    totalStudentId: int.tryParse(json['total_students_id']?.toString() ?? ''),
    totalTeacherId: int.tryParse(json['total_teachers_id']?.toString() ?? ''),
    instituteDescription: json['institute_description'] as String?
  );

  Map<String, dynamic> toJson() => {
    "institute_name": instituteName,
    "institute_type_id": instituteTypeId,
    "institute_category_id": instituteCategoryId,
    "establishment_year_id": establishmentYearId,
    "principal_name": principalName,
    "principal_phone": principalPhone,
    "total_students_id": totalStudentId,
    "total_teachers_id": totalTeacherId,
    "institute_description": instituteDescription
  };

  @override
  String toString(){
    return '''
            institute_name: $instituteName,
            institute_type_id: $instituteTypeId,
            institute_category_id: $instituteCategoryId,
            establishment_year_id: $establishmentYearId,
            principal_name: $principalName,
            principal_phone: $principalPhone,
            total_students_id: $totalStudentId,
            total_teachers_id: $totalTeacherId,
            institute_description: $instituteDescription
    ''';
  }
}