import 'package:flutter/material.dart';
import 'package:ticket_module/ui/shared/colors.dart';
import 'package:ticket_module/ui/widgets/blog.dart';
import 'package:ticket_module/ui/widgets/widget_in_busy_state.dart';

/// [TicketItemInBusyState] is TicketItem in busy state
class TicketItemInBusyState extends StatelessWidget {
  const TicketItemInBusyState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.all(width * 0.032),
      child: Stroke(
        width: width,
        radius: width * 0.0266,
        backgroundColor: white,
        child: Container(
          width: width,
          margin: EdgeInsets.all(width * 0.032),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WidgetInBusyState(
                height: width * 0.0266,
                width: width * 0.4,
                radius: width * 0.016,
              ),
              SizedBox(
                height: width * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  WidgetInBusyState(
                    height: width * 0.0266,
                    width: width * 0.2,
                    radius: width * 0.0266,
                  ),
                  WidgetInBusyState(
                    height: width * 0.08,
                    width: width * 0.18,
                    radius: width * 0.0266,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
