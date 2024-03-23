class ServiceResult {
  bool success;
  String message;
  dynamic data;

  ServiceResult({required this.success, required this.message, this.data});

  factory ServiceResult.fromJson(Map<String, dynamic> json) {
    return ServiceResult(
      success: json['success'],
      message: json['message'],
      data: json['data'],
    );
  }
}
