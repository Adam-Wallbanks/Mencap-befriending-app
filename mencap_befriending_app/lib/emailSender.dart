import 'package:flutter_email_sender/flutter_email_sender.dart';

class emailSender{

Future<void> sendEmail() async {
  final Email email = Email(
    body: 'Email body',
    subject: 'Email subject',
    recipients: ['mencaptestemail@gmail.com'],
    isHTML: false,
  );

  try {
    await FlutterEmailSender.send(email);
    print('Email sent');
  } catch (error) {
    print('Error sending email: $error');
  }
}

}