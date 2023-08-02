// class LoginModel {
//     String status;
//     String token;
//     Data data;

//     LoginModel({
//         required this.status,
//         required this.token,
//         required this.data,
//     });

//     factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
//         status: json["status"],
//         token: json["token"],
//         data: Data.fromJson(json["data"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "token": token,
//         "data": data.toJson(),
//     };
// }

// class Data {
//     String email;
//     String firstName;
//     String lastName;
//     String mobile;
//     String photo;

//     Data({
//         required this.email,
//         required this.firstName,
//         required this.lastName,
//         required this.mobile,
//         required this.photo,
//     });

//     factory Data.fromJson(Map<String, dynamic> json) => Data(
//         email: json["email"],
//         firstName: json["firstName"],
//         lastName: json["lastName"],
//         mobile: json["mobile"],
//         photo: json["photo"],
//     );

//     Map<String, dynamic> toJson() => {
//         "email": email,
//         "firstName": firstName,
//         "lastName": lastName,
//         "mobile": mobile,
//         "photo": photo,
//     };
// }
class LoginModel {
  String? status;
  String? token;
  Data? data;

  LoginModel({this.status, this.token, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['token'] = this.token;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? email;
  String? firstName;
  String? lastName;
  String? mobile;
  String? photo;

  Data({this.email, this.firstName, this.lastName, this.mobile, this.photo});

  Data.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobile = json['mobile'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['mobile'] = this.mobile;
    data['photo'] = this.photo;
    return data;
  }
}