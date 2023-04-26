import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_module/generated/l10n.dart';
import 'package:ticket_module/locator.dart';
import 'package:ticket_module/providers/ticket_provider.dart';
import 'package:ticket_module/services/navigation_service.dart';
import 'package:ticket_module/ui/shared/colors.dart';
import 'package:ticket_module/ui/widgets/button/button.dart';
import 'package:ticket_module/ui/widgets/text/text_view.dart';

class PrioritySelector extends StatefulWidget {
  const PrioritySelector({Key? key}) : super(key: key);

  @override
  State<PrioritySelector> createState() => _PrioritySelectorState();
}

class _PrioritySelectorState extends State<PrioritySelector> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Consumer<TicketProvider>(
      builder: (context, ticketProvider ,child) {
        return Padding(
          padding:  EdgeInsets.all(width * 0.0426),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(text: S.of(context).priorityText, size: 16,),
              SizedBox(height: width * 0.0266,),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(0.0),
                itemCount:
                    ticketProvider.priorityList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:  EdgeInsets.symmetric(horizontal: width * 0.0426,vertical: width * 0.0266),
                    child: Column(
                      children: [
                        InkWell(
                          splashColor: transparent,
                          highlightColor: transparent,
                          onTap: (){
                            ticketProvider.setSelectedPriority(ticketProvider.priorityList[index]);
                            locator<NavigationService>().goBack();
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              CustomRadioButton(value: ticketProvider.priorityList[index], groupValue: ticketProvider.selectedPriority, onChanged: (priority){
                              }),
                              SizedBox(width: width * 0.02,),
                              TextView(text: ticketProvider.priorityList[index].name!, size: 14),

                            ],
                          ),
                        ),
                        if(index != ticketProvider.priorityList.length - 1)
                        const Divider(
                          thickness: 2,
                        )
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        );
      }
    );
  }
}
