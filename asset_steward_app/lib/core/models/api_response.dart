import 'package:dart_mappable/dart_mappable.dart';

part 'api_response.mapper.dart';

@MappableClass()
class ApiResponse<T> with ApiResponseMappable<T> {
  final bool success;
  final int status;
  final String message;
  final T? data;

  const ApiResponse({
    required this.success,
    required this.status,
    this.message = '',
    this.data,
  });

  static const fromMap = ApiResponseMapper.fromMap;
  static const fromJson = ApiResponseMapper.fromJson;
}
