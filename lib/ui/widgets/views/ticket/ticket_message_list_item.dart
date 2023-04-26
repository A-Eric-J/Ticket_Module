import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_module/enums/view_state.dart';
import 'package:ticket_module/models/ticket_message.dart';
import 'package:ticket_module/providers/ticket_provider.dart';
import 'package:ticket_module/ui/shared/colors.dart';
import 'package:ticket_module/ui/widgets/blog.dart';
import 'package:ticket_module/ui/widgets/button/icon_button.dart';
import 'package:ticket_module/ui/widgets/text/text_view.dart';
import 'package:ticket_module/ui/widgets/views/ticket/attachment_showing_ticket_message.dart';

/// [TicketMessageListItem] contains name of the client or the supporter, message reply with date and time
/// and with an image attachment if it has
class TicketMessageListItem extends StatelessWidget {
  final TicketMessage ticketMessage;

  const TicketMessageListItem({Key? key, required this.ticketMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Consumer<TicketProvider>(builder: (context, ticketProvider, child) {
      return Padding(
        padding: EdgeInsets.symmetric(
            vertical: width * 0.02, horizontal: width * 0.04),
        child: Column(
          crossAxisAlignment: ticketMessage.client!
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                if (ticketMessage.replyTicketMessageState == ViewState.busy &&
                    ticketMessage.isLocal!)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.0213),
                    child: SizedBox(
                        width: width * 0.04,
                        height: width * 0.04,
                        child: const CircularProgressIndicator(
                          color: brandMainColor,
                          strokeWidth: 2,
                        )),
                  ),
                if (ticketMessage.replyTicketMessageState == ViewState.failed &&
                    ticketMessage.isLocal!)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.0213),
                    child: RemoveIcon(
                      color: primaryErrorColor,
                      size: width * 0.0533,
                      onTap: () {
                        ticketProvider
                            .removeItemFromTicketMessage(ticketMessage);
                      },
                    ),
                  ),
                Expanded(
                  child: Stroke(
                    backgroundColor: ticketMessage.client! ? white : softGreen,
                    borderWidth: 1,
                    borderColor: ticketMessage.client! ? softBlue : green,
                    topRightRadius: width * 0.0266,
                    topLeftRadius: width * 0.0266,
                    bottomRightRadius:
                        ticketMessage.client! ? 0.0 : width * 0.0266,
                    bottomLeftRadius:
                        ticketMessage.client! ? width * 0.0266 : 0.0,
                    child: Padding(
                      padding: EdgeInsets.all(width * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ticketMessage.client!
                                  ? const ClientIcon(
                                      color: brandMainColor,
                                    )
                                  : const SupporterIcon(
                                      color: brandMainColor,
                                    ),
                              SizedBox(
                                width: width * 0.01,
                              ),
                              TextView(
                                text:
                                    '${ticketMessage.user?.fName} ${ticketMessage.user?.lName}',
                                size: 12,
                                color: brandMainColor,
                                fontWeight: FontWeight.w700,
                              )
                            ],
                          ),
                          SizedBox(
                            height: width * 0.02,
                          ),
                          TextView(
                            text: ticketMessage.reply ?? '',
                            size: 14,
                            color: brandMainColor,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(
                            height: width * 0.02,
                          ),
                          if (ticketMessage.attachment != null &&
                              ticketMessage.attachment!.isNotEmpty)
                            AttachmentShowingTicketMessage(
                              image: ticketMessage.attachment!,
                              isLocal: ticketMessage.isLocal!,
                              imageByte: ticketMessage.attachmentUInt8List,
                            )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: width * 0.0213,
            ),
            Align(
                alignment: ticketMessage.client!
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: TextView(
                  text: '${ticketMessage.date} | ${ticketMessage.time}',
                  size: 13,
                  color: midGreyColor,
                ))
          ],
        ),
      );
    });
  }
}
