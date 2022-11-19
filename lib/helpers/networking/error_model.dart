class TMDBError {
  final bool success;
  final int? statusCode; // status_code
  final String? statusMessage; // status_message
  final List<String> errors;

  TMDBError(this.success, this.statusCode, this.statusMessage, this.errors);

  TMDBError.fromJson(Map<String, dynamic> json)
      : success = json['success'],
        statusCode = json['status_code'],
        statusMessage = json['status_message'].toString(),
        errors = json['errors'];

  Map<String, dynamic> toJson() => {
        'success': success,
        'status_code': statusCode,
        'status_message': statusMessage
      };
}
