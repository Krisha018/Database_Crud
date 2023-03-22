class User {
  final String UserName;
  final String UserPassword;

  const User({
    required this.UserName,
    required this.UserPassword,
  });

Map<String, dynamic> toMap() {
  return {
    'UserName': UserName,
    'UserPassword': UserPassword,
  };
}

// Implement toString to make it easier to see information about
// each dog when using the print statement.
@override
String toString() {
  return 'User{UserName: $UserName, UserPassword: $UserPassword}';
}
}