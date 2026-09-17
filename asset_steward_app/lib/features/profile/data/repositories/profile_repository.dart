import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../main.export.dart';
import '../datasources/profile_remote_datasource.dart';
import '../models/organization_data.dart';
import '../models/profile_data.dart';

@lazySingleton
class ProfileRepository {
  ProfileRepository(this._remoteDS);

  final ProfileRemoteDS _remoteDS;

  Future<Either<Failure, ProfileData>> getProfile() async {
    try {
      final res = await _remoteDS.getProfile();
      return Right(res);
    } catch (e, s) {
      return Left(Failure(e.toString(), exception: e, stackTrace: s));
    }
  }

  Future<Either<Failure, OrganizationData>> getOrganization() async {
    try {
      final res = await _remoteDS.getOrganization();
      return Right(res);
    } catch (e, s) {
      return Left(Failure(e.toString(), exception: e, stackTrace: s));
    }
  }
}
