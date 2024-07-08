class CustomError {
  final String? message;

  CustomError({
    this.message,
  });

  factory CustomError.fromJson(Map<String, dynamic> json) => CustomError(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
