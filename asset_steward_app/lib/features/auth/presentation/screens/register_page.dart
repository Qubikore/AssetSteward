import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final authState = ref.watch(authCtrlProvider);
    // final authCtrl = useMemoized(() => ref.read(authCtrlProvider.notifier));

    return Scaffold(appBar: AppBar(title: const Text('ForgetPassPageview')));
  }
}
