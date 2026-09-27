import 'package:dart_mappable/dart_mappable.dart';

part 'assignment_response.mapper.dart';

@MappableClass(caseStyle: CaseStyle.camelCase)
class AssignmentResponse with AssignmentResponseMappable {
  static const fromMap = AssignmentResponseMapper.fromMap;
  static const fromJson = AssignmentResponseMapper.fromJson;

  final int id;
  final int assetId;
  final String assetName;
  final String assetCode;
  final int assignedToUserId;
  final String assignedToEmail;
  final int assignedByUserId;
  final String assignedByEmail;
  final String assignedAt;
  final String? returnedAt;

  const AssignmentResponse({
    required this.id,
    required this.assetId,
    required this.assetName,
    required this.assetCode,
    required this.assignedToUserId,
    required this.assignedToEmail,
    required this.assignedByUserId,
    required this.assignedByEmail,
    required this.assignedAt,
    this.returnedAt,
  });
}
