class UserModel {
  final int id;
  final String email;
  final String name;
  final String role;
  final String phone;
  final String? address;
  final String? city;
  final String? state;
  final int? pinCode;
  final String? country;
  final String? profileImage;
  final bool isActive;
  final String verificationStatus;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    required this.phone,
    this.address,
    this.city,
    this.state,
    this.pinCode,
    this.country,
    this.profileImage,
    required this.isActive,
    required this.verificationStatus,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    email: json['email'],
    name: json['name'],
    role: json['role'],
    phone: json['phone'],
    address: json['address'],
    city: json['city'],
    state: json['state'],
    pinCode: json['pincode'],
    country: json['country'],
    profileImage: json['profile_image'],
    isActive: json['is_active'],
    verificationStatus: json['verification_status'],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "name": name,
    "role": role,
    "phone": phone,
    "address": address,
    "city": city,
    "state": state,
    "pincode": pinCode,
    "country": country,
    "profile_image": profileImage,
    "is_active": isActive,
    "verification_status": verificationStatus,
  };

  @override
  String toString() {
    return '''
        
        id: $id, 
        name: $name, 
        email: $email, 
        role: $role,
        phone : $phone,
        address : $address,
        city : $city,
        state : $state,
        pincode : $pinCode,
        country : $country,
        profile_image : $profileImage,
        is_active : $isActive,
        verification_status : $verificationStatus,
          ''';
  }
}
