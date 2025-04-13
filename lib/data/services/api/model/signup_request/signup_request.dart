class SignupRequest {
  final String username;
  final String password;
  final String email;
  final String firstName;
  final String lastName;
  final String dob; // formatted as dd/MM/yyyy
  final String city;

  SignupRequest({
    required this.username,
    required this.password,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.city,
  });

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
    'email': email,
    'firstName': firstName,
    'lastName': lastName,
    'dob': dob,
    'city': city,
  };
}