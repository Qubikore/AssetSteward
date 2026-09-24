import 'package:asset_steward_app/features/categories/data/models/category_model.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CategoriesRemoteDS {
  CategoriesRemoteDS(this._dio);

  final Dio _dio;

  Future<List<CategoryModel>> getCategories() async {
    final response = await _dio.get(Endpoints.categories);
    CategoryModelMapper.ensureInitialized();
    final res = ApiResponse.fromMap<List<CategoryModel>>(response.data);

    if (res case ApiResponse(success: true, data: final List<CategoryModel> data)) {
      return data;
    } else {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }

  Future<CategoryModel> createCategory(QMap data) async {
    final response = await _dio.post(Endpoints.categories, data: data);
    CategoryModelMapper.ensureInitialized();
    final res = ApiResponse.fromMap<CategoryModel>(response.data);

    if (res case ApiResponse(success: true, data: final CategoryModel category)) {
      return category;
    } else {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }

  Future<CategoryModel> updateCategory(int id, QMap data) async {
    final response = await _dio.put('${Endpoints.categories}/$id', data: data);
    CategoryModelMapper.ensureInitialized();
    final res = ApiResponse.fromMap<CategoryModel>(response.data);

    if (res case ApiResponse(success: true, data: final CategoryModel category)) {
      return category;
    } else {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }

  Future<void> deleteCategory(int id) async {
    final response = await _dio.delete('${Endpoints.categories}/$id');
    final res = ApiResponse.fromMap<void>(response.data);

    if (!res.success) {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }
}
