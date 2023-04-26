import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

/// [ImagePickerProvider] is a provider for imagePicking and
/// if you had more image types like ticket you can add here
class ImagePickerProvider extends ChangeNotifier {
  var _isProcessing = false;

  bool get isProcessing => _isProcessing;

  void setIsProcessing(bool value) {
    _isProcessing = value;
    notifyListeners();
  }

  /// ticket image

  Uint8List? _ticketByteFile;

  void setTicketByteFile(Uint8List? byteFile) {
    _ticketByteFile = byteFile;
    notifyListeners();
  }

  Uint8List? get ticketByteFile => _ticketByteFile;

  XFile? _ticketPickedFile;

  void setTicketPickedFile(XFile file) {
    _ticketPickedFile = file;
    notifyListeners();
  }

  XFile? get ticketPickedFile => _ticketPickedFile;

  void ticketImageClear() {
    _isProcessing = false;
    _ticketByteFile = null;
    _ticketPickedFile = null;
    notifyListeners();
  }

  String fileName(Uint8List bytes, String name, bool withoutName) {
    var imageExtension = lookupMimeType('', headerBytes: bytes);
    String? imageName = '';
    if (withoutName) {
      imageName = imageExtension?.split('/').last;
    } else {
      imageName = '$name.${imageExtension?.split('/').last}';
    }
    return imageName!;
  }

  String imageName() {
    return 'ticket';
  }
}
