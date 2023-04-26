import 'package:flutter/material.dart';
import 'package:ticket_module/enums/view_state.dart';
import 'package:ticket_module/models/department.dart';
import 'package:ticket_module/models/priority.dart';
import 'package:ticket_module/models/ticket.dart';
import 'package:ticket_module/models/ticket_message.dart';

/// [TicketProvider] is a provider that related to all the things about
/// ticketing and if you had another options you can add here too
class TicketProvider extends ChangeNotifier {
  ViewState _ticketViewState = ViewState.preparing;

  ViewState get ticketViewState => _ticketViewState;

  void setTicketViewState(ViewState state) {
    _ticketViewState = state;
    notifyListeners();
  }

  var _ticketList = <Ticket>[];

  List<Ticket> get ticketList => _ticketList;

  void setTicketList(List<Ticket> newTicketList) {
    _ticketList = newTicketList;
    notifyListeners();
  }

  void addTicketList(Ticket ticket) {
    _ticketList.add(ticket);
    notifyListeners();
  }

  void clearTicketsList() {
    _ticketList.clear();
  }

  var _departmentList = <Department>[];

  List<Department> get departmentList => _departmentList;

  void setDepartment(List<Department> newDepartmentList) {
    _departmentList = newDepartmentList;
    notifyListeners();
  }

  Department? _selectedDepartment;

  Department? get selectedDepartment => _selectedDepartment;

  void setSelectedDepartment(Department? newDepartment) {
    _selectedDepartment = newDepartment;
    notifyListeners();
  }

  ViewState _departmentState = ViewState.preparing;

  ViewState get departmentState => _departmentState;

  void setDepartmentState(ViewState state) {
    _departmentState = state;
    notifyListeners();
  }

  var _priorityList = <Priority>[];

  List<Priority> get priorityList => _priorityList;

  void setPriority(List<Priority> newPriorityList) {
    _priorityList = newPriorityList;
    notifyListeners();
  }

  Priority? _selectedPriority;

  Priority? get selectedPriority => _selectedPriority;

  void setSelectedPriority(Priority? newPriority) {
    _selectedPriority = newPriority;
    notifyListeners();
  }

  ViewState _priorityState = ViewState.preparing;

  ViewState get priorityState => _priorityState;

  void setPriorityState(ViewState state) {
    _priorityState = state;
    notifyListeners();
  }

  void cleanSelectedDepartmentAndSelectedPriority() {
    _selectedDepartment = null;
    _selectedPriority = null;
    notifyListeners();
  }

  var _ticketMessageList = <TicketMessage>[];

  List<TicketMessage> get ticketMessageList => _ticketMessageList;

  void setTicketMessage(List<TicketMessage> newTicketMessageList) {
    _ticketMessageList = newTicketMessageList;
    notifyListeners();
  }

  void addTicketMessage(TicketMessage newTicketMessage) {
    _ticketMessageList.add(newTicketMessage);
    notifyListeners();
  }

  void removeItemFromTicketMessage(TicketMessage ticketMessage) {
    _ticketMessageList.remove(ticketMessage);
    notifyListeners();
  }

  Ticket? _selectedTicket;

  Ticket? get selectedTicket => _selectedTicket;

  void setSelectedTicket(Ticket newSelectedTicket) {
    _selectedTicket = newSelectedTicket;
    notifyListeners();
  }

  ViewState _ticketMessageState = ViewState.preparing;

  ViewState get ticketMessageState => _ticketMessageState;

  void setTicketMessageState(ViewState state) {
    _ticketMessageState = state;
    notifyListeners();
  }

  void setReplyTicketMessageState(
      ViewState state, TicketMessage ticketMessage) {
    var index = _ticketMessageList
        .indexWhere((myTicketMessage) => myTicketMessage == ticketMessage);
    if (!index.isNegative) {
      _ticketMessageList[index].replyTicketMessageState = state;
    }
    notifyListeners();
  }

  void ticketMessageClear() {
    _ticketMessageList.clear();
    _selectedTicket = null;
    _ticketMessageState = ViewState.preparing;
  }
}
