class ErrorMSG {
  bool success;
  String message;

  ErrorMSG({required this.success, required this.message});

  factory ErrorMSG.fromJson(Map<String, dynamic> json) {
    return ErrorMSG(
      success: json["success"],
      message: json["message"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "message": message,
    };
  }
}