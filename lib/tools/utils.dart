import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

String secondsToString(int seconds) {
  return sprintf("%02d:%02d", [seconds ~/ 60, seconds % 60]);
}
