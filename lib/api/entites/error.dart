class ApiError {
  String response;
  String error;

  ApiError({this.response, this.error});

  ApiError.fromJson(Map<String, dynamic> json) {
    response = json['Response'];
    error = json['Error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Response'] = this.response;
    data['Error'] = this.error;
    return data;
  }
}
