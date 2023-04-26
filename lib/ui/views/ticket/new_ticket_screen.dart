import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ticket_module/enums/appbar_state.dart';
import 'package:ticket_module/enums/view_state.dart';
import 'package:ticket_module/generated/l10n.dart';
import 'package:ticket_module/locator.dart';
import 'package:ticket_module/providers/image_picker_provider.dart';
import 'package:ticket_module/providers/ticket_provider.dart';
import 'package:ticket_module/services/navigation_service.dart';
import 'package:ticket_module/services/ticket_service.dart';
import 'package:ticket_module/ui/extensions/help_methods.dart';
import 'package:ticket_module/ui/shared/colors.dart';
import 'package:ticket_module/ui/widgets/blog.dart';
import 'package:ticket_module/ui/widgets/button/button.dart';
import 'package:ticket_module/ui/widgets/button/icon_button.dart';
import 'package:ticket_module/ui/widgets/custom_refresh_indicator.dart';
import 'package:ticket_module/ui/widgets/masked_text_controller.dart';
import 'package:ticket_module/ui/widgets/text/text_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_module/ui/widgets/textformfield/textformfield_item.dart';
import 'package:ticket_module/ui/widgets/views/ticket/custom_ticket_app_bar.dart';
import 'package:ticket_module/ui/widgets/views/ticket/department_selector.dart';
import 'package:ticket_module/ui/widgets/views/ticket/priority_selector.dart';
import 'package:ticket_module/ui/widgets/views/ticket/ticket_image.dart';
import 'package:ticket_module/ui/widgets/widget_in_busy_state.dart';
import 'package:http_parser/http_parser.dart';

/// In [NewTicketScreen] you should add title, ticket message, department, priority and if
/// you had an image to submit a ticket
class NewTicketScreen extends StatefulWidget {
  const NewTicketScreen({Key? key}) : super(key: key);

  @override
  State<NewTicketScreen> createState() => _NewTicketScreenState();
}

class _NewTicketScreenState extends State<NewTicketScreen> {
  TicketProvider? _ticketProvider;
  TextEditingController? titleTicketTextController;
  TextEditingController? bodyTextController;
  final _scrollController = ScrollController();
  ImagePickerProvider? _imagePickerProvider;

