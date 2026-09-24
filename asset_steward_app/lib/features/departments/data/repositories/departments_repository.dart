import 'package:injectable/injectable.dart';

import '../../../../main.export.dart';
import '../datasources/departments_remote_datasource.dart';
import '../models/department_model.dart';

@lazySingleton
class DepartmentsRepository with RepoRunner {
  DepartmentsRepository(this._remoteDS);

  final DepartmentsRemoteDS _remoteDS;

  FutureResult<List<DepartmentModel>> getDepartments() async {
    return runRepoTask(() => _remoteDS.getDepartments());
  }

  FutureResult<DepartmentModel> createDepartment(QMap data) async {
    return runRepoTask(() => _remoteDS.createDepartment(data));
  }

  FutureResult<DepartmentModel> updateDepartment(int id, QMap data) async {
    return runRepoTask(() => _remoteDS.updateDepartment(id, data));
  }

  FutureResult<void> deleteDepartment(int id) async {
    return runRepoTask(() => _remoteDS.deleteDepartment(id));
  }
}
