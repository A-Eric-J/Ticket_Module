import 'package:ticket_module/const_values/route_paths.dart';
import 'package:ticket_module/ui/views/ticket/new_ticket_screen.dart';
import 'package:ticket_module/ui/views/ticket/ticket_message.dart';
import 'package:ticket_module/ui/views/ticket/ticket_screen.dart';

import 'package:ticket_module/ui/widgets/text/text_view.dart';
import 'package:flutter/material.dart';

/// All the Routes for navigating are placed here
class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.ticketScreen:
        return MaterialPageRoute(builder: (_) => const TicketScreen());
      case RoutePaths.newTicketScreen:
        return MaterialPageRoute(builder: (_) => const NewTicketScreen());
      case RoutePaths.ticketMessageScreen:
        var ticketId = settings.arguments as int;
        return MaterialPageRoute(
            builder: (_) => TicketMessage(
                  ticketId: ticketId,
                ));

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: TextView(
                      text: 'No route defined for ${settings.name}',
                      size: 16,
                    ),
                  ),
                ));
    }
  }
}
