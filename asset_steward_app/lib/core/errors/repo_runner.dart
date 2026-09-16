import 'package:fpdart/fpdart.dart';
import 'package:asset_steward_app/core/utility/types.dart';
import 'package:asset_steward_app/core/errors/error_handler.dart';

/// A mixin designed for the Repository layer to gracefully handle errors from the Data Source.
/// It catches exceptions and maps them to a domain [Failure], returning an [Either] type.
mixin RepoRunner {
  /// Executes a [task] and maps any exceptions to a [Failure].
  /// Use this to wrap Data Source calls inside your Repository.
  FutureResult<T> runRepoTask<T>(Future<T> Function() task) async {
    try {
      final result = await task();
      return right(result);
    } catch (e, s) {
      return left(ErrorHandler.handle(e, s));
    }
  }
}
