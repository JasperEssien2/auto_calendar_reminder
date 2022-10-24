import 'package:auto_calendar_reminder/data/fake_app_repository_impl.dart';
import 'package:auto_calendar_reminder/domain/domain_export.dart';
import 'package:auto_calendar_reminder/ext.dart';
import 'package:auto_calendar_reminder/presentation/add_option_screen.dart';
import 'package:auto_calendar_reminder/presentation/data_controllers.dart';
import 'package:auto_calendar_reminder/presentation/home_screen.dart';
import 'package:auto_calendar_reminder/presentation/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_util.dart';

class HomeScreenTestCases {
  HomeScreenTestCases(this.repository);

  final FakeAppRepository repository;

  Future<void> testProvidersInjected(WidgetTester tester) async {
    await TestUtils.pumpApp(tester, repository: repository);

    expect(find.byType(AppProvider<ActionsDataController>), findsOneWidget);
    expect(find.byType(AppProvider<AppDataController>), findsOneWidget);
  }

  Future<void> testLoadingState(WidgetTester tester) async {
    //TODO: write test code for loading state
  }

  Future<void> testErrorState(WidgetTester tester) async {
    //TODO: write test code for error state
  }

  Future<void> testEmptyState(WidgetTester tester) async {
    //TODO: write test code for empty state
  }

  Future<void> testDataLoadedState(WidgetTester tester) async {
    //TODO: write test code to validate loaded state
  }

  Future<void> testMaterialBannerDismissedOnCancelPressed(
      WidgetTester tester) async {}

  Future<void> testFABPressed(WidgetTester tester) async {}

  Future<void> testOnItemDraggedDelete(WidgetTester tester) async {}
}
