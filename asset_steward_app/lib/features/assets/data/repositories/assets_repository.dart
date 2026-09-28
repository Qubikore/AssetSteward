import 'package:asset_steward_app/features/assets/data/datasources/assets_remote_ds.dart';
import 'package:asset_steward_app/features/assets/data/models/asset_label_response.dart';
import 'package:asset_steward_app/features/assets/data/models/asset_model.dart';
import 'package:asset_steward_app/features/assets/data/models/assignment_model.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AssetsRepository with RepoRunner {
  final AssetsRemoteDS _remoteDS;

  AssetsRepository(this._remoteDS);

  FutureResult<AssetModel> getAsset(int id) {
    return runRepoTask(() => _remoteDS.getAsset(id));
  }

  FutureResult<List<AssetModel>> getAssets() {
    return runRepoTask(() => _remoteDS.getAssets());
  }

  FutureResult<AssetModel> createAsset(QMap data) {
    return runRepoTask(() => _remoteDS.createAsset(data));
  }

  FutureResult<AssetModel> updateAsset(int id, QMap data) {
    return runRepoTask(() => _remoteDS.updateAsset(id, data));
  }

  FutureResult<void> deleteAsset(int id) {
    return runRepoTask(() => _remoteDS.deleteAsset(id));
  }

  FutureResult<void> approveAsset(int id) {
    return runRepoTask(() => _remoteDS.approveAsset(id));
  }

  FutureResult<void> transferAsset(QMap data) {
    return runRepoTask(() => _remoteDS.transferAsset(data));
  }

  FutureResult<void> assignAsset(QMap data) {
    return runRepoTask(() => _remoteDS.assignAsset(data));
  }

  FutureResult<List<AssetLabelResponse>> getAssetLabels() {
    return runRepoTask(() => _remoteDS.getAssetLabels());
  }

  FutureResult<List<AssignmentModel>> getAssetAssignments([String? status]) {
    return runRepoTask(() => _remoteDS.getAssetAssignments(status));
  }
}
