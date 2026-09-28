import 'package:asset_steward_app/features/assets/data/datasources/assets_remote_ds.dart';
import 'package:asset_steward_app/features/assets/data/models/asset_label_response.dart';
import 'package:asset_steward_app/features/assets/data/models/asset_model.dart';
import 'package:asset_steward_app/features/assets/data/models/assignment_model.dart';
import 'package:asset_steward_app/features/assets/data/models/asset_history_model.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AssetsRepository with RepoRunner {
  final AssetsRemoteDS _remoteDS;

  AssetsRepository(this._remoteDS);

  FutureResult<AssetModel> getAsset(int id) {
    return runRepoTask(() => _remoteDS.getAsset(id));
  }

  FutureResult<List<AssetModel>> getAssets([Map<String, dynamic>? queries]) {
    return runRepoTask(() => _remoteDS.getAssets(queries));
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

  FutureResult<void> rejectAsset(int id) {
    return runRepoTask(() => _remoteDS.rejectAsset(id));
  }

  FutureResult<void> returnAsset(QMap data) {
    return runRepoTask(() => _remoteDS.returnAsset(data));
  }

  FutureResult<List<AssetHistoryModel>> getAssetHistory(int id) {
    return runRepoTask(() => _remoteDS.getAssetHistory(id));
  }

  FutureResult<List<AssignmentModel>> getAssignmentsByAssetId(int id) {
    return runRepoTask(() => _remoteDS.getAssignmentsByAssetId(id));
  }

  FutureResult<AssetLabelResponse> getAssetLabelById(int id) {
    return runRepoTask(() => _remoteDS.getAssetLabelById(id));
  }

  FutureResult<AssignmentModel> getAssignmentById(int id) {
    return runRepoTask(() => _remoteDS.getAssignmentById(id));
  }

  FutureResult<List<AssignmentModel>> getMyAssignments([String? status]) {
    return runRepoTask(() => _remoteDS.getMyAssignments(status));
  }
}

