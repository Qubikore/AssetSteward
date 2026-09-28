import 'package:asset_steward_app/features/assets/data/models/asset_model.dart';
import 'package:asset_steward_app/features/assets/data/repositories/assets_repository.dart';
import 'package:asset_steward_app/features/assets/presentation/controllers/assets_controller.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'asset_details_controller.g.dart';

@Riverpod(keepAlive: true)
class AssetDetailsCtrl extends _$AssetDetailsCtrl {
  @override
  FutureOr<AssetModel> build(int id) async {
    final repo = di.get<AssetsRepository>();
    final result = await repo.getAsset(id);
    return result.fold((l) => throw Exception(l.message), (r) => r);
  }

  Future<bool> updateAsset(QMap data) async {
    final repo = di.get<AssetsRepository>();
    final result = await repo.updateAsset(id, data);
    return result.fold(
      (l) {
        Toast.showError(l.message);
        return false;
      },
      (r) {
        ref.invalidate(assetsCtrlProvider);
        ref.invalidateSelf();
        Toast.showSuccess('Asset updated successfully');
        return true;
      },
    );
  }

  Future<bool> transferAsset(QMap payload) async {
    final repo = di.get<AssetsRepository>();
    final result = await repo.transferAsset(payload);
    return result.fold(
      (l) {
        Toast.showError(l.message);
        return false;
      },
      (r) {
        ref.invalidateSelf();
        Toast.showSuccess('Asset transferred successfully');
        return true;
      },
    );
  }

  Future<bool> deleteAsset() async {
    final repo = di.get<AssetsRepository>();
    final result = await repo.deleteAsset(id);
    return result.fold(
      (l) {
        Toast.showError(l.message);
        return false;
      },
      (r) {
        ref.invalidate(assetsCtrlProvider);
        Toast.showSuccess('Asset deleted successfully');
        return true;
      },
    );
  }

  Future<bool> assignAsset(QMap payload) async {
    final repo = di.get<AssetsRepository>();
    final result = await repo.assignAsset(payload);
    return result.fold(
      (l) {
        Toast.showError(l.message);
        return false;
      },
      (r) {
        ref.invalidate(assetsCtrlProvider);
        ref.invalidateSelf();

        Toast.showSuccess('Asset assigned successfully');
        return true;
      },
    );
  }

  Future<bool> approve() async {
    final repo = di.get<AssetsRepository>();
    final result = await repo.approveAsset(id);
    return result.fold(
      (l) {
        Toast.showError(l.message);
        return false;
      },
      (r) {
        ref.invalidate(assetsCtrlProvider);
        ref.invalidateSelf();
        Toast.showSuccess('Asset approved successfully');

        return true;
      },
    );
  }
}
