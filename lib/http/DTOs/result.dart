class ServiceResult {
  bool success;
  String message;

  ServiceResult({required this.success, required this.message});

  factory ServiceResult.fromJson(Map<String, dynamic> json) {
    return ServiceResult(success: json['success'], message: json['message']);
  }
}
