// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:asset_steward_app/core/network/auth_interceptor.dart' as _i94;
import 'package:asset_steward_app/core/network/dio_client.dart' as _i462;
import 'package:asset_steward_app/core/storage/key_value_storage.dart' as _i595;
import 'package:asset_steward_app/core/storage/token_storage.dart' as _i890;
import 'package:asset_steward_app/features/auth/data/datasources/auth_remote_datasources.dart'
    as _i565;
import 'package:asset_steward_app/features/auth/data/repositories/auth_repository.dart'
    as _i207;
import 'package:asset_steward_app/features/departments/data/datasources/departments_remote_datasource.dart'
    as _i389;
import 'package:asset_steward_app/features/departments/data/repositories/departments_repository.dart'
    as _i146;
import 'package:asset_steward_app/features/locations/data/datasources/locations_remote_datasource.dart'
    as _i1012;
import 'package:asset_steward_app/features/locations/data/repositories/locations_repository.dart'
    as _i557;
import 'package:asset_steward_app/features/profile/data/datasources/profile_remote_datasource.dart'
    as _i81;
import 'package:asset_steward_app/features/profile/data/repositories/profile_repository.dart'
    as _i206;
import 'package:asset_steward_app/features/users/data/datasources/users_remote_datasource.dart'
    as _i1041;
import 'package:asset_steward_app/features/users/data/repositories/users_repository.dart'
    as _i876;
import 'package:asset_steward_app/main.export.dart' as _i342;
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final keyValueStorageModule = _$KeyValueStorageModule();
    final storageModule = _$StorageModule();
    final networkModule = _$NetworkModule();
    await gh.lazySingletonAsync<_i460.SharedPreferences>(
      () => keyValueStorageModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => storageModule.secureStorage,
    );
    gh.lazySingleton<_i890.TokenStorage>(
      () => _i890.TokenStorage(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i94.AuthInterceptor>(
      () => _i94.AuthInterceptor(gh<_i342.TokenStorage>()),
    );
    gh.lazySingleton<_i595.KeyValueStorage>(
      () => _i595.KeyValueStorage(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => networkModule.dio(gh<_i342.AuthInterceptor>()),
    );
    gh.lazySingleton<_i565.AuthRemoteDS>(
      () => _i565.AuthRemoteDS(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i389.DepartmentsRemoteDS>(
      () => _i389.DepartmentsRemoteDS(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i1012.LocationsRemoteDS>(
      () => _i1012.LocationsRemoteDS(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i81.ProfileRemoteDS>(
      () => _i81.ProfileRemoteDS(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i1041.UsersRemoteDS>(
      () => _i1041.UsersRemoteDS(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i206.ProfileRepository>(
      () => _i206.ProfileRepository(gh<_i81.ProfileRemoteDS>()),
    );
    gh.lazySingleton<_i876.UsersRepository>(
      () => _i876.UsersRepository(gh<_i1041.UsersRemoteDS>()),
    );
    gh.lazySingleton<_i207.AuthRepo>(
      () => _i207.AuthRepo(gh<_i565.AuthRemoteDS>(), gh<_i342.TokenStorage>()),
    );
    gh.lazySingleton<_i557.LocationsRepository>(
      () => _i557.LocationsRepository(gh<_i1012.LocationsRemoteDS>()),
    );
    gh.lazySingleton<_i146.DepartmentsRepository>(
      () => _i146.DepartmentsRepository(gh<_i389.DepartmentsRemoteDS>()),
    );
    return this;
  }
}

class _$KeyValueStorageModule extends _i595.KeyValueStorageModule {}

class _$StorageModule extends _i890.StorageModule {}

class _$NetworkModule extends _i462.NetworkModule {}
