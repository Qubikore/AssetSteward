import 'logic/app_route.dart';

export 'package:go_router/go_router.dart';

class RPaths {
  const RPaths._();

  static const login = RPath('/login');
  static const forgetPass = RPath('/forgetPass');
  static const resetPass = RPath('/resetPass');

  static const home = RPath('/home');
}
