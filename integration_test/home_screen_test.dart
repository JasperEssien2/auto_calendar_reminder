import 'package:auto_calendar_reminder/data/fake_app_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

class HomeScreenTestCases {
  HomeScreenTestCases(this.repository);

  final FakeAppRepository repository;

  Future<void> testProvidersInjected(WidgetTester tester) async {}

  Future<void> testLoadingState(WidgetTester tester) async {}

  Future<void> testErrorState(WidgetTester tester) async {
    repository.throwGetError = true;
  }

  Future<void> testEmptyState(WidgetTester tester) async {}

  Future<void> testDataLoadedState(WidgetTester tester) async {}

  Future<void> testMaterialBannerDismissedOnCancelPressed(
      WidgetTester tester) async {}

  Future<void> testFABPressed(WidgetTester tester) async {}

  Future<void> testOnItemDraggedDelete(WidgetTester tester) async {}
}
