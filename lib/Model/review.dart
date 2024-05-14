class ReviewModel {
  String? id;
  String? hospitalName;
  String? review;

  ReviewModel({
    this.id,
    this.hospitalName,
    this.review,
  });

  ReviewModel.fromJson(Map<String, dynamic> json) {
    id = json['fullName'];
    hospitalName = json['hospitalName'];
    review = json['review'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['hospitalName'] = hospitalName;
    data['review'] = review;
    return data;
  }
}
