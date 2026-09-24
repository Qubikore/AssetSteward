import 'package:asset_steward_app/core/di/di.dart';
import 'package:asset_steward_app/features/assets/data/models/asset_model.dart';
import 'package:asset_steward_app/features/assets/data/repositories/assets_repository.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'assets_controller.g.dart';

@Riverpod(keepAlive: true)
class AssetsCtrl extends _$AssetsCtrl {
  final _repo = di.get<AssetsRepository>();

  @override
  FutureOr<List<AssetModel>> build() async {
    return _fetch();
  }

  Future<List<AssetModel>> _fetch() async {
    final result = await _repo.getAssets();
    return result.fold(
      (l) => throw l,
      (r) => r,
    );
  }

  Future<bool> createAsset(QMap payload) async {
    final result = await _repo.createAsset(payload);
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
  Future<bool> updateAsset(int id, QMap data) async {
    final result = await _repo.updateAsset(id, data);
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

  Future<bool> deleteAsset(int id) async {
    final result = await _repo.deleteAsset(id);
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
