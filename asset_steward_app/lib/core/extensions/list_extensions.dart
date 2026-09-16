import 'package:asset_steward_app/core/extensions/map_extensions.dart';
import 'package:chirp/chirp.dart';

extension ListX<T> on List<T> {
  List<T> logJson([String? m]) {
    Chirp.info(m ?? 'Log List', data: asMap().toStringKey());
    return this;
  }
}
