import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

// ####### String Extension #######
extension StringExtension on String {
  String get hardcoded => this;
  String toLower() => toLowerCase();
  String toUpper() => toUpperCase();
  String capitalizedFirstLetter() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }

  String append(String other) => '$this$other';
  // Format: yyyy-MM-dd HH:mm:ss
  DateTime toDateTime() {
    return DateTime.parse(this);
  }

  // 8 Digit Characters, Contains Lowercase, Uppercase, & Number
  bool isValidPassword() {
    return RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}$').hasMatch(this);
  }

  bool isValidEmail() {
    return RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(this);
  }

  bool isURL() {
    // Regular expression for a simple URL pattern
    RegExp urlRegExp = RegExp(
      r'^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$',
      caseSensitive: false,
      multiLine: false,
    );

    return urlRegExp.hasMatch(this);
  }
}

// ####### Number Extension #######
extension SizedBoxExtension on num {
  SizedBox get height => SizedBox(
        height: toDouble(),
      );

  SizedBox get width => SizedBox(
        width: toDouble(),
      );

  num widthRatio(BuildContext context) =>
      MediaQuery.sizeOf(context).width * this;

//padding
  EdgeInsets get allPadding => EdgeInsets.all(toDouble());

  EdgeInsets get verticalPadding => EdgeInsets.symmetric(vertical: toDouble());

  EdgeInsets get horizontalPadding =>
      EdgeInsets.symmetric(horizontal: toDouble());

  EdgeInsets get leftPadding => EdgeInsets.only(left: toDouble());

  EdgeInsets get rightPadding => EdgeInsets.only(right: toDouble());

  EdgeInsets get topPadding => EdgeInsets.only(top: toDouble());

  EdgeInsets get bottomPadding => EdgeInsets.only(bottom: toDouble());
}

// ####### Text Extension #######
extension TextExtension on Text {
  Text bold() {
    return Text(data ?? '',
        style: style?.copyWith(fontWeight: FontWeight.bold) ??
            const TextStyle(fontWeight: FontWeight.bold));
  }
  //Text('Test').bold;

  Text titleMedium(BuildContext context) {
    return Text(data ?? '', style: Theme.of(context).textTheme.titleMedium);
  }
}

// ####### DateTime extension #######
extension DateTimeExt on DateTime {
  bool isToday() {
    final now = DateTime.now();
    return day == now.day && month == now.month && year == now.year;
  }

  bool isYesterday() {
    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    return day == yesterday.day &&
        month == yesterday.month &&
        year == yesterday.year;
  }

  // yyyy-mm-dd
  String get stringFormat => toIso8601String().substring(0, 10);

  String get ddMMMyyy => DateFormat('dd MMM yyyy').format(this);

  String get ddMMyyyy => DateFormat('dd/MM/yyyy').format(this);
}
