import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:intl/intl.dart';
import 'package:ticket_module/enums/view_state.dart';
import 'package:ticket_module/models/department.dart';
import 'package:ticket_module/models/priority.dart';
import 'package:ticket_module/models/ticket.dart';
import 'package:ticket_module/models/ticket_message.dart';
import 'package:ticket_module/providers/image_picker_provider.dart';
import 'package:ticket_module/providers/ticket_provider.dart';
import 'package:ticket_module/services/web_service.dart';

/// [TicketService] is all services about ticketing Apis,
/// Note that we commented these, just to show you what's happening
/// here and how you can put your Apis here, we just fill our ticketProvider's datas
/// by mock
class TicketService {
  /// Getting all tickets
  static Future<void> getTickets(
    WebService webService,
    TicketProvider ticketProvider,
  ) async {
    ticketProvider.setTicketViewState(ViewState.busy);
    // var response = await webService.getFunction(URLs.ticketsUrl);
    // if (response.responseStatus == ResponseStatus.success) {
    //   var responseBody = response.body as Map<String,dynamic>;
    //   if (responseBody.isNotEmpty) {
    //     var tickets = <Ticket>[];
    //     for(var ticket in responseBody['tickets']){
    //       tickets.add(Ticket.fromJson(ticket));
    //     }
    //
    //     ticketProvider.setTicketList(tickets);
    //
    //   }
    var tickets = <Ticket>[];
    for (var ticket in ticketMock) {
      tickets.add(Ticket.fromJson(ticket));
    }
    ticketProvider.setTicketList(tickets);
    ticketProvider.setTicketViewState(ViewState.ready);
    // }  else {
    //    ticketProvider.setTicketViewState(ViewState.failed);
    // }
  }

  /// Getting Departments for sending ticket
  static Future<void> getDepartments(
    WebService webService,
    TicketProvider ticketProvider,
  ) async {
    ticketProvider.setDepartmentState(ViewState.busy);
    // var response = await webService.getFunction(URLs.getDepartments);
    // if (response.responseStatus == ResponseStatus.success) {
    //   var responseBody = response.body as Map<String,dynamic>;
    //   if (responseBody.isNotEmpty) {
    //     var departments = <Department>[];
    //     for(var department in responseBody['departments']){
    //       departments.add(Department.fromJson(department));
    //     }
    //
    //     ticketProvider.setDepartment(tickets);
    //
    //   }
    var departments = <Department>[];
    for (var department in departmentMock) {
      departments.add(Department.fromJson(department));
    }
    ticketProvider.setDepartment(departments);
    ticketProvider.setDepartmentState(ViewState.ready);
    // }  else {
    //    ticketProvider.setDepartmentState(ViewState.failed);
    // }
  }

  /// Getting Priorities for sending ticket
  static Future<void> getPriorities(
    WebService webService,
    TicketProvider ticketProvider,
  ) async {
    ticketProvider.setPriorityState(ViewState.busy);
    // var response = await webService.getFunction(URLs.getPriorities);
    // if (response.responseStatus == ResponseStatus.success) {
    //   var responseBody = response.body as Map<String,dynamic>;
    //   if (responseBody.isNotEmpty) {
    //     var priorities = <Priority>[];
    //     for(var priority in responseBody['priorities']){
    //       priorities.add(Priority.fromJson(priority));
    //     }
    //
    //     ticketProvider.setDepartment(tickets);
    //
    //   }
    var priorities = <Priority>[];
    for (var priority in priorityMock) {
      priorities.add(Priority.fromJson(priority));
    }
    ticketProvider.setPriority(priorities);
    ticketProvider.setPriorityState(ViewState.ready);
    // }  else {
    //    ticketProvider.setPriorityState(ViewState.failed);
    // }
  }

