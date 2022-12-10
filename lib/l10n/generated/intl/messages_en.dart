// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "cannot_open_url":
            MessageLookupByLibrary.simpleMessage("Can not open Url"),
        "common_error_message": MessageLookupByLibrary.simpleMessage(
            "An error occurred during processing. Please try again later"),
        "email_sent": MessageLookupByLibrary.simpleMessage("Email sent"),
        "email_sent_desc": MessageLookupByLibrary.simpleMessage(
            "Email has been sent. Please check your mailbox."),
        "empty_email_error_message": MessageLookupByLibrary.simpleMessage(
            "Email address is required, please enter."),
        "empty_password_error_message": MessageLookupByLibrary.simpleMessage(
            "Password is required, please enter."),
        "english": MessageLookupByLibrary.simpleMessage("English"),
        "error": MessageLookupByLibrary.simpleMessage("Error"),
        "forgot_password":
            MessageLookupByLibrary.simpleMessage("I forgot my password"),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "login": MessageLookupByLibrary.simpleMessage("Log in"),
        "mailaddress": MessageLookupByLibrary.simpleMessage("Email Address"),
        "max_length_email_error_message": MessageLookupByLibrary.simpleMessage(
            "Please enter email within 128 characters"),
        "max_length_password_error_message":
            MessageLookupByLibrary.simpleMessage(
                "Please enter at least 8 characters "),
        "network_error": MessageLookupByLibrary.simpleMessage(
            "The network is offline. Please connect to the Internet and try again."),
        "no": MessageLookupByLibrary.simpleMessage("No"),
        "notification_mailaddress": MessageLookupByLibrary.simpleMessage(
            "Please enter correct email address"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "policy": MessageLookupByLibrary.simpleMessage("Privacy Policy"),
        "register": MessageLookupByLibrary.simpleMessage("Register"),
        "reset_password":
            MessageLookupByLibrary.simpleMessage("Reset Password"),
        "s_0001":
            MessageLookupByLibrary.simpleMessage("Internal service error."),
        "send_email": MessageLookupByLibrary.simpleMessage("Send Email"),
        "server_error_message":
            MessageLookupByLibrary.simpleMessage("No internet connection."),
        "terms": MessageLookupByLibrary.simpleMessage("Terms of Use"),
        "that_email_address_is_invalid": MessageLookupByLibrary.simpleMessage(
            "That email address is invalid!"),
        "try_again": MessageLookupByLibrary.simpleMessage("Retry"),
        "vietnamese": MessageLookupByLibrary.simpleMessage("Vietnamese"),
        "we_will_send_you_an_email_with_a_link_to_change_your_password":
            MessageLookupByLibrary.simpleMessage(
                "We will send you an email with a link to change your password."),
        "yes": MessageLookupByLibrary.simpleMessage("Yes")
      };
}
