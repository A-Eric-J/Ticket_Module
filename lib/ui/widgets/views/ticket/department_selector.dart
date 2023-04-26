import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_module/generated/l10n.dart';
import 'package:ticket_module/locator.dart';
import 'package:ticket_module/providers/ticket_provider.dart';
import 'package:ticket_module/services/navigation_service.dart';
import 'package:ticket_module/ui/shared/colors.dart';
import 'package:ticket_module/ui/widgets/button/button.dart';
import 'package:ticket_module/ui/widgets/text/text_view.dart';

class DepartmentSelector extends StatefulWidget {
  const DepartmentSelector({Key? key}) : super(key: key);

  @override
  State<DepartmentSelector> createState() => _DepartmentSelectorState();
}

class _DepartmentSelectorState extends State<DepartmentSelector> {
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
              TextView(text: S.of(context).departmentText, size: 16,),
              SizedBox(height: width * 0.0266,),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(0.0),
                itemCount:
                    ticketProvider.departmentList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:  EdgeInsets.symmetric(horizontal: width * 0.0426,vertical: width * 0.0266),
                    child: Column(
                      children: [
                        InkWell(
                          splashColor: transparent,
                          highlightColor: transparent,
                          onTap: (){
                            ticketProvider.setSelectedDepartment(ticketProvider.departmentList[index]);
                            locator<NavigationService>().goBack();
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              CustomRadioButton(value: ticketProvider.departmentList[index], groupValue: ticketProvider.selectedDepartment, onChanged: (department){
                              }),
                              SizedBox(width: width * 0.02,),
                              TextView(text: ticketProvider.departmentList[index].title!, size: 14),

                            ],
                          ),
                        ),
                        if(index != ticketProvider.departmentList.length - 1)
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
