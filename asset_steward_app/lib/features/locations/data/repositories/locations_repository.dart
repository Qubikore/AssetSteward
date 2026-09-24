import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../main.export.dart';
import '../datasources/locations_remote_datasource.dart';
import '../models/location_model.dart';

@lazySingleton
class LocationsRepository with RepoRunner {
  LocationsRepository(this._remoteDS);

  final LocationsRemoteDS _remoteDS;

  Future<Either<Failure, List<LocationModel>>> getLocations() async {
    return runRepoTask(() => _remoteDS.getLocations());
  }

  Future<Either<Failure, LocationModel>> createLocation(QMap data) async {
    return runRepoTask(() => _remoteDS.createLocation(data));
  }

  Future<Either<Failure, LocationModel>> updateLocation(int id, QMap data) async {
    return runRepoTask(() => _remoteDS.updateLocation(id, data));
  }

  Future<Either<Failure, void>> deleteLocation(int id) async {
    return runRepoTask(() => _remoteDS.deleteLocation(id));
  }
}
