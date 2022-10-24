import 'package:auto_calendar_reminder/data/fake_app_repository_impl.dart';
import 'package:auto_calendar_reminder/presentation/data_controllers.dart';
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
      WidgetTester tester) async {
    /// Instruct repository to throw error
    repository.throwGetError = true;

    /// Pump app widget
    await TestUtils.pumpApp(tester, repository: repository);

    expect(find.byType(MaterialBanner), findsOneWidget);

    await tester.tap(find.byIcon(Icons.close));

    await tester.pumpAndSettle();

    //
    expect(find.byType(MaterialBanner), findsNothing);
    expect(find.text("An error occurred"), findsNothing);
  }

  Future<void> testFABPressed(WidgetTester tester) async {}

  Future<void> testOnItemDraggedDelete(WidgetTester tester) async {}
}
