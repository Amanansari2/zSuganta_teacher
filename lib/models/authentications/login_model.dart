class UserModel {
  final int id;
  final String email;
  final String role;
  final String phone;
  final String? address;
  final String? city;
  final String? state;
  final int? pinCode;
  final String? country;
  final String? displayName;
  final String firstName;
  final String lastName;
  final String? secondaryNumber;
  final String? dateOfBirth;
  final int? gender;
  final String? bio;
  final String? area;
  final String? profileImage;
  final bool isActive;
  final String verificationStatus;

  UserModel({
    required this.id,
    required this.email,
    required this.role,
    required this.phone,
    this.address,
    this.city,
    this.state,
    this.pinCode,
    this.country,
    this.displayName,
    required this.firstName,
    required this.lastName,
    this.secondaryNumber,
    this.dateOfBirth,
    this.gender,
    this.bio,
    this.area,
    this.profileImage,
    required this.isActive,
    required this.verificationStatus,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    email: json['email'] ?? '',
    role: json['role'] ?? '',
    phone: json['phone']?.toString() ?? '',
    address: json['address'],
    city: json['city'],
    state: json['state'],
    pinCode: json['pincode'] != null ? int.tryParse(json['pincode'].toString()) : null,
    country: json['country'],
    displayName: json['display_name'],
    firstName: json['first_name'],
    lastName: json['last_name'],
    secondaryNumber: json['secondary_no']?.toString(),
    dateOfBirth: json['dob'],
    gender: json['gender'],
    bio: json['bio'],
    area: json['area'],
    profileImage: json['profile_image'],
    isActive: json['is_active'],
    verificationStatus: json['verification_status'],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "role": role,
    "phone": phone,
    "address": address,
    "city": city,
    "state": state,
    "pincode": pinCode,
    "country": country,
    "display_name": displayName,
    "first_name": firstName,
    "last_name": lastName,
    "secondary_no": secondaryNumber,
    "dob": dateOfBirth,
    "gender": gender,
    "bio": bio,
    "area": area,
    "profile_image": profileImage,
    "is_active": isActive,
    "verification_status": verificationStatus,
  };

  @override
  String toString() {
    return '''
        
        id: $id, 
        email: $email, 
        role: $role,
        phone : $phone,
        address : $address,
        city : $city,
        state : $state,
        pincode : $pinCode,
        country : $country,
        display_name: $displayName,
        first_name: $firstName,
        last_name: $lastName,
        secondary_no: $secondaryNumber,
        dob: $dateOfBirth,
        gender: $gender,
        bio: $bio,
        area: $area,
        profile_image : $profileImage,
        is_active : $isActive,
        verification_status : $verificationStatus,
          ''';
  }
}
