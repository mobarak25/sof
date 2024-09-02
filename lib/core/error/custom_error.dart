class CustomError {
  final String? message;
  final String? error;

  CustomError({
    this.message,
    this.error,
  });

  factory CustomError.fromJson(Map<String, dynamic> json) => CustomError(
        message: json["message"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "error": error,
      };
}
