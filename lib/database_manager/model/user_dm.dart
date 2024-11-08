class UserDM {
  static const String collectionName ='users';
  static UserDM? user;
  String id;
  String fullName;
  String userName;
  String email;
  UserDM(
      {required this.id,
      required this.email,
      required this.fullName,
      required this.userName});
  Map<String, dynamic> toFireStor() => {
        'id': id,
        'fullName': fullName,
        'userName': userName,
        'email': email,
      };
  UserDM.fromFireStor(Map<String, dynamic> json)
      : this(
          id: json['id'],
          fullName: json['fullName'],
          userName: json['userName'],
          email: json['email'],
        );
}
