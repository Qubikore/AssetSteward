import 'package:asset_steward_app/features/assets/data/models/asset_label_response.dart';
import 'package:asset_steward_app/features/assets/data/models/asset_model.dart';
import 'package:asset_steward_app/features/assets/data/models/assignment_model.dart';
import 'package:asset_steward_app/features/assets/data/repositories/assets_repository.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:recase/recase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'assets_controller.g.dart';

@Riverpod(keepAlive: true)
class AssetsCtrl extends _$AssetsCtrl {
  final _repo = di.get<AssetsRepository>();
  final _debouncer = Debouncer();

  String _searchQuery = '';
  int? _categoryId;
  int? _locationId;
  int? _departmentId;

  @override
  FutureOr<List<AssetModel>> build([AssetStatus? status]) async {
    return _fetch();
  }

  Future<List<AssetModel>> _fetch() async {
    final queries = {
      'status': ?status?.name.constantCase,
      if (_searchQuery.isNotEmpty) 'search': _searchQuery,
      'categoryId': ?_categoryId,
      'locationId': ?_locationId,
      'departmentId': ?_departmentId,
    };

    final result = await _repo.getAssets(queries);
    return result.fold((l) => throw l, (r) => r);
  }

  Future<void> refresh([bool silent = true]) async {
    if (!silent) state = const AsyncLoading();
    state = await AsyncValue.guard(_fetch);
  }

  void search(String query) {
    if (_searchQuery == query) return;
    _searchQuery = query;
    _debouncer.run(() => refresh(false));
  }

  void filter({int? categoryId, int? locationId, int? departmentId}) {
    _categoryId = categoryId;
    _locationId = locationId;
    _departmentId = departmentId;
    refresh(false);
  }

  void clearFilters() {
    _categoryId = null;
    _locationId = null;
    _departmentId = null;
    _searchQuery = '';
    refresh(false);
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

@Riverpod(keepAlive: true)
class MyAssetsCtrl extends _$MyAssetsCtrl {
  final _repo = di.get<AssetsRepository>();

  @override
  FutureOr<List<AssignmentModel>> build() async {
    return _fetch();
  }

  Future<List<AssignmentModel>> _fetch() async {
    final result = await _repo.getMyAssignments('active');
    return result.fold((l) => throw l, (r) => r);
  }

  Future<void> refresh([bool silent = true]) async {
    if (!silent) state = const AsyncLoading();
    state = await AsyncValue.guard(_fetch);
  }
}
