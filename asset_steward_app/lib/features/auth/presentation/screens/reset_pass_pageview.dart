import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ResetPassPageview extends ConsumerWidget {
  const ResetPassPageview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final authState = ref.watch(authCtrlProvider);
    // final authCtrl = useMemoized(() => ref.read(authCtrlProvider.notifier));

    return Scaffold(appBar: AppBar(title: const Text('ResetPassPageview')));
  }
}
