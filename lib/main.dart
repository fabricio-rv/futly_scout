import 'package:flutter/material.dart';
import 'package:futly_scout/environment/app_environment.dart';
import 'package:futly_scout/app.dart';

void main() {
  AppEnvironment.initialize();
  runApp(const MyApp());
}
