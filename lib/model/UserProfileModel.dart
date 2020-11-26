class UserProfileModel {
  String id;
  String name;
  String email;
  String contactNo;

  UserProfileModel(
      {this.id, this.name, this.email,  this.contactNo});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['Name'];
    email = json['Email'];
    contactNo = json['contact_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Name'] = this.name;
    data['Email'] = this.email;
    data['contact_no'] = this.contactNo;
    return data;
  }
}