  /// Creating a NewTicket
  static Future<bool> createNewTicket(WebService webService,
      TicketProvider ticketProvider, Map<String, dynamic> body,
      {Department? department, Priority? priority}) async {
    ticketProvider.setTicketViewState(ViewState.busy);
    // var response = await webService.postMultiPartFunction(URLs.ticketsUrl);
    // if (response.responseStatus == ResponseStatus.success) {

    var now = DateTime.now();

    ///  this code below is for mock model testing
    Ticket ticket = Ticket.fromJson({
      'id': 5,
      'title': body['title'],
      "status": {
        "id": 1,
        "app_label": "Open(New)",
        "app_background_color": "#E6F5F4",
        "app_color": "#006A62",
      },
      "priority": {
        "id": priority!.id,
        "name": priority.name,
      },
      "department": {
        "id": department!.id,
        "title": department.title,
      },
      "user": {
        "id": 2,
        "email": "amirali007z@yahoo.com",
        "first_name": "Amirali",
        "last_name": "Janani",
        "phone": "09198102346",
      },
      "date": DateFormat('yyyy-MM-dd').format(now),
      "time": DateFormat('HH:mm').format(now)
    });

    ticketProvider.addTicketList(ticket);
    ticketProvider.setTicketViewState(ViewState.ready);
    return true;
    // }  else {
    //    ticketProvider.setTicketViewState(ViewState.failed);
    // return false;
    // }
  }

  static Future<void> getTicketMessage(
    WebService webService,
    TicketProvider ticketProvider,
    int ticketId,
  ) async {
    ticketProvider.setTicketMessageState(ViewState.busy);
    // var response = await webService.getFunction(URLs.ticketMessageUrl(ticketId));
    // if (response.responseStatus == ResponseStatus.success) {
    //   var responseBody = response.body as Map<String,dynamic>;
    //
    //   ticketProvider.setSelectedTicket(Ticket.fromJson(responseBody['ticket']));
    //   var ticketMessageList = <TicketMessage>[];
    //   for(var ticketMessage in responseBody['data']){
    //     ticketMessageList.add(TicketMessage.fromJson(ticketMessage));
    //   }
    //   ticketProvider.setTicketMessage(ticketMessageList);

    var ticket =
        Ticket.fromJson(ticketMessageMock['ticket'] as Map<String, dynamic>);
    ticketProvider.setSelectedTicket(ticket);
    var ticketMessageList = <TicketMessage>[];
    ticketMessageList.add(TicketMessage(
        ticketId: ticketId,
        reply: ticket.body,
        user: ticket.user,
        client: true,
        attachment: ticket.attachment,
        date: ticket.date,
        time: ticket.time));
    for (var ticketMessage in ticketMessageMock['data'] as List) {
      ticketMessageList.add(TicketMessage.fromJson(ticketMessage));
    }
    ticketProvider.setTicketMessage(ticketMessageList);
    ticketProvider.setTicketMessageState(ViewState.ready);
    // }  else {
    //    ticketProvider.setTicketMessageState(ViewState.failed);
    // }
  }

  static Future<bool> createNewReply(
    WebService webService,
    TicketProvider ticketProvider,
    ImagePickerProvider imagePickerProvider,
    Map<String, dynamic> body,
  ) async {
    var now = DateTime.now();
    var newTicketMessage = TicketMessage(
        ticketId: body['ticket_id'],
        reply: body['reply'],
        user: ticketProvider.selectedTicket!.user,
        client: true,
        attachmentUInt8List: kIsWeb
            ? imagePickerProvider.ticketByteFile!
            : imagePickerProvider.ticketPickedFile != null
                ? File(imagePickerProvider.ticketPickedFile!.path)
                    .readAsBytesSync()
                : null,
        attachment: imagePickerProvider.ticketByteFile != null ||
                imagePickerProvider.ticketPickedFile != null
            ? 'Uint8List'
            : '',
        date: DateFormat('yyyy-MM-dd').format(now),
        time: DateFormat('HH:mm').format(now),
        isLocal: true);
    ticketProvider.addTicketMessage(newTicketMessage);
    imagePickerProvider.ticketImageClear();
    ticketProvider.setReplyTicketMessageState(ViewState.busy, newTicketMessage);
    // var response = await webService.postMultiPartFunction(URLs.ticketsUrl);
    // if (response.responseStatus == ResponseStatus.success) {
    await Future.delayed(const Duration(seconds: 2));
    ticketProvider.setReplyTicketMessageState(
        ViewState.ready, newTicketMessage);
    return true;
    // }  else {
    //    ticketProvider.setReplyTicketMessageState(ViewState.failed);
    // return false;
    // }
  }
}
