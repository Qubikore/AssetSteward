import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../main.export.dart';
import '../models/maintenance_model.dart';

@lazySingleton
class MaintenanceRemoteDS {
  MaintenanceRemoteDS(this._dio);

  final Dio _dio;

  Future<List<MaintenanceModel>> getAllMaintenance() async {
    final response = await _dio.get(Endpoints.maintenance);

    final res = ApiResponse.fromMap<List<MaintenanceModel>>(response.data);

    if (res case ApiResponse(success: true, data: final List<MaintenanceModel> data)) {
      return data;
    } else {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }

  Future<MaintenanceModel> startMaintenance(QMap data) async {
    final response = await _dio.post(Endpoints.startMaintenance, data: data);

    final res = ApiResponse.fromMap<MaintenanceModel>(response.data);

    if (res case ApiResponse(success: true, data: final MaintenanceModel data)) {
      return data;
    } else {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }

  Future<MaintenanceModel> completeMaintenance(int id) async {
    final response = await _dio.put(Endpoints.completeMaintenance(id));

    final res = ApiResponse.fromMap<MaintenanceModel>(response.data);

    if (res case ApiResponse(success: true, data: final MaintenanceModel data)) {
      return data;
    } else {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }
}
