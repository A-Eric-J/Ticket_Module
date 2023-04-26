/// Every ticket has [Status] and they can be change
class Status {
  int? id;
  String? label;
  String? textColor;
  String? backgroundColor;

  Status.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['app_label'];
    textColor = json['app_color'];
    backgroundColor = json['app_background_color'];
  }
}
