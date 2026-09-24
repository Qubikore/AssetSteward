import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../main.export.dart';
import '../models/asset_utilization.dart';
import '../models/dashboard_metrics.dart';

@lazySingleton
class HomeRemoteDS {
  HomeRemoteDS(this._dio);

  final Dio _dio;

  Future<DashboardMetrics> getMetrics() async {
    final response = await _dio.get(Endpoints.dashboardMetrics);
    DashboardMetricsMapper.ensureInitialized();
    final res = ApiResponse.fromMap<DashboardMetrics>(response.data);

    if (res case ApiResponse(success: true, data: final DashboardMetrics data)) {
      return data;
    } else {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }

  Future<List<AssetUtilization>> getUtilization() async {
    final response = await _dio.get(Endpoints.dashboardUtilization);
    AssetUtilizationMapper.ensureInitialized();
    final res = ApiResponse.fromMap<List<AssetUtilization>>(response.data);

    if (res case ApiResponse(success: true, data: final List<AssetUtilization> data)) {
      return data;
    } else {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }
}
