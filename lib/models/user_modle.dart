class UserModle {
  String id;
  String name;
  String email;
  UserModle({
    required this.id,
    required this.name,
    required this.email,
  });

  UserModle.fromjson(Map<String, dynamic> json)
      : this(
          id: json["id"],
          name: json["name"],
          email: json["email"],
        );

  Map<String, dynamic> tojson() => {
        "id": id,
        "name": name,
        "email": email,
      };
}
