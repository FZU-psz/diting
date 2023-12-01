
class User {
  int userId;
  String name;
  String telephone;
  String avatar ;


  User({
    this.userId=0,
    this.name='diting',
    this.avatar= '',
    this.telephone='',
  });

  factory User.fromJson(Map<String, dynamic> json) {


    return User(
      userId: json['id'],
      name: json['name'],
      telephone: json['telephone'],
      avatar:  json['avatar']
    );
  }
}
