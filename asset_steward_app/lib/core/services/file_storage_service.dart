import 'dart:typed_data';

import 'package:asset_steward_app/main.export.dart';
import 'package:file_saver_ffi/file_saver_ffi.dart';

class FileStorageService {
  FileStorageService._();

  static final FileStorageService instance = FileStorageService._();

  /// Saves a file natively and optionally prompts to open it.
  Future<void> saveAndPrompt({
    required Uint8List bytes,
    required String fileName,
    required String extension,
    required String mimeType,
    String successMessage = 'File saved successfully',
    bool showPrompt = true,
  }) async {
    try {
      final uri = await FileSaver.saveAsAsync(
        input: SaveInput.bytes(bytes),
        fileName: fileName,
        fileType: CustomFileType(ext: extension, mimeType: mimeType),
      );

      if (uri == null) {
        // User cancelled
        return;
      }

      if (showPrompt) {
        Toast.showSuccess(successMessage, actionLabel: 'Open', action: () => openSavedFile(uri));
      }
    } catch (e, s) {
      Chirp.error('Failed to save file', error: e, stackTrace: s);
      Toast.showError('Failed to save file: $e');
    }
  }

  Future<void> openSavedFile(Uri path) async {
    try {
      await FileSaver.openFile(path);
    } catch (e, s) {
      Chirp.error('Failed to open file', error: e, stackTrace: s);
      Toast.showError('Failed to open file: $e');
    }
  }
}
