import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:ticket_module/enums/image_type.dart';
import 'package:ticket_module/generated/l10n.dart';
import 'package:ticket_module/ui/shared/colors.dart';
import 'package:ticket_module/ui/widgets/blog.dart';
import 'package:ticket_module/ui/widgets/button/icon_button.dart';
import 'package:ticket_module/ui/widgets/text/text_view.dart';

/// From [AttachmentShowingTicketMessage] you can attach an image to a ticket
class AttachmentShowingTicketMessage extends StatefulWidget {
  final String? image;
  final bool? isLocal;
  final Uint8List? imageByte;

  const AttachmentShowingTicketMessage(
      {Key? key, this.image, this.isLocal = false, this.imageByte})
      : super(key: key);

  @override
  State<AttachmentShowingTicketMessage> createState() =>
      _AttachmentShowingTicketMessageState();
}

class _AttachmentShowingTicketMessageState
    extends State<AttachmentShowingTicketMessage> {
  var enable = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              enable = !enable;
            });
          },
          child: Row(
            children: [
              TextView(
                text: S.of(context).attachmentText,
                size: 14,
                color: green,
              ),
              enable
                  ? const KeyboardArrowUpIcon(
                      color: green,
                    )
                  : const KeyboardArrowDownIcon(
                      color: green,
                    )
            ],
          ),
        ),
        if (enable)
          ImageAndIconFill(
            path: widget.image,
            bytes: widget.imageByte,
            imageType: widget.isLocal != null && widget.isLocal!
                ? ImageType.byte
                : ImageType.network,
          ),
      ],
    );
  }
}
