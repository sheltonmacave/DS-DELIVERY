import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'pages/splash_screen.dart';
import 'pages/onboarding_page.dart';
import 'pages/account_selection.dart';
import 'pages/cliente/client_auth.dart';
import 'pages/cliente/client_home.dart';
import 'pages/cliente/client_profile.dart';
import 'pages/cliente/client_createorder.dart';
import 'pages/cliente/client_orderstate.dart';
import 'pages/cliente/client_support.dart';
import 'pages/cliente/client_ordersummary.dart';
import 'pages/cliente/client_history.dart';
import 'pages/entregador/delivery_auth.dart';
import 'pages/entregador/delivery_home.dart';
import 'pages/entregador/delivery_profile.dart';
import 'pages/entregador/delivery_history.dart';
import 'pages/entregador/delivery_orderslist.dart';
import 'pages/entregador/delivery_orderstate.dart';
import 'pages/entregador/delivery_support.dart';
import 'pages/entregador/delivery_ordersummary.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true, // útil durante o desenvolvimento
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: '/account_selection',
      name: 'account_selection',
      builder: (context, state) => const AccountSelectionPage(),
    ),
    GoRoute(
      path: '/cliente/client_auth',
      name: 'client_auth',
      builder: (context, state) => const ClientAuthPage(),
    ),
    GoRoute(
      path: '/cliente/client_home',
      name: 'client_home',
      builder: (context, state) => const ClientHomePage(),
    ),
    GoRoute(
      path: '/cliente/client_profile',
      name: 'client_profile',
      builder: (context, state) => const ClientProfilePage(),
    ),
    GoRoute(
      path: '/cliente/client_createorder',
      name: 'client_createorder',
      builder: (context, state) => const ClientCreateOrderPage(),
    ),
    GoRoute(
      path: '/cliente/client_orderstate',
      name: 'client_orderstate',
      builder: (context, state) => const ClientOrderStatePage(),
    ),
    GoRoute(
      path: '/cliente/client_support',
      name: 'client_support',
      builder: (context, state) => const ClientSupportPage(),
    ),
    GoRoute(
      path: '/cliente/client_ordersummary',
      name: 'client_ordersummary',
      builder: (context, state) => const ClientOrderSummaryPage(),
    ),
    GoRoute(
      path: '/cliente/client_history',
      name: 'client_history',
      builder: (context, state) => const ClientHistoryPage(),
    ),
    GoRoute(
      path: '/entregador/delivery_auth',
      name: 'delivery_auth',
      builder: (context, state) => const DeliveryAuthPage(),
    ),
    GoRoute(
      path: '/entregador/delivery_home',
      name: 'delivery_home',
      builder: (context, state) => const DeliveryHomePage(),
    ),
    GoRoute(
      path: '/entregador/delivery_profile',
      name: 'delivery_profile',
      builder: (context, state) => const DeliveryProfilePage(),
    ),
    GoRoute(
      path: '/entregador/delivery_history',
      name: 'delivery_history',
      builder: (context, state) => const DeliveryHistoryPage(),
    ),
    GoRoute(
      path: '/entregador/delivery_orderslist',
      name: 'delivery_orderslist',
      builder: (context, state) => const DeliveryOrdersListPage(),
    ),
    GoRoute(
      path: '/entregador/delivery_orderstate',
      name: 'delivery_orderstate',
      builder: (context, state) => const DeliveryOrderStatePage(),
    ),
    GoRoute(
      path: '/entregador/delivery_support',
      name: 'delivery_support',
      builder: (context, state) => const DeliverySupportPage(),
    ),
    GoRoute(
      path: '/entregador/delivery_ordersummary',
      name: 'delivery_ordersummary',
      builder: (context, state) => const DeliveryOrderSummaryPage(),
    ),
  ],
);
