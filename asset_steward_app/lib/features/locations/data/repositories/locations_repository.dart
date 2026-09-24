import 'package:injectable/injectable.dart';

import '../../../../main.export.dart';
import '../datasources/locations_remote_datasource.dart';
import '../models/location_model.dart';

@lazySingleton
class LocationsRepository with RepoRunner {
  LocationsRepository(this._remoteDS);

  final LocationsRemoteDS _remoteDS;

  FutureResult<List<LocationModel>> getLocations() async {
    return runRepoTask(() => _remoteDS.getLocations());
  }

  FutureResult<LocationModel> createLocation(QMap data) async {
    return runRepoTask(() => _remoteDS.createLocation(data));
  }

  FutureResult<LocationModel> updateLocation(int id, QMap data) async {
    return runRepoTask(() => _remoteDS.updateLocation(id, data));
  }

  FutureResult<void> deleteLocation(int id) async {
    return runRepoTask(() => _remoteDS.deleteLocation(id));
  }
}
