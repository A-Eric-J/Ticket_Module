import 'dart:typed_data';

import 'package:ticket_module/providers/image_picker_provider.dart';
import 'package:ticket_module/services/web_service.dart';
import 'package:image_picker/image_picker.dart';

class GetImageFromNetWorkService {
  static Future<Uint8List?> getImageFromNetworkInWebApp(
    WebService webService,
    ImagePickerProvider imagePickerProvider,
    XFile file,
  ) async {
    imagePickerProvider.setIsProcessing(true);
    var response = await webService.getFunctionWithBytesResponse(file.path);
    imagePickerProvider.setIsProcessing(false);
    return response.data as Uint8List;
  }
}
