import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'test_util.dart';
import 'add_option_screen_test.dart';
import 'home_screen_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  registerFallbackValue(FakeCalendarEventOption());

  late MockAppRepository repository;
  late HomeScreenTestCases homeScreenTestCases;
  late AddOptionScreenTestCases addOptionScreenTestCases;

  setUp(
    () {

      repository = MockAppRepository();

      homeScreenTestCases = HomeScreenTestCases(repository);
      addOptionScreenTestCases = AddOptionScreenTestCases(repository);
    },
  );
  group(
    "Test HomeScreen",
    () {
      testWidgets(
        'Ensure AppProviders injected in widget tree',
        (WidgetTester tester) async {
          await homeScreenTestCases.testProvidersInjected(tester);
        },
      );

      testWidgets(
        'Ensure CircularProgressIndicator shows in loading state',
        (WidgetTester tester) async {
          await homeScreenTestCases.testLoadingState(tester);
        },
      );

      testWidgets(
        'Ensure error material banner shows in error state',
        (WidgetTester tester) async {
          await homeScreenTestCases.testErrorState(tester);
        },
      );

      testWidgets(
        'Ensure error empty list text shows when list empty',
        (WidgetTester tester) async {
          await homeScreenTestCases.testEmptyState(tester);
        },
      );

      testWidgets(
        'Ensure listview  shows when events successfully loads',
        (WidgetTester tester) async {
          await homeScreenTestCases.testDataLoadedState(tester);
        },
      );

      testWidgets(
        "Ensure material banner dismissed when cancel button tapped",
        (tester) async {
          await homeScreenTestCases
              .testMaterialBannerDismissedOnCancelPressed(tester);
        },
      );

      testWidgets(
        "Ensure AddOptionsScreen is navigated to when FAB tapped",
        (tester) async {
          await homeScreenTestCases.testFABPressed(tester);
        },
      );

      testWidgets(
        "Ensure event item is deleted when ListTile dragged",
        (tester) async {
          await homeScreenTestCases.testOnItemDraggedDelete(tester);
        },
      );
    },
  );

  group(
    "Test AddOptionScreen",
    () {

      testWidgets(
        'Ensure DatePicker is used on android and CupertinoDatePicker for iOS',
        (WidgetTester tester) async {
          await addOptionScreenTestCases.testDatePicker(tester);
        },
      );

      testWidgets(
        'Ensure AppButton is disabled when text fields not filled and enabled when all fields inputted',
        (WidgetTester tester) async {
          await addOptionScreenTestCases.testButtonState(tester);
        },
      );

      testWidgets(
        'Ensure UI corresponds to the UIState',
        (WidgetTester tester) async {
          await addOptionScreenTestCases.testScreenUIState(tester);
        },
      );

      testWidgets(
        'Test save button tapped ',
        (WidgetTester tester) async {
          await addOptionScreenTestCases.testSaveAction(tester);
        },
      );
    },
  );
}
