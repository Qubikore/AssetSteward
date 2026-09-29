import 'package:asset_steward_app/main.export.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanPageview extends HookWidget {
  const ScanPageview({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(
      () => MobileScannerController(formats: const [BarcodeFormat.qrCode], detectionTimeoutMs: 1500),
    );

    useEffect(() {
      return controller.dispose;
    }, const []);

    final ticker = useAnimationController(duration: const Duration(seconds: 1));
    useListenable(ticker);
    useEffect(() {
      ticker.repeat();
      return null;
    }, const []);



    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Scan Asset'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(HIStroke.flash, color: Colors.white),
            onPressed: () => controller.toggleTorch(),
          ),
          IconButton(
            icon: const Icon(HIStroke.camera01, color: Colors.white),
            onPressed: () => controller.switchCamera(),
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            onDetect: (capture) {
              Chirp.info('QR', data: {'codes': capture.barcodes.map((x) => x.rawValue).toList()});
              final isCurrent = ModalRoute.of(context)?.isCurrent == true;
              if (!isCurrent) return;

              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                final scannedValue = barcode.rawValue?.trim();
                if (scannedValue != null) {
                  RPaths.qrScanResult.push(context, query: {'res': scannedValue});
                  break;
                }
              }
            },
          ),

          const _ScannerOverlay(),
        ],
      ),
    );
  }
}

class _ScannerOverlay extends StatelessWidget {
  const _ScannerOverlay();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final scanWindowSize = constraints.maxWidth * 0.7;

        return Stack(
          fit: StackFit.expand,
          children: [
            const CustomPaint(painter: _ScannerOverlayPainter()),
            Center(
              child: Container(
                width: scanWindowSize,
                height: scanWindowSize,
                decoration: BoxDecoration(
                  border: Border.all(color: context.colors.primary, width: 3),
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
            Positioned(
              bottom: constraints.maxHeight * 0.15,
              left: 0,
              right: 0,
              child: Text(
                'Align the QR code within the frame',
                textAlign: TextAlign.center,
                style: context.text.titleMedium?.copyWith(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ScannerOverlayPainter extends CustomPainter {
  const _ScannerOverlayPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()..color = Colors.black54;
    final scanWindowSize = size.width * 0.7;

    final cutoutRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: scanWindowSize,
      height: scanWindowSize,
    );

    final cutoutRRect = RRect.fromRectAndRadius(cutoutRect, const Radius.circular(24));

    final backgroundPath = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final cutoutPath = Path()..addRRect(cutoutRRect);

    final overlayPath = Path.combine(PathOperation.difference, backgroundPath, cutoutPath);

    canvas.drawPath(overlayPath, backgroundPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
