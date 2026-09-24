import 'package:asset_steward_app/core/di/di.dart';
import 'package:asset_steward_app/features/categories/data/models/category_model.dart';
import 'package:asset_steward_app/features/categories/data/repositories/categories_repository.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'categories_controller.g.dart';

@Riverpod(keepAlive: true)
class CategoriesCtrl extends _$CategoriesCtrl {
  final _repo = di.get<CategoriesRepository>();

  @override
  FutureOr<List<CategoryModel>> build() async {
    return _fetch();
  }

  Future<List<CategoryModel>> _fetch() async {
    final result = await _repo.getCategories();
    return result.fold(
      (l) => throw l,
      (r) => r,
    );
  }

  Future<bool> createCategory(QMap payload) async {
    final result = await _repo.createCategory(payload);
    return result.fold(
      (l) {
        Toast.showError(l.message);
        return false;
      },
      (r) {
        ref.invalidateSelf();
        return true;
      },
    );
  }

  Future<bool> updateCategory(int id, QMap payload) async {
    final result = await _repo.updateCategory(id, payload);
    return result.fold(
      (l) {
        Toast.showError(l.message);
        return false;
      },
      (r) {
        ref.invalidateSelf();
        return true;
      },
    );
  }

  Future<bool> deleteCategory(int id) async {
    final result = await _repo.deleteCategory(id);
    return result.fold(
      (l) {
        Toast.showError(l.message);
        return false;
      },
      (r) {
        ref.invalidateSelf();
        return true;
      },
    );
  }
}
