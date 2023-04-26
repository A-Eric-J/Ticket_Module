import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ticket_module/enums/appbar_state.dart';
import 'package:ticket_module/enums/view_state.dart';
import 'package:ticket_module/generated/l10n.dart';
import 'package:ticket_module/providers/image_picker_provider.dart';
import 'package:ticket_module/providers/ticket_provider.dart';
import 'package:ticket_module/services/ticket_service.dart';
import 'package:ticket_module/ui/shared/colors.dart';
import 'package:ticket_module/ui/extensions/widget_extension.dart';
import 'package:ticket_module/ui/widgets/views/ticket/custom_ticket_app_bar.dart';
import 'package:ticket_module/ui/widgets/views/ticket/ticket_message_footer.dart';
import 'package:ticket_module/ui/widgets/views/ticket/ticket_message_header.dart';
import 'package:ticket_module/ui/widgets/views/ticket/ticket_message_list.dart';

/// [TicketMessage] contains all the replies and etc to the ticket
/// we use pull_to_refresh for refreshing the screen from the bottom
class TicketMessage extends StatefulWidget {
  final int ticketId;

  const TicketMessage({Key? key, required this.ticketId}) : super(key: key);

  @override
  State<TicketMessage> createState() => _TicketMessageState();
}

class _TicketMessageState extends State<TicketMessage> {
  TicketProvider? _ticketProvider;
  ImagePickerProvider? _imagePickerProvider;
  ScrollController? _scrollController;
  RefreshController? _refreshController;

  @override
  void initState() {
    _ticketProvider = Provider.of(context, listen: false);
    _imagePickerProvider = Provider.of(context, listen: false);
    _refreshController = RefreshController(initialRefresh: false);
    _scrollController = ScrollController(initialScrollOffset: 0.0);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      requestToServer();
    });
    super.initState();
  }

  Future<void> requestToServer() async {
    await TicketService.getTicketMessage(
        Provider.of(context, listen: false), _ticketProvider!, widget.ticketId);
  }

  Future<void> refresh() async {
    await requestToServer();
    _refreshController!.refreshCompleted();
  }

  @override
  void dispose() {
    _ticketProvider!.ticketMessageClear();
    _scrollController!.dispose();
    _refreshController!.dispose();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _imagePickerProvider!.ticketImageClear();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: mainBackgroundColor,
      body: SafeArea(
        child:
            Consumer<TicketProvider>(builder: (context, ticketProvider, child) {
          var readyState = ticketProvider.selectedTicket != null &&
              ticketProvider.ticketMessageState == ViewState.ready;
          log('ticketProvider.ticketMessageList.length: ${ticketProvider.ticketMessageList.length}');
          return Stack(
            children: [
              SizedBox(
                width: width,
                height: height - topPadding,
                child: Container().withBusyOverlay(!readyState),
              ),
              if (readyState)
                Column(
                  children: [
                    Container(
                      height: width * 0.15,
                    ),
                    Expanded(
                        child: SmartRefresher(
                      controller: _refreshController!,
                      onRefresh: () => refresh(),
                      reverse: ticketProvider.ticketMessageList.length >= 4
                          ? true
                          : false,
                      child: SingleChildScrollView(
                          controller: _scrollController,
                          reverse: true,
                          child: Column(
                            children: [
                              SizedBox(
                                height: width * 0.02,
                              ),
                              const TicketMessageHeader(),
                              SizedBox(
                                height: width * 0.02,
                              ),
                              const TicketMessageList(),
                            ],
                          )),
                    )),
                    const TickerMessageFooter()
                  ],
                ),
              CustomTicketAppBar(
                  appBarState: AppBarState.backing,
                  title: S.of(context).ticketText),
            ],
          );
        }),
      ),
    );
  }
}
