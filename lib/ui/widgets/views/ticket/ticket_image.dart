import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_module/enums/image_photo_picker.dart';
import 'package:ticket_module/enums/image_type.dart';
import 'package:ticket_module/generated/l10n.dart';
import 'package:ticket_module/locator.dart';
import 'package:ticket_module/providers/image_picker_provider.dart';
import 'package:ticket_module/services/navigation_service.dart';
import 'package:ticket_module/ui/shared/colors.dart';
import 'package:ticket_module/ui/widgets/blog.dart';
import 'package:ticket_module/ui/widgets/button/icon_button.dart';
import 'package:ticket_module/ui/widgets/selecting_image_source_modal.dart';
import 'package:ticket_module/ui/widgets/text/text_view.dart';

class TicketImage extends StatefulWidget {

  const TicketImage({Key? key})
      : super(key: key);

  @override
  State<TicketImage> createState() => _TicketImageState();
}

class _TicketImageState extends State<TicketImage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Consumer<ImagePickerProvider>(
      builder: (context, imagePickerProvider ,child) {

        var state = (kIsWeb && imagePickerProvider.ticketByteFile != null) || (imagePickerProvider.ticketPickedFile != null);
        return InkWell(
            highlightColor: transparent,
            splashColor: transparent,
            onTap: (){
              locator<NavigationService>().showModal(
                  context,
                  SelectingImageSourceModal(
                  imagePhotoPicker: state
                  ? ImagePhotoPicker.editingOrDeletingTicketImage
                  : ImagePhotoPicker.addingTicketImage,
              ));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(width * 0.01),
              child: DottedBorder(
                dashPattern: const [2, 2],
                strokeWidth: 2,
                color: brandMainColor,
                padding: const EdgeInsets.all(8),
                borderPadding: const EdgeInsets.all(1),
                child: Stroke(
                  height:  width * 0.4,
                  width:( width * 3) / 4,
                  backgroundColor: softBlue,
                  child: state

                      ? ImageAndIconFill(
                    path: imagePickerProvider.ticketByteFile != null ? '' : imagePickerProvider.ticketPickedFile!.path,
                    clipBehavior: Clip.hardEdge,
                    radius: width * 0.008,
                    fit: BoxFit.cover,
                    bytes:  imagePickerProvider.ticketByteFile,
                    imageType: imagePickerProvider.ticketByteFile != null ? ImageType.byte : ImageType.file,
                  ):  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      CameraIcon(size: width * 0.06,),
                      SizedBox(height: width * 0.01,),
                      TextView(text: S.of(context).pleaseAddImageTicketText, size: 16,color: brandMainColor,)
                    ],
                  ),
                ),
              ),
            )
        );
      }
    );
  }


}