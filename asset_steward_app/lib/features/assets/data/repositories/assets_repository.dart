import 'package:asset_steward_app/features/assets/data/datasources/assets_remote_ds.dart';
import 'package:asset_steward_app/features/assets/data/models/asset_model.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AssetsRepository with RepoRunner {
  final AssetsRemoteDS _remoteDS;

  AssetsRepository(this._remoteDS);

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
}
