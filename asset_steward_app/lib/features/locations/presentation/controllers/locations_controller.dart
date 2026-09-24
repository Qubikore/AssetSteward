import 'dart:async';

import 'package:asset_steward_app/features/locations/data/models/location_model.dart';
import 'package:asset_steward_app/features/locations/data/repositories/locations_repository.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'locations_controller.g.dart';

@Riverpod(keepAlive: true)
class LocationsCtrl extends _$LocationsCtrl {
  final _repo = di<LocationsRepository>();

  @override
  FutureOr<List<LocationModel>> build() async {
    return _fetchLocations();
  }

  Future<List<LocationModel>> _fetchLocations() async {
    final result = await _repo.getLocations();
    return result.fold((l) => throw l, (r) => r);
  }

  Future<Either<Failure, LocationModel>> createLocation(QMap data) async {
    final result = await _repo.createLocation(data);

    result.map((location) async {
      state = AsyncData([...(await future), location]);
    });

    return result;
  }

  Future<Either<Failure, LocationModel>> updateLocation(int id, QMap data) async {
    final result = await _repo.updateLocation(id, data);

    result.map((updatedLocation) async {
      final currentList = await future;
      final index = currentList.indexWhere((e) => e.id == id);
      if (index != -1) {
        final newList = List<LocationModel>.from(currentList);
        newList[index] = updatedLocation;
        state = AsyncData(newList);
      } else {
        ref.invalidateSelf();
      }
    });

    return result;
  }

  Future<Either<Failure, void>> deleteLocation(int id) async {
    final repo = GetIt.I<LocationsRepository>();
    final result = await repo.deleteLocation(id);

    result.map((_) {
      if (state.value != null) {
        final List<LocationModel> currentList = state.value!;
        final newList = currentList.where((element) => element.id != id).toList();
        state = AsyncData(newList);
      }
    });

    return result;
  }
}
