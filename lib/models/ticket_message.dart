import 'dart:typed_data';

import 'package:ticket_module/enums/view_state.dart';
import 'package:ticket_module/models/user.dart';

/// Every Ticket has a list of [TicketMessage]
class TicketMessage {
  /// id
  int? ticketId;

  /// the reply message of that ticket message
  String? reply;

  /// the user who has provided this ticket message
  User? user;

  /// if the client is true, it means that the user has made this
  /// ticket message but if not, the supporter has done
  bool? client;

  /// attachment refers to the image that the user or the supporter provides
  String? attachment;

  /// this is just for local showing
  Uint8List? attachmentUInt8List;

  /// date of that, the ticket message is created
  String? date;

  /// time of that, the ticket message is created
  String? time;

  /// isLocal is for when we create a new reply and we
  /// want to add it locally until when it is completely sent its request
  /// to the server
  bool? isLocal;

  /// the request state of ticket message
  ViewState? replyTicketMessageState;

  TicketMessage(
      {this.ticketId,
      this.reply,
      this.user,
      this.client,
      this.attachment = '',
      this.attachmentUInt8List,
      this.date,
      this.time,
      this.isLocal = false,
      this.replyTicketMessageState = ViewState.preparing});

  TicketMessage.fromJson(Map<String, dynamic> json) {
    ticketId = json['ticket_id'];
    reply = json['reply'];
    user = User.fromJson(json['user']);
    client = json['client'];
    var imageList = json['attachments']['data'] as List;
    if (imageList.isNotEmpty) {
      attachment = imageList.first['path'];
    } else {
      attachment = '';
    }
    date = json['date'];
    time = json['time'];
    isLocal = false;
  }
}

/// we have provided a mock of ticketMessages. you may ask why I click on every
/// ticket all of the ticket message's ticket are the same. yeah you're right.
/// they should not be the same but we have provided a sample for all of the tickets
/// this means that your ticket message model should be like this, or you can change
/// this model according to your need.
var ticketMessageMock = {
  "data": [
    {
      "ticket_id": 1,
      "reply": "Hello, your ticket is currently under review.",
      "user": {
        "id": 5,
        "email": "sara@gmail.com",
        "firstname": "Sara",
        "lastname": "Mohammadi",
      },
      "client": false,
      "attachments": {"data": []},
      "date": "2023-04-26",
      "time": "05:00"
    },
    {
      "ticket_id": 2,
      "reply":
          "Thanks.please let me know as soon as there is an update on my ticket.",
      "user": {
        "id": 5,
        "email": "amirali007z@yahoo.com",
        "firstname": "Amirali",
        "lastname": "Janani",
        "phone": "09198102346",
      },
      "client": true,
      "attachments": {"data": []},
      "date": "2023-04-26",
      "time": "05:05"
    },
    {
      "ticket_id": 3,
      "reply":
          "By the way, I am sending a photo to help you better understand my point.",
      "user": {
        "id": 5,
        "email": "amirali007z@yahoo.com",
        "firstname": "Amirali",
        "lastname": "Janani",
        "phone": "09198102346",
      },
      "client": true,
      "attachments": {
        "data": [
          {
            "path":
                "https://thumbs.dreamstime.com/z/stock-vector-error-message-computer-isolated-white-background-png-file-stock-vector-error-message-computer-isolated-white-131481609.jpg"
          }
        ]
      },
      "date": "2023-04-26",
      "time": "09:48"
    },
    {
      "ticket_id": 4,
      "reply": "Please don't worry, we are currently reviewing your request.",
      "user": {
        "id": 5,
        "email": "sara@gmail.com",
        "firstname": "Sara",
        "lastname": "Mohammadi",
      },
      "client": false,
      "attachments": {"data": []},
      "date": "2023-04-26",
      "time": "09:56"
    },
    {
      "ticket_id": 5,
      "reply":
          "Dear user, your issue has been resolved. Please check and confirm.",
      "user": {
        "id": 5,
        "email": "sara@gmail.com",
        "firstname": "Sara",
        "lastname": "Mohammadi",
      },
      "client": false,
      "attachments": {"data": []},
      "date": "2023-04-26",
      "time": "11:39"
    },
    {
      "ticket_id": 6,
      "reply": "Thank you so much,I'll check as soon as possible",
      "user": {
        "id": 5,
        "email": "amirali007z@yahoo.com",
        "firstname": "Amirali",
        "lastname": "Janani",
        "phone": "09198102346",
      },
      "client": true,
      "attachments": {"data": []},
      "date": "2023-04-26",
      "time": "12:44"
    },
  ],
  "status": "success",
  "message": "messages",
  "ticket": {
    "id": 1,
    "title": "Problem in the User Panel",
    "body":
        "Hello, good morning. I am having an issue with the panel. Please investigate it.",
    "secret_body": "asdcsacasc",
    "attachments": {"data": []},
    "status": {
      "id": 1,
      "label": "Open(New)",
      "app_label": "Open(New)",
      "is_resolved": 0,
      "app_background_color": "#E6F5F4",
      "background_color": "#f44336",
      "app_color": "#006A62",
      "color": "#fff",
      "app_order": 1,
      "order": 1,
    },
    "priority": {
      "id": 1,
      "name": "Critical",
    },
    "department": {
      "id": 1,
      "title": "Technical Department",
      "status": "active",
      "type": "internal",
      "description": null,
    },
    "user": {
      "id": 1,
      "email": "amirali007z@yahoo.com",
      "firstname": "Amirali",
      "lastname": "Janani",
      "phone": "09198102346",
    },
    "date": "2023-04-26",
    "time": "05:00"
  }
};
