import 'dart:developer';

import 'package:ticket_module/ui/widgets/custom_modal.dart';
import 'package:ticket_module/ui/widgets/popUp_builder.dart';
import 'package:flutter/material.dart';

/// [NavigationService] is a service for navigating between pages or
/// showing modals or popUps and etc.
class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  NavigationService() {
    log('Navigation service initiated');
  }

  Future<dynamic> navigateTo(String routeName,
      {Object? arguments, pushReplacement = false}) {
    if (pushReplacement) {
      return navigatorKey.currentState!
          .pushReplacementNamed(routeName, arguments: arguments);
    }
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  void goBack() {
    navigatorKey.currentState!.pop();
  }

  void goBackUntilTheFirstRoute() {
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  var overlays = <OverlayEntry>[];

  void showPopUp(Widget child, BuildContext context,
      {bool closeOnBackgroundTap = true}) {
    final overlay =
        popUpWidgetBuilder(child, closeOnBackgroundTap ? closePopUp : null);
    overlays.add(overlay);
    Overlay.of(context)!.insert(overlay);
  }

  void showSnackBar(String text) {
    ScaffoldMessenger.of(navigatorKey.currentState!.context).showSnackBar(
      SnackBar(
        content: Text(text, textAlign: TextAlign.center),
      ),
    );
  }

  void closePopUp() {
    if (overlays.isNotEmpty) {
      overlays.last.remove();
      overlays.removeLast();
    }
  }

  void showModal(BuildContext context, Widget child,
      {bool isScrollControlled = false,
      bool shouldScroll = false,
      bool isDismissible = true}) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: isScrollControlled,
        isDismissible: isDismissible,
        context: context,
        builder: (builder) {
          return CustomModal(shouldScroll: shouldScroll, child: child);
        });
  }
}
