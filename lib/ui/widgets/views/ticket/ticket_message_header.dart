import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_module/generated/l10n.dart';
import 'package:ticket_module/providers/ticket_provider.dart';
import 'package:ticket_module/ui/shared/colors.dart';
import 'package:ticket_module/ui/shared/text_style.dart';

/// [TicketMessageHeader] contains ticket title, department and the time that it has been created
class TicketMessageHeader extends StatelessWidget {
  const TicketMessageHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Consumer<TicketProvider>(builder: (context, ticketProvider, child) {
      return Container(
        color: white,
        width: width,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: width * 0.005, horizontal: width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                maxLines: 2,
                text: TextSpan(
                  text: '${S.of(context).newTicketTitleText}: ',
                  style: robotoBoldStyle(14, midGreyColor, FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                        text: ticketProvider.selectedTicket != null
                            ? ticketProvider.selectedTicket!.title
                            : '',
                        style: robotoBoldStyle(
                            16, brandMainColor, FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(
                height: width * 0.01,
              ),
              RichText(
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                maxLines: 1,
                text: TextSpan(
                  text: '${S.of(context).departmentText}: ',
                  style: robotoBoldStyle(14, midGreyColor, FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                        text: ticketProvider.selectedTicket != null
                            ? ticketProvider.selectedTicket!.department!.title
                            : '',
                        style: robotoBoldStyle(
                            16, brandMainColor, FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(
                height: width * 0.02,
              ),
              RichText(
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                maxLines: 1,
                text: TextSpan(
                  text: '${S.of(context).createdTimeText}: ',
                  style: robotoBoldStyle(14, midGreyColor, FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                        text: ticketProvider.selectedTicket != null
                            ? ticketProvider.selectedTicket!.date!
                            : '',
                        style: robotoBoldStyle(
                            16, brandMainColor, FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
