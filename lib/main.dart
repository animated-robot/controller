import 'package:controller/app_initializer.dart';
import 'package:controller/dependecy_injection.dart';
import 'package:controller/find-server.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

Injector injector;

void main() async {
  DependencyInjection().initialise(Injector.getInjector());
  injector = Injector.getInjector();
  await AppInitializer().initialise(injector);

  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: FindServer(injector),
  ));
}
