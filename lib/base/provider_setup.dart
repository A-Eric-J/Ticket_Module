import 'package:ticket_module/providers/image_picker_provider.dart';
import 'package:ticket_module/providers/ticket_provider.dart';
import 'package:ticket_module/services/cookie_service.dart';
import 'package:ticket_module/services/web_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

/// provider_setup initializes the providers that are using in this app

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
];
List<SingleChildWidget> independentServices = [
  Provider.value(value: CookieService()),
  ListenableProvider.value(value: TicketProvider()),
  ListenableProvider.value(value: ImagePickerProvider()),
];

List<SingleChildWidget> dependentServices = [
  ProxyProvider<CookieService, WebService>(
    update: (context, cookieService, webService) => webService == null
        ? WebService(
            cookieService: cookieService,
          )
        : webService.setDependencies(cookieService),
    create: (context) => WebService(),
  ),
];
