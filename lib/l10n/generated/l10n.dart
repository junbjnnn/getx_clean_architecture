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

  /// `An error occurred during processing. Please try again later`
  String get common_error_message {
    return Intl.message(
      'An error occurred during processing. Please try again later',
      name: 'common_error_message',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get mailaddress {
    return Intl.message(
      'Email Address',
      name: 'mailaddress',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Email address is required, please enter.`
  String get empty_email_error_message {
    return Intl.message(
      'Email address is required, please enter.',
      name: 'empty_email_error_message',
      desc: '',
      args: [],
    );
  }

  /// `The network is offline. Please connect to the Internet and try again.`
  String get network_error {
    return Intl.message(
      'The network is offline. Please connect to the Internet and try again.',
      name: 'network_error',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection.`
  String get server_error_message {
    return Intl.message(
      'No internet connection.',
      name: 'server_error_message',
      desc: '',
      args: [],
    );
  }

  /// `Internal service error.`
  String get s_0001 {
    return Intl.message(
      'Internal service error.',
      name: 's_0001',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get try_again {
    return Intl.message(
      'Retry',
      name: 'try_again',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Vietnamese`
  String get vietnamese {
    return Intl.message(
      'Vietnamese',
      name: 'vietnamese',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Email sent`
  String get email_sent {
    return Intl.message(
      'Email sent',
      name: 'email_sent',
      desc: '',
      args: [],
    );
  }

  /// `Email has been sent. Please check your mailbox.`
  String get email_sent_desc {
    return Intl.message(
      'Email has been sent. Please check your mailbox.',
      name: 'email_sent_desc',
      desc: '',
      args: [],
    );
  }

  /// `That email address is invalid!`
  String get that_email_address_is_invalid {
    return Intl.message(
      'That email address is invalid!',
      name: 'that_email_address_is_invalid',
      desc: '',
      args: [],
    );
  }

  /// `Can not open Url`
  String get cannot_open_url {
    return Intl.message(
      'Can not open Url',
      name: 'cannot_open_url',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get reset_password {
    return Intl.message(
      'Reset Password',
      name: 'reset_password',
      desc: '',
      args: [],
    );
  }

  /// `We will send you an email with a link to change your password.`
  String get we_will_send_you_an_email_with_a_link_to_change_your_password {
    return Intl.message(
      'We will send you an email with a link to change your password.',
      name: 'we_will_send_you_an_email_with_a_link_to_change_your_password',
      desc: '',
      args: [],
    );
  }

  /// `Send Email`
  String get send_email {
    return Intl.message(
      'Send Email',
      name: 'send_email',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Use`
  String get terms {
    return Intl.message(
      'Terms of Use',
      name: 'terms',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get policy {
    return Intl.message(
      'Privacy Policy',
      name: 'policy',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get login {
    return Intl.message(
      'Log in',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `I forgot my password`
  String get forgot_password {
    return Intl.message(
      'I forgot my password',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Please enter correct email address`
  String get notification_mailaddress {
    return Intl.message(
      'Please enter correct email address',
      name: 'notification_mailaddress',
      desc: '',
      args: [],
    );
  }

  /// `Please enter at least 8 characters `
  String get max_length_password_error_message {
    return Intl.message(
      'Please enter at least 8 characters ',
      name: 'max_length_password_error_message',
      desc: '',
      args: [],
    );
  }

  /// `Please enter email within 128 characters`
  String get max_length_email_error_message {
    return Intl.message(
      'Please enter email within 128 characters',
      name: 'max_length_email_error_message',
      desc: '',
      args: [],
    );
  }

  /// `Password is required, please enter.`
  String get empty_password_error_message {
    return Intl.message(
      'Password is required, please enter.',
      name: 'empty_password_error_message',
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
      Locale.fromSubtags(languageCode: 'vi'),
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
