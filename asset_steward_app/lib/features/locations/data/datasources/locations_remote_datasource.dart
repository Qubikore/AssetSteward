import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../main.export.dart';
import '../models/location_model.dart';

@lazySingleton
class LocationsRemoteDS {
  LocationsRemoteDS(this._dio);

  final Dio _dio;

  Future<List<LocationModel>> getLocations() async {
    final response = await _dio.get(Endpoints.locations);
    LocationModelMapper.ensureInitialized();
    final res = ApiResponse.fromMap<List<LocationModel>>(response.data);

    if (res case ApiResponse(success: true, data: final List<LocationModel> data)) {
      return data;
    } else {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }

  Future<LocationModel> createLocation(QMap data) async {
    final response = await _dio.post(Endpoints.locations, data: data);
    LocationModelMapper.ensureInitialized();
    final res = ApiResponse.fromMap<LocationModel>(response.data);

    if (res case ApiResponse(success: true, data: final LocationModel location)) {
      return location;
    } else {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }

  Future<LocationModel> updateLocation(int id, QMap data) async {
    final response = await _dio.put('${Endpoints.locations}/$id', data: data);
    LocationModelMapper.ensureInitialized();
    final res = ApiResponse.fromMap<LocationModel>(response.data);

    if (res case ApiResponse(success: true, data: final LocationModel location)) {
      return location;
    } else {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }

  Future<void> deleteLocation(int id) async {
    final response = await _dio.delete('${Endpoints.locations}/$id');
    final res = ApiResponse.fromMap<void>(response.data);

    if (!res.success) {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }
}
