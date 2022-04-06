import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_flutter_ddd/presentation/sign_in/sign_in_page.dart';
import 'package:flutter/material.dart';

part 'router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page',
  routes: [
    AutoRoute(page: SignInPage, initial: true),
  ],
)
class AppRouter extends _$AppRouter {}
