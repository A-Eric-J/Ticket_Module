import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:provider/provider.dart';
import 'package:ticket_module/const_values/assets.dart';
import 'package:ticket_module/enums/image_photo_picker.dart';
import 'package:ticket_module/enums/image_type.dart';
import 'package:ticket_module/generated/l10n.dart';
import 'package:ticket_module/locator.dart';
import 'package:ticket_module/providers/image_picker_provider.dart';
import 'package:ticket_module/providers/ticket_provider.dart';
import 'package:ticket_module/services/navigation_service.dart';
import 'package:ticket_module/services/ticket_service.dart';
import 'package:ticket_module/ui/shared/colors.dart';
import 'package:ticket_module/ui/widgets/blog.dart';
import 'package:ticket_module/ui/widgets/button/icon_button.dart';
import 'package:ticket_module/ui/widgets/selecting_image_source_modal.dart';
import 'package:ticket_module/ui/widgets/text/text_view.dart';
import 'package:ticket_module/ui/widgets/textformfield/textformfield_item.dart';

/// [TickerMessageFooter] contains a textFormField for writing the reply message
/// and you can attach an image too
class TickerMessageFooter extends StatefulWidget {
  const TickerMessageFooter({Key? key}) : super(key: key);

  @override
  State<TickerMessageFooter> createState() => _TickerMessageFooterState();
}

class _TickerMessageFooterState extends State<TickerMessageFooter> {
  var bodyTextController = TextEditingController();
  var buttonEnabled = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Consumer<TicketProvider>(builder: (context, ticketProvider, child) {
      return Stroke(
        backgroundColor: white,
        width: width,
        boxShadow: [
          BoxShadow(
              color: firstShimmerColor!,
              blurRadius: 10.0,
              offset: const Offset(5.0, 0.0))
        ],
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: width * 0.0213, horizontal: width * 0.0426),
          child: ticketProvider.selectedTicket != null &&
                  ticketProvider.selectedTicket!.status!.id! == 3
              ? Padding(
                  padding: EdgeInsets.all(width * 0.0213),
                  child: Center(
                      child: TextView(
                    text: ticketProvider.selectedTicket!.status!.label!,
                    size: 16,
                    color: textGray,
                  )),
                )
              : Consumer<ImagePickerProvider>(
                  builder: (context, imagePickerProvider, child) {
                  return Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(width * 0.0213),
                          child: TextFormFieldItem(
                            textController: bodyTextController,
                            hintText: S.of(context).submitTicketMessageText,
                            backgroundColor: bgBlue,
                            hasLabel: false,
                            filled: true,
                            radius: width * 0.0266,
                            maxLines: 5,
                            onChanged: (value) {
                              if (value.length >= 10) {
                                setState(() {
                                  buttonEnabled = true;
                                });
                              } else {
                                setState(() {
                                  buttonEnabled = false;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                      Stroke(
                          backgroundColor: softGreen,
                          onTap: () {
                            locator<NavigationService>().showModal(context,
                                StatefulBuilder(builder: (BuildContext context,
                                    StateSetter
                                        setState /*You can rename this!*/) {
                              var state = (kIsWeb &&
                                      imagePickerProvider.ticketByteFile !=
                                          null) ||
                                  (imagePickerProvider.ticketPickedFile !=
                                      null);
                              return Column(
                                children: [
                                  SelectingImageSourceModal(
                                    hasPop: false,
                                    onChange: () {
                                      setState(() {
                                        state = (kIsWeb &&
                                                imagePickerProvider
                                                        .ticketByteFile !=
                                                    null) ||
                                            (imagePickerProvider
                                                    .ticketPickedFile !=
                                                null);
                                      });
                                    },
                                    imagePhotoPicker: state
                                        ? ImagePhotoPicker
                                            .editingOrDeletingTicketImage
                                        : ImagePhotoPicker.addingTicketImage,
                                  ),
                                  if (state)
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: width * 0.04),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(width * 0.01),
                                        child: DottedBorder(
                                          dashPattern: const [2, 2],
                                          strokeWidth: 2,
                                          color: brandMainColor,
                                          padding: const EdgeInsets.all(8),
                                          borderPadding:
                                              const EdgeInsets.all(1),
                                          child: Stroke(
                                              height: width * 0.4,
                                              width: (width * 3) / 4,
                                              backgroundColor: softBlue,
                                              child: ImageAndIconFill(
                                                path: imagePickerProvider
                                                            .ticketByteFile !=
                                                        null
                                                    ? ''
                                                    : imagePickerProvider
                                                        .ticketPickedFile!.path,
                                                clipBehavior: Clip.hardEdge,
                                                radius: width * 0.008,
                                                fit: BoxFit.cover,
                                                bytes: imagePickerProvider
                                                    .ticketByteFile,
                                                imageType: imagePickerProvider
                                                            .ticketByteFile !=
                                                        null
                                                    ? ImageType.byte
                                                    : ImageType.file,
                                              )),
                                        ),
                                      ),
                                    )
                                ],
                              );
                            }));
                          },
                          radius: width * 0.0266,
                          child: Padding(
                            padding: EdgeInsets.all(width * 0.032),
                            child: AttachmentIcon(
                              color: green,
                              size: width * 0.064,
                            ),
                          )),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Stroke(
                          backgroundColor: buttonEnabled
                              ? softBlue
                              : greyColor.withOpacity(0.8),
                          onTap: buttonEnabled
                              ? () {
                                  TicketService.createNewReply(
                                      Provider.of(context, listen: false),
                                      ticketProvider,
                                      imagePickerProvider,
                                      {
                                        'ticket_id':
                                            ticketProvider.selectedTicket!.id,
                                        'reply': bodyTextController.text,
                                        if (imagePickerProvider.ticketPickedFile != null || imagePickerProvider.ticketByteFile != null)
                                          "attachments": MultipartFile.fromBytes(
                                              kIsWeb
                                                  ? imagePickerProvider
                                                      .ticketByteFile!
                                                  : File(imagePickerProvider.ticketPickedFile!.path)
                                                      .readAsBytesSync(),
                                              contentType: MediaType(
                                                  'file',
                                                  imagePickerProvider.fileName(
                                                      kIsWeb
                                                          ? imagePickerProvider
                                                              .ticketByteFile!
                                                          : File(imagePickerProvider.ticketPickedFile!.path)
                                                              .readAsBytesSync(),
                                                      '',
                                                      true)),
                                              filename: imagePickerProvider.fileName(
                                                  kIsWeb
                                                      ? imagePickerProvider.ticketByteFile!
                                                      : File(imagePickerProvider.ticketPickedFile!.path).readAsBytesSync(),
                                                  imagePickerProvider.imageName(),
                                                  false))
                                      });
                                  setState(() {
                                    bodyTextController.text = '';
                                    buttonEnabled = false;
                                  });
                                }
                              : null,
                          radius: width * 0.0266,
                          child: Padding(
                            padding: EdgeInsets.all(width * 0.032),
                            child: const ImageAndIconFill(
                              path: Assets.send,
                              isSvg: true,
                            ),
                          ))
                    ],
                  );
                }),
        ),
      );
    });
  }
}
