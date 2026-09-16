import 'package:asset_steward_app/main.export.dart';
import 'package:material_ui/material_ui.dart';

class ErrorRoutePage extends StatelessWidget {
  const ErrorRoutePage({super.key, this.error});
  final Object? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('404')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('404', style: context.text.titleLarge),
            const SizedBox(height: 5),
            Text('Page not found', style: context.text.titleMedium),
            const SizedBox(height: 20),
            Text('$error', style: context.text.bodyMedium, textAlign: TextAlign.center),
            const SizedBox(height: 20),
            FilledButton(child: const Text('Go home'), onPressed: () => RPaths.home.go(context)),
          ],
        ),
      ),
    );
  }
}
