import 'dart:convert';

class Tea {
  int? id;
  String? title;
  String? evaluation;

  ///用量
  String? image;
  String? experience;

  ///类型
  String? time;

  Tea(
      {this.id,
      this.title,
      this.evaluation,
      this.image,
      this.experience,
      this.time});

  Tea.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    evaluation = json['evaluation'];
    image = json['image'];
    experience = json['experience'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['evaluation'] = this.evaluation;
    data['image'] = this.image;
    data['experience'] = this.experience;
    data['time'] = this.time;
    return data;
  }
}
