import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_module/providers/ticket_provider.dart';
import 'package:ticket_module/ui/widgets/views/ticket/ticket_message_list_item.dart';

class TicketMessageList extends StatefulWidget {
  const TicketMessageList({Key? key}) : super(key: key);

  @override
  State<TicketMessageList> createState() => _TicketMessageListState();
}

class _TicketMessageListState extends State<TicketMessageList> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Consumer<TicketProvider>(builder: (context, ticketProvider, child) {
      return SizedBox(
        width: width,
        child: ListView.builder(
            padding: const EdgeInsets.all(0.0),
            shrinkWrap: true,
            itemCount: ticketProvider.ticketMessageList.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return TicketMessageListItem(
                ticketMessage: ticketProvider.ticketMessageList[index],
              );
            }),
      );
    });
  }
}
