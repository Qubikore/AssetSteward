import 'package:asset_steward_app/features/assets/data/models/asset_label_response.dart';
import 'package:asset_steward_app/features/assets/data/models/asset_model.dart';
import 'package:asset_steward_app/features/assets/data/models/assignment_model.dart';
import 'package:asset_steward_app/features/assets/data/models/asset_history_model.dart';
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

  Future<List<AssetModel>> getAssets([Map<String, dynamic>? queries]) async {
    final response = await _dio.get(
      Endpoints.assets,
      queryParameters: queries,
    );
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
  Future<void> rejectAsset(int id) async {
    final response = await _dio.put(Endpoints.assetReject(id));
    final res = ApiResponse.fromMap(response.data);
    if (!res.success) {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }

  Future<void> returnAsset(QMap data) async {
    final response = await _dio.post(Endpoints.assetReturn, data: data);
    final res = ApiResponse.fromMap(response.data);
    if (!res.success) {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }

  Future<List<AssetHistoryModel>> getAssetHistory(int id) async {
    final response = await _dio.get(Endpoints.assetHistory(id));
    final res = ApiResponse.fromMap<List<AssetHistoryModel>>(response.data);

    if (res case ApiResponse(success: true, data: final List<AssetHistoryModel> data)) {
      return data;
    } else {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }

  Future<List<AssignmentModel>> getAssignmentsByAssetId(int id) async {
    final response = await _dio.get(Endpoints.assetAssignmentsForAsset(id));
    final res = ApiResponse.fromMap<List<AssignmentModel>>(response.data);

    if (res case ApiResponse(success: true, data: final List<AssignmentModel> data)) {
      return data;
    } else {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }

  Future<AssetLabelResponse> getAssetLabelById(int id) async {
    final response = await _dio.get(Endpoints.assetLabel(id));
    final res = ApiResponse.fromMap<AssetLabelResponse>(response.data);

    if (res case ApiResponse(success: true, data: final AssetLabelResponse data)) {
      return data;
    } else {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }

  Future<AssignmentModel> getAssignmentById(int id) async {
    final response = await _dio.get(Endpoints.assetAssignment(id));
    final res = ApiResponse.fromMap<AssignmentModel>(response.data);

    if (res case ApiResponse(success: true, data: final AssignmentModel data)) {
      return data;
    } else {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }

  Future<List<AssignmentModel>> getMyAssignments([String? status]) async {
    final response = await _dio.get(
      Endpoints.myAssetAssignments,
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
