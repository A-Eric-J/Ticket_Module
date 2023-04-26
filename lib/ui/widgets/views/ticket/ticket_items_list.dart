import 'package:flutter/material.dart';
import 'package:ticket_module/const_values/assets.dart';
import 'package:ticket_module/enums/view_state.dart';
import 'package:provider/provider.dart';
import 'package:ticket_module/providers/ticket_provider.dart';
import 'package:ticket_module/ui/widgets/views/ticket/ticket_item.dart';
import 'package:ticket_module/ui/widgets/views/ticket/ticket_item_in_busy_state.dart';

/// List of tickets
class TicketItemsList extends StatelessWidget {
  final bool hasSpaceInLastItem;
  final bool hasHorizontalPadding;

  const TicketItemsList(
      {Key? key,
      this.hasSpaceInLastItem = false,
      this.hasHorizontalPadding = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Consumer<TicketProvider>(builder: (context, ticketProvider, child) {
      bool shimmerState = (ticketProvider.ticketViewState == ViewState.busy);
      return SizedBox(
        width: width,
        child: ListView.builder(
            padding: const EdgeInsets.all(0.0),
            shrinkWrap: true,
            itemCount:
                shimmerState ? busyCounter : ticketProvider.ticketList.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var lastItem = ticketProvider.ticketList.length - 1 == index;

              return shimmerState
                  ? const TicketItemInBusyState()
                  : Padding(
                      padding:
                          EdgeInsets.only(bottom: lastItem ? width * 0.04 : 0),
                      child: TicketItem(
                        hasHorizontalPadding: hasHorizontalPadding,
                        ticket: ticketProvider.ticketList[index],
                      ),
                    );
            }),
      );
    });
  }
}
