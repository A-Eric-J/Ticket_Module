import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_module/const_values/assets.dart';
import 'package:ticket_module/const_values/route_paths.dart';
import 'package:ticket_module/enums/appbar_state.dart';
import 'package:ticket_module/enums/view_state.dart';
import 'package:ticket_module/generated/l10n.dart';
import 'package:ticket_module/locator.dart';
import 'package:ticket_module/providers/ticket_provider.dart';
import 'package:ticket_module/services/navigation_service.dart';
import 'package:ticket_module/services/ticket_service.dart';
import 'package:ticket_module/ui/shared/colors.dart';
import 'package:ticket_module/ui/widgets/blog.dart';
import 'package:ticket_module/ui/widgets/custom_refresh_indicator.dart';
import 'package:ticket_module/ui/widgets/text/text_view.dart';
import 'package:ticket_module/ui/extensions/widget_extension.dart';
import 'package:ticket_module/ui/widgets/views/ticket/custom_ticket_app_bar.dart';
import 'package:ticket_module/ui/widgets/views/ticket/ticket_items_list.dart';

/// You can see list of Tickets in [TicketScreen] and accessing to New Ticket button
class TicketScreen extends StatefulWidget {
  const TicketScreen({Key? key}) : super(key: key);

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  final _scrollController = ScrollController();
  TicketProvider? _ticketProvider;

  @override
  void initState() {
    _ticketProvider = Provider.of(context, listen: false);
    if (_ticketProvider!.ticketList.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        requestToServer();
      });
    }
    super.initState();
  }

  void requestToServer() {
    TicketService.getTickets(
      Provider.of(context, listen: false),
      Provider.of(context, listen: false),
    );
  }

  Future<void> refresh() async {
    requestToServer();
  }

  @override
  void dispose() {
    _ticketProvider!.clearTicketsList();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: mainBackgroundColor,
      body: SafeArea(
        child:
            Consumer<TicketProvider>(builder: (context, ticketProvider, child) {
          var emptyState = (ticketProvider.ticketViewState == ViewState.ready &&
              ticketProvider.ticketList.isEmpty);
          var failedState = ticketProvider.ticketViewState == ViewState.failed;

          return Column(
            children: [
              CustomTicketAppBar(
                appBarState: AppBarState.none,
                title: S.of(context).ticketsText,
                action: Stroke(
                    backgroundColor: softBlue,
                    radius: width * 0.02,
                    onTap: () => locator<NavigationService>().navigateTo(
                          RoutePaths.newTicketScreen,
                        ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.04, vertical: width * 0.01),
                      child: TextView(
                        text: S.of(context).newTicketText,
                        size: 14,
                        color: brandMainColor,
                        fontWeight: FontWeight.w700,
                      ),
                    )),
              ),
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: width * 0.03, horizontal: width * 0.04),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextView(
                            text: S.of(context).listOfTicketsText,
                            size: 15,
                            fontWeight: FontWeight.w500,
                            color: midGreyColor,
                          ),
                          TextView(
                            text:
                                '${ticketProvider.ticketList.length} ${S.of(context).ticketText}',
                            size: 15,
                            fontWeight: FontWeight.w500,
                            color: midGreyColor,
                          )
                        ],
                      ),
                    ),
                    failedState
                        ? PlaceHolderInFailedState(
                            refresh: refresh,
                            isExpanded: true,
                            pathPlaceHolder: Assets.emptyTicket,
                            isSvg: true)
                        : emptyState
                            ? PlaceHolderInEmptyState(
                                text: S.of(context).emptyMyTicketListText,
                                pathPlaceHolder: Assets.emptyTicket,
                                isSvg: true)
                            : Expanded(
                                child: CustomRefreshIndicator(
                                  onRefresh: () => refresh,
                                  child: SingleChildScrollView(
                                    controller: _scrollController,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: width * 0.0266),
                                      child: const TicketItemsList(
                                          hasHorizontalPadding: true),
                                    ),
                                  ),
                                ),
                              ),
                  ],
                ).withBusyOverlay(
                    ticketProvider.ticketViewState == ViewState.busy),
              )
            ],
          );
        }),
      ),
    );
  }
}
