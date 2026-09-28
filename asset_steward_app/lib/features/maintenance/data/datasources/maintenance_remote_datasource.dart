import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../main.export.dart';
import '../models/maintenance_response.dart';

@lazySingleton
class MaintenanceRemoteDS {
  MaintenanceRemoteDS(this._dio);

  final Dio _dio;

  Future<List<MaintenanceResponse>> getAllMaintenance() async {
    final response = await _dio.get(Endpoints.maintenance);

    final res = ApiResponse.fromMap<List<MaintenanceResponse>>(response.data);

    if (res case ApiResponse(success: true, data: final List<MaintenanceResponse> data)) {
      return data;
    } else {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }

  Future<MaintenanceResponse> startMaintenance(QMap data) async {
    final response = await _dio.post(Endpoints.startMaintenance, data: data);

    final res = ApiResponse.fromMap<MaintenanceResponse>(response.data);

    if (res case ApiResponse(success: true, data: final MaintenanceResponse data)) {
      return data;
    } else {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }

  Future<MaintenanceResponse> completeMaintenance(int id) async {
    final response = await _dio.put(Endpoints.completeMaintenance(id));

    final res = ApiResponse.fromMap<MaintenanceResponse>(response.data);

    if (res case ApiResponse(success: true, data: final MaintenanceResponse data)) {
      return data;
    } else {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }
}
