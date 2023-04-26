import 'package:flutter/material.dart';
import 'package:ticket_module/enums/appbar_state.dart';
import 'package:ticket_module/locator.dart';
import 'package:ticket_module/services/navigation_service.dart';
import 'package:ticket_module/ui/shared/colors.dart';
import 'package:ticket_module/ui/widgets/blog.dart';
import 'package:ticket_module/ui/widgets/button/icon_button.dart';
import 'package:ticket_module/ui/widgets/text/text_view.dart';

class CustomTicketAppBar extends StatelessWidget {
  final AppBarState appBarState;
  final String title;
  final Widget? action;
  const CustomTicketAppBar({Key? key, required this.appBarState, required this.title, this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Stroke(
      backgroundColor: white,
      boxShadow:  [
        BoxShadow(
            color: firstShimmerColor!,
            blurRadius: 10.0,
            offset: const Offset(0.0, 5.0)
        )
      ],
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: width * 0.04,horizontal: width * 0.03),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Row(
              children: [
                if(appBarState != AppBarState.none)
                  appBarState == AppBarState.backing ? ArrowBackIcon(onTap: ()=> locator<NavigationService>().goBack()) : CloseIcon(onTap: ()=> locator<NavigationService>().goBack()),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: width * 0.0266),
                  child: TextView(text: title, size: 16, fontWeight: FontWeight.w700,),
                ),
              ],
            ),
            if(action != null)
              action!
          ],
        ),
      ),
    );
  }
}
