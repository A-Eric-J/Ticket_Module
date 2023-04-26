import 'package:ticket_module/models/department.dart';
import 'package:ticket_module/models/priority.dart';
import 'package:ticket_module/models/status.dart';
import 'package:ticket_module/models/user.dart';

/// This is the model of [Ticket].
/// Every ticket has id, title, body, status, priority, department,
/// date, time and the user who has made this
class Ticket {
  int? id;
  String? title;
  String? body;
  Status? status;
  Priority? priority;
  Department? department;
  String? attachment;
  String? date;
  String? time;
  User? user;

  Ticket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    status = Status.fromJson(json['status']);
    priority = Priority.fromJson(json['priority']);
    department = Department.fromJson(json['department']);
    date = json['date'];
    time = json['time'];
    user = User.fromJson(json['user']);
    if (json['attachments'] != null) {
      var imageList = json['attachments']['data'] as List;
      if (imageList.isNotEmpty) {
        attachment = imageList.first['path'];
      }
    } else {
      attachment = '';
    }
  }
}

/// This is [ticketMock] that has 12 tickets for showing on TicketScreen
/// Note that, this is mock and this list should get from the server
var ticketMock = [
  {
    'id': 1,
    'title': 'Request to change phone number',
    "status": {
      "id": 1,
      "app_label": "Open(New)",
      "app_background_color": "#E6F5F4",
      "app_color": "#006A62",
    },
    "priority": {
      "id": 1,
      "name": "Critical",
    },
    "department": {
      "id": 1,
      "title": "Technical department",
    },
    "user": {
      "id": 2,
      "email": "amirali007z@yahoo.com",
      "first_name": "Amirali",
      "last_name": "Janani",
      "phone": "09198102346",
    },
    "attachments": {"data": []},
    "date": "2023-04-26",
    "time": "05:00"
  },
  {
    'id': 2,
    'title': 'Problem in selling the product',
    "status": {
      "id": 2,
      "app_label": "Pending",
      "app_background_color": "#E5EBFF",
      "app_color": "#3763FF",
    },
    "priority": {
      "id": 1,
      "name": "Critical",
    },
    "department": {
      "id": 1,
      "title": "Technical department",
    },
    "user": {
      "id": 2,
      "email": "amirali007z@yahoo.com",
      "first_name": "Amirali",
      "last_name": "Janani",
      "phone": "09198102346",
    },
    "attachments": {"data": []},
    "date": "2023-04-26",
    "time": "05:00"
  },
  {
    'id': 3,
    'title': 'Problem in buying the product',
    "status": {
      "id": 3,
      "app_label": "Closed",
      "app_background_color": "#F5F7FC",
      "app_color": "#919AA1",
    },
    "priority": {
      "id": 1,
      "name": "Critical",
    },
    "department": {
      "id": 1,
      "title": "Technical department",
    },
    "user": {
      "id": 2,
      "email": "amirali007z@yahoo.com",
      "first_name": "Amirali",
      "last_name": "Janani",
      "phone": "09198102346",
    },
    "attachments": {"data": []},
    "date": "2023-04-26",
    "time": "05:00"
  },
  {
    'id': 4,
    'title': 'Problem in receiving the product',
    "status": {
      "id": 4,
      "app_label": "Waiting for the user",
      "app_background_color": "#E5EBFF",
      "app_color": "#3763FF",
    },
    "priority": {
      "id": 1,
      "name": "Critical",
    },
    "department": {
      "id": 1,
      "title": "Technical department",
    },
    "user": {
      "id": 2,
      "email": "amirali007z@yahoo.com",
      "first_name": "Amirali",
      "last_name": "Janani",
      "phone": "09198102346",
    },
    "attachments": {"data": []},
    "date": "2023-04-26",
    "time": "05:00"
  },
  {
    'id': 5,
    'title': 'Request to change phone number',
    "status": {
      "id": 1,
      "app_label": "Open(New)",
      "app_background_color": "#E6F5F4",
      "app_color": "#006A62",
    },
    "priority": {
      "id": 1,
      "name": "Critical",
    },
    "department": {
      "id": 1,
      "title": "Technical department",
    },
    "user": {
      "id": 2,
      "email": "amirali007z@yahoo.com",
      "first_name": "Amirali",
      "last_name": "Janani",
      "phone": "09198102346",
    },
    "attachments": {"data": []},
    "date": "2023-04-26",
    "time": "05:00"
  },
  {
    'id': 6,
    'title': 'Problem in selling the product',
    "status": {
      "id": 2,
      "app_label": "Pending",
      "app_background_color": "#E5EBFF",
      "app_color": "#3763FF",
    },
    "priority": {
      "id": 1,
      "name": "Critical",
    },
    "department": {
      "id": 1,
      "title": "Technical department",
    },
    "user": {
      "id": 2,
      "email": "amirali007z@yahoo.com",
      "first_name": "Amirali",
      "last_name": "Janani",
      "phone": "09198102346",
    },
    "attachments": {"data": []},
    "date": "2023-04-26",
    "time": "05:00"
  },
  {
    'id': 7,
    'title': 'Problem in buying the product',
    "status": {
      "id": 3,
      "app_label": "Closed",
      "app_background_color": "#F5F7FC",
      "app_color": "#919AA1",
    },
    "priority": {
      "id": 1,
      "name": "Critical",
    },
    "department": {
      "id": 1,
      "title": "Technical department",
    },
    "user": {
      "id": 2,
      "email": "amirali007z@yahoo.com",
      "first_name": "Amirali",
      "last_name": "Janani",
      "phone": "09198102346",
    },
    "attachments": {"data": []},
    "date": "2023-04-26",
    "time": "05:00"
  },
  {
    'id': 8,
    'title': 'Problem in receiving the product',
    "status": {
      "id": 4,
      "app_label": "Waiting for the user",
      "app_background_color": "#E5EBFF",
      "app_color": "#3763FF",
    },
    "priority": {
      "id": 1,
      "name": "Critical",
    },
    "department": {
      "id": 1,
      "title": "Technical department",
    },
    "user": {
      "id": 2,
      "email": "amirali007z@yahoo.com",
      "first_name": "Amirali",
      "last_name": "Janani",
      "phone": "09198102346",
    },
    "attachments": {"data": []},
    "date": "2023-04-26",
    "time": "05:00"
  },
  {
    'id': 9,
    'title': 'Request to change phone number',
    "status": {
      "id": 1,
      "app_label": "Open(New)",
      "app_background_color": "#E6F5F4",
      "app_color": "#006A62",
    },
    "priority": {
      "id": 1,
      "name": "Critical",
    },
    "department": {
      "id": 1,
      "title": "Technical department",
    },
    "user": {
      "id": 2,
      "email": "amirali007z@yahoo.com",
      "first_name": "Amirali",
      "last_name": "Janani",
      "phone": "09198102346",
    },
    "attachments": {"data": []},
    "date": "2023-04-26",
    "time": "05:00"
  },
  {
    'id': 10,
    'title': 'Problem in receiving the product',
    "status": {
      "id": 4,
      "app_label": "Waiting for the user",
      "app_background_color": "#E5EBFF",
      "app_color": "#3763FF",
    },
    "priority": {
      "id": 1,
      "name": "Critical",
    },
    "department": {
      "id": 1,
      "title": "Technical department",
    },
    "user": {
      "id": 2,
      "email": "amirali007z@yahoo.com",
      "first_name": "Amirali",
      "last_name": "Janani",
      "phone": "09198102346",
    },
    "attachments": {"data": []},
    "date": "2023-04-26",
    "time": "05:00"
  },
  {
    'id': 11,
    'title': 'Problem in buying the product',
    "status": {
      "id": 3,
      "app_label": "Closed",
      "app_background_color": "#F5F7FC",
      "app_color": "#919AA1",
    },
    "priority": {
      "id": 1,
      "name": "Critical",
    },
    "department": {
      "id": 1,
      "title": "Technical department",
    },
    "user": {
      "id": 2,
      "email": "amirali007z@yahoo.com",
      "first_name": "Amirali",
      "last_name": "Janani",
      "phone": "09198102346",
    },
    "attachments": {"data": []},
    "date": "2023-04-26",
    "time": "05:00"
  },
  {
    'id': 12,
    'title': 'Problem in buying the product',
    "status": {
      "id": 3,
      "app_label": "Closed",
      "app_background_color": "#F5F7FC",
      "app_color": "#919AA1",
    },
    "priority": {
      "id": 1,
      "name": "Critical",
    },
    "department": {
      "id": 1,
      "title": "Technical department",
    },
    "user": {
      "id": 2,
      "email": "amirali007z@yahoo.com",
      "first_name": "Amirali",
      "last_name": "Janani",
      "phone": "09198102346",
    },
    "attachments": {"data": []},
    "date": "2023-04-26",
    "time": "05:00"
  },
];
