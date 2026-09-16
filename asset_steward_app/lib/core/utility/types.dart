import 'package:asset_steward_app/core/core.dart';
import 'package:fpdart/fpdart.dart';

typedef Result<T> = Either<Failure, T>;
typedef FutureResult<T> = Future<Result<T>>;
