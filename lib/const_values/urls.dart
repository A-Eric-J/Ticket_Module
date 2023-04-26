import 'package:ticket_module/const_values/config.dart';

/// URLs refers to all the endpoints that are using in this app
/// Note that these are mock and unReal, but you can paste yours here

class URLs {

  static const ticketsUrl = '${baseUrl}tickets';
  static const getDepartments = '${baseUrl}tickets/departments';
  static const getPriorities    = '${baseUrl}tickets/priorities';
  static  ticketMessageUrl(int id) => '${baseUrl}tickets/ticket/$id/messages';
  static const ticketReplyUrl = '${baseUrl}tickets/reply';

}
