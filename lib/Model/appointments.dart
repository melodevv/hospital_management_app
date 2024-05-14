class AppointmentModel {
  String? id;
  String? reason;
  String? dateTime;

  AppointmentModel({
    this.id,
    this.reason,
    this.dateTime,
  });

  AppointmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reason = json['reason'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['reason'] = reason;
    data['dateTime'] = dateTime;
    return data;
  }
}
