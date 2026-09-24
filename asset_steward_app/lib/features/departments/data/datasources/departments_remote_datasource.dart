import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../main.export.dart';
import '../models/department_model.dart';

@lazySingleton
class DepartmentsRemoteDS {
  DepartmentsRemoteDS(this._dio);

  final Dio _dio;

  Future<List<DepartmentModel>> getDepartments() async {
    final response = await _dio.get(Endpoints.departments);
    DepartmentModelMapper.ensureInitialized();
    final res = ApiResponse.fromMap<List<DepartmentModel>>(response.data);

    if (res case ApiResponse(success: true, data: final List<DepartmentModel> data)) {
      return data;
    } else {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }

  Future<DepartmentModel> createDepartment(QMap data) async {
    final response = await _dio.post(Endpoints.departments, data: data);
    DepartmentModelMapper.ensureInitialized();
    final res = ApiResponse.fromMap<DepartmentModel>(response.data);

    if (res case ApiResponse(success: true, data: final DepartmentModel department)) {
      return department;
    } else {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }

  Future<DepartmentModel> updateDepartment(int id, QMap data) async {
    final response = await _dio.put('${Endpoints.departments}/$id', data: data);
    DepartmentModelMapper.ensureInitialized();
    final res = ApiResponse.fromMap<DepartmentModel>(response.data);

    if (res case ApiResponse(success: true, data: final DepartmentModel department)) {
      return department;
    } else {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }

  Future<void> deleteDepartment(int id) async {
    final response = await _dio.delete('${Endpoints.departments}/$id');
    final res = ApiResponse.fromMap<void>(response.data);

    if (!res.success) {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }
}
