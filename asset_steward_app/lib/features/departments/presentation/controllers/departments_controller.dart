import 'dart:async';

import 'package:asset_steward_app/features/departments/data/models/department_model.dart';
import 'package:asset_steward_app/features/departments/data/repositories/departments_repository.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'departments_controller.g.dart';

@Riverpod(keepAlive: true)
class DepartmentsCtrl extends _$DepartmentsCtrl {
  final _repo = di.get<DepartmentsRepository>();

  @override
  FutureOr<List<DepartmentModel>> build() async {
    return _fetchDepartments();
  }

  Future<List<DepartmentModel>> _fetchDepartments() async {
    final result = await _repo.getDepartments();
    return result.fold((l) => throw l, (r) => r);
  }

  Future<Either<Failure, DepartmentModel>> createDepartment(QMap data) async {
    final result = await _repo.createDepartment(data);

    result.map((department) {
      if (state.value != null) {
        state = AsyncData([...state.value!, department]);
      } else {
        ref.invalidateSelf();
      }
    });

    return result;
  }

  Future<Either<Failure, DepartmentModel>> updateDepartment(int id, QMap data) async {
    final result = await _repo.updateDepartment(id, data);

    result.map((updatedDepartment) {
      if (state.value != null) {
        final List<DepartmentModel> currentList = state.value!;
        final index = currentList.indexWhere((element) => element.id == id);
        if (index != -1) {
          final newList = List<DepartmentModel>.from(currentList);
          newList[index] = updatedDepartment;
          state = AsyncData(newList);
        } else {
          ref.invalidateSelf();
        }
      }
    });

    return result;
  }

  Future<Either<Failure, void>> deleteDepartment(int id) async {
    final result = await _repo.deleteDepartment(id);

    result.map((_) {
      if (state.value != null) {
        final List<DepartmentModel> currentList = state.value!;
        final newList = currentList.where((element) => element.id != id).toList();
        state = AsyncData(newList);
      }
    });

    return result;
  }
}
