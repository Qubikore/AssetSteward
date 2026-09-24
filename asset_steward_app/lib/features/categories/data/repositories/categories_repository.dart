import 'package:asset_steward_app/features/categories/data/datasources/categories_remote_ds.dart';
import 'package:asset_steward_app/features/categories/data/models/category_model.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CategoriesRepository with RepoRunner {
  final CategoriesRemoteDS _remoteDS;

  CategoriesRepository(this._remoteDS);

  FutureResult<List<CategoryModel>> getCategories() {
    return runRepoTask(() => _remoteDS.getCategories());
  }

  FutureResult<CategoryModel> createCategory(QMap data) {
    return runRepoTask(() => _remoteDS.createCategory(data));
  }

  FutureResult<CategoryModel> updateCategory(int id, QMap data) {
    return runRepoTask(() => _remoteDS.updateCategory(id, data));
  }

  FutureResult<void> deleteCategory(int id) {
    return runRepoTask(() => _remoteDS.deleteCategory(id));
  }
}
