import 'package:asset_steward_app/features/assets/data/models/asset_label_response.dart';
import 'package:asset_steward_app/features/assets/data/models/asset_model.dart';
import 'package:asset_steward_app/features/assets/data/models/assignment_model.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AssetsRemoteDS {
  AssetsRemoteDS(this._dio);

  final Dio _dio;

  Future<AssetModel> getAsset(int id) async {
    final response = await _dio.get(Endpoints.asset(id));
    final res = ApiResponse.fromMap<AssetModel>(response.data);

    if (res case ApiResponse(success: true, data: final AssetModel asset)) {
      return asset;
    } else {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }

  Future<List<AssetModel>> getAssets() async {
    final response = await _dio.get(Endpoints.assets);
    final res = ApiResponse.fromMap<List<AssetModel>>(response.data);

    if (res case ApiResponse(success: true, data: final List<AssetModel> data)) {
      return data;
    } else {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }

  Future<AssetModel> createAsset(QMap data) async {
    final response = await _dio.post(Endpoints.assets, data: data);
    final res = ApiResponse.fromMap<AssetModel>(response.data);

    if (res case ApiResponse(success: true, data: final AssetModel asset)) {
      return asset;
    } else {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }

  Future<AssetModel> updateAsset(int id, QMap data) async {
    final response = await _dio.put(Endpoints.asset(id), data: data);
    final res = ApiResponse.fromMap<AssetModel>(response.data);

    if (res case ApiResponse(success: true, data: final AssetModel asset)) {
      return asset;
    } else {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }

  Future<void> deleteAsset(int id) async {
    final response = await _dio.delete(Endpoints.asset(id));
    final res = ApiResponse.fromMap(response.data);
    if (!res.success) {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }

  Future<void> approveAsset(int id) async {
    final response = await _dio.put(Endpoints.assetApprove(id));
    final res = ApiResponse.fromMap(response.data);
    if (!res.success) {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }

  Future<void> transferAsset(QMap data) async {
    final response = await _dio.post(Endpoints.assetTransfer, data: data);
    final res = ApiResponse.fromMap(response.data);
    if (!res.success) {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }

  Future<void> assignAsset(QMap data) async {
    final response = await _dio.post(Endpoints.assetAssign, data: data);
    final res = ApiResponse.fromMap(response.data);
    if (!res.success) {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }

  Future<List<AssetLabelResponse>> getAssetLabels() async {
    final response = await _dio.get(Endpoints.assetLabels);
    final res = ApiResponse.fromMap<List<AssetLabelResponse>>(response.data);

    if (res case ApiResponse(success: true, data: final List<AssetLabelResponse> data)) {
      return data;
    } else {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }

  Future<List<AssignmentModel>> getAssetAssignments([String? status]) async {
    final response = await _dio.get(
      Endpoints.assetAssignments,
      queryParameters: status != null ? {'status': status} : null,
    );
    final res = ApiResponse.fromMap<List<AssignmentModel>>(response.data);

    if (res case ApiResponse(success: true, data: final List<AssignmentModel> data)) {
      return data;
    } else {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }
}
