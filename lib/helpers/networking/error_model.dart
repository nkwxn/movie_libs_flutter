import 'dart:convert';

class TMDBError {
  final String success;
  final String statusCode; // status_code
  final String statusMessage; // status_message

  TMDBError(this.success, this.statusCode, this.statusMessage);

  TMDBError.fromJson(Map<String, dynamic> json)
      : success = json['success'].toString(),
        statusCode = json['status_code'].toString(),
        statusMessage = json['status_message'].toString();

  Map<String, dynamic> toJson() => {
    'success': success,
    'status_code': statusCode,
    'status_message': statusMessage
  };
}
