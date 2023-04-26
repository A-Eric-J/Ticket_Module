// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Tickets`
  String get ticketsText {
    return Intl.message(
      'Tickets',
      name: 'ticketsText',
      desc: '',
      args: [],
    );
  }

  /// `Ticket`
  String get ticketText {
    return Intl.message(
      'Ticket',
      name: 'ticketText',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get closeText {
    return Intl.message(
      'Close',
      name: 'closeText',
      desc: '',
      args: [],
    );
  }

  /// `New Ticket`
  String get newTicketText {
    return Intl.message(
      'New Ticket',
      name: 'newTicketText',
      desc: '',
      args: [],
    );
  }

  /// `Tickets List`
  String get listOfTicketsText {
    return Intl.message(
      'Tickets List',
      name: 'listOfTicketsText',
      desc: '',
      args: [],
    );
  }

  /// `No Ticket Found!`
  String get emptyMyTicketListText {
    return Intl.message(
      'No Ticket Found!',
      name: 'emptyMyTicketListText',
      desc: '',
      args: [],
    );
  }

  /// `Insert Ticket Information`
  String get insertTicketInformation {
    return Intl.message(
      'Insert Ticket Information',
      name: 'insertTicketInformation',
      desc: '',
      args: [],
    );
  }

  /// `Ticket Title`
  String get newTicketTitleText {
    return Intl.message(
      'Ticket Title',
      name: 'newTicketTitleText',
      desc: '',
      args: [],
    );
  }

  /// `Ticket Message`
  String get newTicketBodyText {
    return Intl.message(
      'Ticket Message',
      name: 'newTicketBodyText',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get fromGalleryText {
    return Intl.message(
      'Gallery',
      name: 'fromGalleryText',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get fromCameraText {
    return Intl.message(
      'Camera',
      name: 'fromCameraText',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get deleteText {
    return Intl.message(
      'Delete',
      name: 'deleteText',
      desc: '',
      args: [],
    );
  }

  /// `Select Image`
  String get selectImageText {
    return Intl.message(
      'Select Image',
      name: 'selectImageText',
      desc: '',
      args: [],
    );
  }

  /// `Update Image`
  String get editImageText {
    return Intl.message(
      'Update Image',
      name: 'editImageText',
      desc: '',
      args: [],
    );
  }

  /// `Please insert an image if you had`
  String get pleaseAddImageTicketText {
    return Intl.message(
      'Please insert an image if you had',
      name: 'pleaseAddImageTicketText',
      desc: '',
      args: [],
    );
  }

  /// `Department`
  String get departmentText {
    return Intl.message(
      'Department',
      name: 'departmentText',
      desc: '',
      args: [],
    );
  }

  /// `Submit Ticket`
  String get ticketRegistrationButtonText {
    return Intl.message(
      'Submit Ticket',
      name: 'ticketRegistrationButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Priority`
  String get priorityText {
    return Intl.message(
      'Priority',
      name: 'priorityText',
      desc: '',
      args: [],
    );
  }

  /// `Created Time`
  String get createdTimeText {
    return Intl.message(
      'Created Time',
      name: 'createdTimeText',
      desc: '',
      args: [],
    );
  }

  /// `Send Message`
  String get submitTicketMessageText {
    return Intl.message(
      'Send Message',
      name: 'submitTicketMessageText',
      desc: '',
      args: [],
    );
  }

  /// `Attachment`
  String get attachmentText {
    return Intl.message(
      'Attachment',
      name: 'attachmentText',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong!`
  String get somethingWentWrongText {
    return Intl.message(
      'Something went wrong!',
      name: 'somethingWentWrongText',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get tryAgainText {
    return Intl.message(
      'Try Again',
      name: 'tryAgainText',
      desc: '',
      args: [],
    );
  }

  /// `List is empty`
  String get emptinessText {
    return Intl.message(
      'List is empty',
      name: 'emptinessText',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
