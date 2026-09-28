import 'package:asset_steward_app/features/assets/data/models/asset_model.dart';
import 'package:asset_steward_app/features/assets/data/models/asset_label_response.dart';
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
    return result.fold((l) => throw l, (r) => r);
  }

  void addToList(AssetModel asset) {
    if (state.value != null) {
      state = AsyncData([asset, ...state.value!]);
    } else {
      ref.invalidateSelf();
    }
  }

  void updateInList(AssetModel asset) {
    if (state.value != null) {
      final list = [...state.value!];
      final index = list.indexWhere((e) => e.id == asset.id);
      if (index != -1) {
        list[index] = asset;
        state = AsyncData(list);
      }
    }
  }

  void removeFromList(int id) {
    if (state.value != null) {
      final list = [...state.value!];
      list.removeWhere((e) => e.id == id);
      state = AsyncData(list);
    }
  }

  Future<bool> createAsset(QMap payload) async {
    final result = await _repo.createAsset(payload);
    return result.fold(
      (l) {
        Toast.showError(l.message);
        return false;
      },
      (r) {
        addToList(r);
        Toast.showSuccess('Asset created successfully');
        return true;
      },
    );
  }

  Future<List<AssetLabelResponse>> getAssetLabels() async {
    final result = await _repo.getAssetLabels();
    return result.fold((l) {
      Toast.showError(l.message);
      return [];
    }, (r) => r);
  }
}
