import 'package:asset_steward_app/features/assets/data/models/asset_model.dart';
import 'package:asset_steward_app/features/assets/data/repositories/assets_repository.dart';
import 'package:asset_steward_app/features/assets/presentation/controllers/assets_controller.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'asset_details_controller.g.dart';

@riverpod
class AssetDetailsCtrl extends _$AssetDetailsCtrl {
  @override
  FutureOr<AssetModel> build(int id) async {
    final repo = di.get<AssetsRepository>();
    final result = await repo.getAsset(id);
    return result.fold((l) => throw Exception(l.message), (r) => r);
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
