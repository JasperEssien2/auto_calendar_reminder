import 'package:auto_calendar_reminder/domain/domain_export.dart';
import 'package:auto_calendar_reminder/presentation/add_option_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'test_util.dart';

class HomeScreenTestCases {
  HomeScreenTestCases(this.repository);

  final MockAppRepository repository;

  Future<void> testProvidersInjected(WidgetTester tester) async {
    //TODO 1: Mock repository.getEventOptions()

    //TODO 2: Pump App widget

    //TODO 3: Expect AppProviders found in widget tree
  }

  Future<void> testLoadingState(WidgetTester tester) async {
    //TODO 1: Mock repository.getEventOptions() to do nothing

    //TODO 2: Pump App widget

    //TODO 3: Find HomeScreen state to access AppDataController

    //TODO 4: Set state to loading state

    //TODO 5: Trigger a frame rebuild after a certain duration

    //TODO 6: Expect CircularProgressIndicator is found

    //TODO 7: Expect error widget is not found

    //TODO 8: Expect ListView is not found

    //TODO 9: Expect MaterialBanner is not found

    //TODO 10: Verify that repository.getEventOptons() was called
  }

  Future<void> testErrorState(WidgetTester tester) async {
    //TODO 1: Mock repository.getEventOptions() to return an error

    //TODO 2: Pump App widget
 
    //TODO 3: Expect MaterialBanner found

    //TODO 4: Expect error text found

    //TODO 5: Expect CircularProgressIndicator is not found

    //TODO 6: Expect error text is not found

    //TODO 7: Expect ListView is not found

    //TODO 8: Verify that repository.getEventOptions() was called
  }

  Future<void> testEmptyState(WidgetTester tester) async {
    _doWhenGetEventOptionsCalled(data: []);

    await TestUtils.pumpApp(tester, repository: repository);

    expect(find.text("No events found"), findsOneWidget);

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(ListView), findsNothing);
    expect(find.byType(MaterialBanner), findsNothing);

    verify(() => repository.getEventOptions());
  }

  Future<void> testDataLoadedState(WidgetTester tester) async {
    _doWhenGetEventOptionsCalled();

    await TestUtils.pumpApp(tester, repository: repository);

    expect(find.byType(ListView), findsOneWidget);

    for (var data in _data) {
      expect(find.byKey(Key(data.id)), findsOneWidget);
    }

    expect(find.text("No events found"), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(MaterialBanner), findsNothing);

    verify(() => repository.getEventOptions());
  }

  Future<void> testMaterialBannerDismissedOnCancelPressed(
      WidgetTester tester) async {
    _doWhenGetEventOptionsCalled(error: true);

    await TestUtils.pumpApp(tester, repository: repository);

    await tester.tap(find.byKey(const ValueKey('closeBanner')));

    await tester.pumpAndSettle();

    expect(find.byType(MaterialBanner), findsNothing);
    expect(find.text("An error occurred"), findsNothing);
  }

  Future<void> testFABPressed(WidgetTester tester) async {
    List<String> navigatorEntries = [];

    TestNavigatorObserver navigatorObserver = TestNavigatorObserver()
      ..onPushed = (route, _) {
        navigatorEntries.add(route.settings.name ?? '');
      };

    await TestUtils.pumpApp(
      tester,
      repository: repository,
      observer: navigatorObserver,
    );

    await tester.tap(find.byType(FloatingActionButton));

    await tester.pumpAndSettle();

    expect(navigatorEntries.isNotEmpty, true);
    expect(navigatorEntries, ['/', AddOptionScreen.pageName]);
  }

  Future<void> testOnItemDraggedDelete(WidgetTester tester) async {
    _doWhenGetEventOptionsCalled();

    when(() => repository.deleteOptions(any())).thenAnswer(
      (_) => Future.value(true),
    );

    await TestUtils.pumpApp(tester, repository: repository);

    await tester.drag(find.byKey(const Key("id1")), const Offset(-700, 0));

    await tester.pumpAndSettle();

    expect(find.byKey(const Key("id2")), findsOneWidget);
    expect(find.byKey(const Key("id3")), findsOneWidget);

    expect(find.byKey(const Key("id1")), findsNothing);

    verify(() => repository.deleteOptions('id1'));
  }

  void _doWhenGetEventOptionsCalled(
      {EventOptionList? data, bool error = false}) {
    if (error) {
      when(() => repository.getEventOptions())
          .thenThrow(Exception("An error occurred"));
    } else {
      when(() => repository.getEventOptions()).thenAnswer(
        (_) => Future.value(data ?? _data),
      );
    }
  }

  List<CalendarEventOption> get _data {
    return [
      CalendarEventOption(
        optionName: "Name1",
        optionDescription: "Description1",
        icon: "https://cdn-icons-png.flaticon.com/512/1792/1792931.png",
        id: "id1",
        dateTime: "12/10/2022",
      ),
      CalendarEventOption(
        optionName: "Name2",
        optionDescription: "Description2",
        icon: "https://cdn-icons-png.flaticon.com/512/1792/1792931.png",
        id: "id2",
        dateTime: "22/12/2022",
      ),
      CalendarEventOption(
        optionName: "Name3",
        optionDescription: "Description3",
        icon: "https://cdn-icons-png.flaticon.com/512/1792/1792931.png",
        id: "id3",
        dateTime: "01/12/2022",
      ),
    ];
  }
}
