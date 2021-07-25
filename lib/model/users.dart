class Users {
  final String id;
  final String name;
  final String email;
  final String number;
  Users({this.id, this.name, this.email, this.number});
  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      id: map["id"],
      name: map["name"],
      email: map["email"],
      number: map["number"],
    );
  }
}
