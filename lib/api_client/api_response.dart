class APIResponse<T> {
  APIResponse({this.data, this.success, this.timestamp, this.message});

  dynamic data;
  bool? success;

  String? timestamp;
  String? message;

  factory APIResponse.fromJson(Map<String, dynamic> json) => APIResponse(
        data: json['data'] ?? [],
        success: json['success'],
        timestamp: json['timestamp'],
        message: json['message'],
      );

  Map<String, dynamic> toObject() {
    return Map<String, dynamic>.from(data);
  }
}
