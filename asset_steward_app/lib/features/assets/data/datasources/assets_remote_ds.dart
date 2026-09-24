import 'package:asset_steward_app/features/assets/data/models/asset_model.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AssetsRemoteDS {
  AssetsRemoteDS(this._dio);

  final Dio _dio;

  Future<List<AssetModel>> getAssets() async {
    final response = await _dio.get(Endpoints.assets);
    AssetModelMapper.ensureInitialized();
    final res = ApiResponse.fromMap<List<AssetModel>>(response.data);

    if (res case ApiResponse(success: true, data: final List<AssetModel> data)) {
      return data;
    } else {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }

  Future<AssetModel> createAsset(QMap data) async {
    final response = await _dio.post(Endpoints.assets, data: data);
    AssetModelMapper.ensureInitialized();
    final res = ApiResponse.fromMap<AssetModel>(response.data);

    if (res case ApiResponse(success: true, data: final AssetModel asset)) {
      return asset;
    } else {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }
}
