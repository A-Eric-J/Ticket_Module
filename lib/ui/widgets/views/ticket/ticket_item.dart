import 'package:flutter/material.dart';
import 'package:ticket_module/const_values/route_paths.dart';
import 'package:ticket_module/locator.dart';
import 'package:ticket_module/models/ticket.dart';
import 'package:ticket_module/services/navigation_service.dart';
import 'package:ticket_module/ui/shared/colors.dart';
import 'package:ticket_module/ui/widgets/blog.dart';
import 'package:ticket_module/ui/widgets/text/text_view.dart';

/// [TicketItem] have title, date and status of the ticket
class TicketItem extends StatelessWidget {
  final Ticket ticket;
  final bool? hasHorizontalPadding;

  const TicketItem({Key? key, required this.ticket, this.hasHorizontalPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: width * 0.0133,
          horizontal: hasHorizontalPadding != null && hasHorizontalPadding!
              ? width * 0.04
              : 0.0),
      child: Stroke(
        width: width,
        radius: width * 0.0266,
        backgroundColor: white,
        onTap: () => locator<NavigationService>()
            .navigateTo(RoutePaths.ticketMessageScreen, arguments: ticket.id),
        child: Container(
          width: width,
          margin: EdgeInsets.all(width * 0.032),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(
                text: ticket.title ?? '',
                size: 16,
                color: ticket.status!.id == 3 ? midGreyColor : primaryDark,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(
                height: width * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  statusWidget(width),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextView(
                        text: ticket.date ?? '',
                        size: 12,
                        fontWeight: FontWeight.w700,
                        color: midGreyColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget statusWidget(double width) {
    return Stroke(
      /// Colors are coming from the json
      backgroundColor: Color(
          int.parse('0xFF${ticket.status!.backgroundColor!.split('#')[1]}')),
      radius: width * 0.02,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.04, vertical: width * 0.02),
        child: TextView(
          text: ticket.status!.label!,
          size: 12,
          fontWeight: FontWeight.bold,
          color: Color(
              int.parse('0xFF${ticket.status!.textColor!.split('#')[1]}')),
        ),
      ),
    );
  }
}
