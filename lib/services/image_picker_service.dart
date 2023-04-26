import 'dart:developer';

import 'package:image_picker/image_picker.dart';

/// A service that works with image_picker
final ImagePicker _picker = ImagePicker();

Future<XFile?> onImageButtonPressed(
  ImageSource source,
) async {
  try {
    final pickedFile = await _picker.pickImage(
      maxHeight: 2986,
      maxWidth: 1680,
      imageQuality: 50,
      source: source,
    );
    return pickedFile;
  } catch (e) {
    log('Error in ImagePicker: $e');
    return null;
  }
}