  @override
  void initState() {
    _ticketProvider = Provider.of(context, listen: false);
    _imagePickerProvider = Provider.of(context, listen: false);
    titleTicketTextController = MaskedTextController(mask: '*', length: 30);
    bodyTextController = MaskedTextController(mask: '*', length: 1000);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (_ticketProvider!.departmentList.isEmpty) {
        departmentRequestToServer();
      }
      if (_ticketProvider!.priorityList.isEmpty) {
        priorityRequestToServer();
      }
    });
    super.initState();
  }

  void departmentRequestToServer() {
    TicketService.getDepartments(
      Provider.of(context, listen: false),
      Provider.of(context, listen: false),
    );
  }

  void priorityRequestToServer() {
    TicketService.getPriorities(
      Provider.of(context, listen: false),
      Provider.of(context, listen: false),
    );
  }

  Future<void> refresh() async {
    departmentRequestToServer();
    priorityRequestToServer();
  }

  @override
  void dispose() {
    titleTicketTextController!.dispose();
    bodyTextController!.dispose();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _imagePickerProvider!.ticketImageClear();
      _ticketProvider!.cleanSelectedDepartmentAndSelectedPriority();
    });
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Consumer2<TicketProvider, ImagePickerProvider>(
            builder: (context, ticketProvider, imagePickerProvider, child) {
          return Column(
            children: [
              CustomTicketAppBar(
                appBarState: AppBarState.closing,
                title: S.of(context).newTicketText,
              ),
              Expanded(
                child: CustomRefreshIndicator(
                  onRefresh: () => refresh,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.0533),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: width * 0.1066,
                              ),
                              TextView(
                                text: S.of(context).insertTicketInformation,
                                size: 15,
                                fontWeight: FontWeight.w500,
                                color: midGreyColor,
                              ),
                              SizedBox(
                                height: width * 0.02,
                              ),
                              TextFormFieldItem(
                                textController: titleTicketTextController,
                                hintText: S.of(context).newTicketTitleText,
                                backgroundColor: bgBlue,
                                filled: true,
                                radius: width * 0.0266,
                                maxLines: 1,
                                onChanged: (value) {
                                  setState(() {
                                    buttonEnableFunc(
                                        value,
                                        bodyTextController!.text,
                                        ticketProvider);
                                  });
                                },
                              ),
                              SizedBox(
                                height: width * 0.04,
                              ),
                              Stroke(
                                radius: width * 0.0266,
                                backgroundColor: bgBlue,
                                borderColor: greyColor,
                                borderWidth: 2,
                                onTap: () {
                                  if (ticketProvider.departmentState ==
                                      ViewState.ready) {
                                    locator<NavigationService>().showModal(
                                        context, const DepartmentSelector());
                                  } else if (ticketProvider.departmentState ==
                                      ViewState.failed) {
                                    snackBar(
                                        S.of(context).somethingWentWrongText,
                                        context);
                                  }
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: width * 0.0213,
                                      horizontal: width * 0.04),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ticketProvider.departmentState ==
                                              ViewState.ready
                                          ? TextView(
                                              text: ticketProvider
                                                          .selectedDepartment !=
                                                      null
                                                  ? ticketProvider
                                                      .selectedDepartment!
                                                      .title!
                                                  : S
                                                      .of(context)
                                                      .departmentText,
                                              size: 14,
                                              color: greyColor,
                                            )
                                          : WidgetInBusyState(
                                              width: width * 0.2,
                                              height: width * 0.03,
                                              radius: width * 0.0266,
                                            ),
                                      const KeyboardArrowDownIcon()
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: width * 0.04,
                              ),
                              Stroke(
                                radius: width * 0.0266,
                                backgroundColor: bgBlue,
                                borderColor: greyColor,
                                borderWidth: 2,
                                onTap: () {
                                  if (ticketProvider.departmentState ==
                                      ViewState.ready) {
                                    locator<NavigationService>().showModal(
                                        context, const PrioritySelector());
                                  } else if (ticketProvider.departmentState ==
                                      ViewState.failed) {
                                    snackBar(
                                        S.of(context).somethingWentWrongText,
                                        context);
                                  }
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: width * 0.0213,
                                      horizontal: width * 0.04),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ticketProvider.priorityState ==
                                              ViewState.ready
                                          ? TextView(
                                              text:
                                                  ticketProvider
                                                              .selectedPriority !=
                                                          null
                                                      ? ticketProvider
                                                          .selectedPriority!
                                                          .name!
                                                      : S
                                                          .of(context)
                                                          .priorityText,
                                              size: 14,
                                              color: greyColor,
                                            )
                                          : WidgetInBusyState(
                                              width: width * 0.2,
                                              height: width * 0.03,
                                              radius: width * 0.0266,
                                            ),
                                      const KeyboardArrowDownIcon()
                                    ],
                                  ),
                                ),
                              ),
                              TextFormFieldItem(
                                textController: bodyTextController,
                                hintText: S.of(context).newTicketBodyText,
                                backgroundColor: bgBlue,
                                filled: true,
                                radius: width * 0.0266,
                                maxLines: 10,
                                minLines: null,
                                onChanged: (value) {
                                  setState(() {
                                    buttonEnableFunc(bodyTextController!.text,
                                        value, ticketProvider);
                                  });
                                },
                              ),
                              SizedBox(
                                height: width * 0.08,
                              ),
                              const Align(
                                  alignment: Alignment.center,
                                  child: TicketImage()),
                              SizedBox(
                                height: width * 0.08,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Stroke(
                backgroundColor: white,
                width: width,
                boxShadow: [
                  BoxShadow(
                      color: firstShimmerColor!,
                      blurRadius: 10.0,
                      offset: const Offset(5.0, 0.0))
                ],
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: width * 0.04, horizontal: width * 0.03),
                  child: RectAngleButton(
                    nameOfButton: S.of(context).ticketRegistrationButtonText,
                    onTap: () async {
                      if (buttonEnableFunc(titleTicketTextController!.text,
                          bodyTextController!.text, ticketProvider)) {
                        var result = await TicketService.createNewTicket(
                            Provider.of(context, listen: false),
                            ticketProvider,
                            {
                              "title": titleTicketTextController!.text,
                              "body": bodyTextController!.text,
                              "priority_id":
                                  ticketProvider.selectedPriority!.id,
                              "department_id":
                                  ticketProvider.selectedDepartment!.id,
                              if (imagePickerProvider.ticketPickedFile !=
                                      null ||
                                  imagePickerProvider.ticketByteFile != null)
                                "attachments": {
                                  "data": [
                                    {
                                      "path": MultipartFile.fromBytes(
                                          kIsWeb
                                              ? imagePickerProvider
                                                  .ticketByteFile!
                                              : File(imagePickerProvider.ticketPickedFile!.path)
                                                  .readAsBytesSync(),
                                          contentType: MediaType(
                                              'file',
                                              imagePickerProvider.fileName(
                                                  kIsWeb
                                                      ? imagePickerProvider
                                                          .ticketByteFile!
                                                      : File(imagePickerProvider
                                                              .ticketPickedFile!
                                                              .path)
                                                          .readAsBytesSync(),
                                                  '',
                                                  true)),
                                          filename: imagePickerProvider.fileName(
                                              kIsWeb
                                                  ? imagePickerProvider
                                                      .ticketByteFile!
                                                  : File(imagePickerProvider.ticketPickedFile!.path).readAsBytesSync(),
                                              imagePickerProvider.imageName(),
                                              false))
                                    }
                                  ]
                                },
                            },
                            department: ticketProvider.selectedDepartment,
                            priority: ticketProvider.selectedPriority);
                        if (result) {
                          locator<NavigationService>().goBack();
                        } else {
                          if (!mounted) return;
                          snackBar(
                              S.of(context).somethingWentWrongText, context);
                        }
                      }
                    },
                    state: ViewState.ready,
                    color: buttonEnableFunc(titleTicketTextController!.text,
                            bodyTextController!.text, ticketProvider)
                        ? brandMainColor
                        : greyColor,
                    insidePadding: EdgeInsets.symmetric(vertical: width * 0.03),
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  bool buttonEnableFunc(
      String title, String body, TicketProvider ticketProvider) {
    if (title.isNotEmpty &&
        ticketProvider.selectedDepartment != null &&
        ticketProvider.selectedPriority != null &&
        body.isNotEmpty &&
        body.length >= 10) {
      return true;
    } else {
      return false;
    }
  }
}
