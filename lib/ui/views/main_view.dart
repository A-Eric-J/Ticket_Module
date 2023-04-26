import 'package:flutter/material.dart';
import 'package:ticket_module/ui/views/ticket/ticket_screen.dart';

/// We have just [TicketScreen] in [MainView]
class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: TicketScreen(),
      ),
    );
  }
}
