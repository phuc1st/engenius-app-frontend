class UserProfileResponse {
  final String id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final DateTime dob;
  final String city;
  final String? avatar;

  UserProfileResponse({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.city,
    this.avatar,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) {
    return UserProfileResponse(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      dob: DateTime.parse(json['dob'] as String),
      city: json['city'],
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'dob': dob,
      'city': city,
      'avatar': avatar,
    };
  }
}
