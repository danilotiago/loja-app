class UserLogged {
  int id;
  String fullname;
  String email;
  String address;

  UserLogged.fromMap(Map<String, dynamic> userData) {
    this.id       = userData["id"];
    this.fullname = userData["fullname"];
    this.email    = userData["email"];
    this.address  = userData["address"];
  }

  @override
  String toString() {
    return "[id: $id; fullname: $fullname; email: $email; address: $address]";
  }
}