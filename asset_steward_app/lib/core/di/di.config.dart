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
import 'package:asset_steward_app/core/storage/token_storage.dart' as _i890;
import 'package:asset_steward_app/features/auth/data/datasources/auth_remote_datasources.dart'
    as _i565;
import 'package:asset_steward_app/features/auth/data/repositories/auth_repository.dart'
    as _i206;
import 'package:asset_steward_app/main.export.dart' as _i342;
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final storageModule = _$StorageModule();
    final networkModule = _$NetworkModule();
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => storageModule.secureStorage,
    );
    gh.lazySingleton<_i890.TokenStorage>(
      () => _i890.TokenStorage(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i94.AuthInterceptor>(
      () => _i94.AuthInterceptor(gh<_i342.TokenStorage>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => networkModule.dio(gh<_i342.AuthInterceptor>()),
    );
    gh.lazySingleton<_i565.AuthRemoteDS>(
      () => _i565.AuthRemoteDS(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i206.AuthRepo>(
      () => _i206.AuthRepo(gh<_i565.AuthRemoteDS>(), gh<_i342.TokenStorage>()),
    );
    return this;
  }
}

class _$StorageModule extends _i890.StorageModule {}

class _$NetworkModule extends _i462.NetworkModule {}
