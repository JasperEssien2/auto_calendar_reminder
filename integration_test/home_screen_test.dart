import 'package:auto_calendar_reminder/data/fake_app_repository_impl.dart';
import 'package:auto_calendar_reminder/presentation/data_controllers.dart';
import 'package:auto_calendar_reminder/presentation/provider.dart';
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
    //TODO: write test code to validate material banner is dismissed when close icon tapped
  }

  Future<void> testFABPressed(WidgetTester tester) async {
    //TODO: write test code to validate app navigates to add option screen
  }

  Future<void> testOnItemDraggedDelete(WidgetTester tester) async {
    //TODO: write test code to validate that widget is removed from widget tree when a drag occurrs
  }
}
