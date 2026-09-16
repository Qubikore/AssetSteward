import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginPageview extends ConsumerWidget {
  const LoginPageview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final authState = ref.watch(authCtrlProvider);
    // final authCtrl = useMemoized(() => ref.read(authCtrlProvider.notifier));

    return Scaffold(appBar: AppBar(title: const Text('Login')));
  }
}
