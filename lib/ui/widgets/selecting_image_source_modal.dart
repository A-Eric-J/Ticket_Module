import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ticket_module/enums/image_photo_picker.dart';
import 'package:ticket_module/generated/l10n.dart';
import 'package:ticket_module/locator.dart';
import 'package:ticket_module/providers/image_picker_provider.dart';
import 'package:ticket_module/services/get_image_from_network_service.dart';
import 'package:ticket_module/services/navigation_service.dart';
import 'package:ticket_module/ui/shared/colors.dart';
import 'package:ticket_module/ui/widgets/button/icon_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:ticket_module/ui/widgets/text/text_view.dart';

/// [SelectingImageSourceModal] is a modal for selecting images from camera or galley
/// for creating a ticket or adding image to the reply of ticket message
class SelectingImageSourceModal extends StatefulWidget {
  final ImagePhotoPicker? imagePhotoPicker;
  final int? indexEditing;
  final String? imageSource;
  final bool? hasPop;
  final Function()? onChange;

  const SelectingImageSourceModal({
    Key? key,
    this.imagePhotoPicker,
    this.indexEditing,
    this.imageSource,
    this.hasPop = true,
    this.onChange,
  }) : super(key: key);

  @override
  State<SelectingImageSourceModal> createState() =>
      _SelectingImageSourceModalState();
}

class _SelectingImageSourceModalState extends State<SelectingImageSourceModal> {
  final ImagePicker _picker = ImagePicker();
  ImagePickerProvider? _imagePickerProvider;

  @override
  void initState() {
    super.initState();
    _imagePickerProvider = Provider.of(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var isEdit = widget.imagePhotoPicker != ImagePhotoPicker.addingTicketImage;
    return Padding(
      padding: EdgeInsets.all(width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(
              text: isEdit
                  ? S.of(context).editImageText
                  : S.of(context).selectImageText,
              size: 16),
          const Divider(
            thickness: 2,
            color: brandMainColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  _onImageButtonPressed(
                      _imagePickerProvider!, ImageSource.gallery,
                      context: context);
                  if (widget.hasPop!) {
                    locator<NavigationService>().goBack();
                  }
                },
                child: Column(
                  children: [
                    const GalleryIcon(
                      color: primaryDark,
                    ),
                    TextView(text: S.of(context).fromGalleryText, size: 14),
                  ],
                ),
              ),
              SizedBox(
                height: width * 0.1333,
                child: const VerticalDivider(
                  thickness: 2,
                  color: brandMainColor,
                ),
              ),
              InkWell(
                onTap: () {
                  _onImageButtonPressed(
                      _imagePickerProvider!, ImageSource.camera,
                      context: context);
                  if (widget.hasPop!) {
                    locator<NavigationService>().goBack();
                  }
                },
                child: Column(
                  children: [
                    const CameraIcon(
                      color: primaryDark,
                    ),
                    TextView(text: S.of(context).fromCameraText, size: 14),
                  ],
                ),
              ),
              if (isEdit)
                SizedBox(
                  height: width * 0.1333,
                  child: const VerticalDivider(
                    thickness: 2,
                    color: brandMainColor,
                  ),
                ),
              if (isEdit)
                InkWell(
                  onTap: () {
                    _imagePickerProvider!.ticketImageClear();
                    if (widget.hasPop!) {
                      locator<NavigationService>().goBack();
                    }
                    if (widget.onChange != null) {
                      widget.onChange!();
                    }
                  },
                  child: Column(
                    children: [
                      const DeleteIcon(isFill: true),
                      TextView(
                        text: S.of(context).deleteText,
                        size: 14,
                        color: primaryErrorColor,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  void _onImageButtonPressed(
    ImagePickerProvider imagePickerProvider,
    ImageSource source, {
    required BuildContext context,
  }) async {
    try {
      imagePickerProvider.setIsProcessing(true);
      var pickedFile = await _picker.pickImage(
        maxHeight: 2986,
        maxWidth: 1680,
        imageQuality: 50,
        source: source,
      );
      if (pickedFile != null) {
        Uint8List? byteFile;

        if (kIsWeb) {
          if (!mounted) return;
          byteFile =
              await GetImageFromNetWorkService.getImageFromNetworkInWebApp(
            Provider.of(context, listen: false),
            Provider.of(context, listen: false),
            pickedFile,
          );
        }
        imagePickerProvider.setIsProcessing(false);
        switch (widget.imagePhotoPicker) {
          case ImagePhotoPicker.addingTicketImage:
            imagePickerProvider.setTicketByteFile(byteFile);
            imagePickerProvider.setTicketPickedFile(pickedFile);
            break;
          case ImagePhotoPicker.editingOrDeletingTicketImage:
            imagePickerProvider.setTicketByteFile(byteFile);
            imagePickerProvider.setTicketPickedFile(pickedFile);
            break;
          default:
            break;
        }
      }
      if (widget.onChange != null) {
        widget.onChange!();
      }
    } catch (e) {
      log(e.toString());
    }
    imagePickerProvider.setIsProcessing(false);
  }
}
