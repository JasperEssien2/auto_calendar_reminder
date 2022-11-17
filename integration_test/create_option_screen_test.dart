import 'package:auto_calendar_reminder/domain/domain_export.dart';
import 'package:auto_calendar_reminder/presentation/create_option_screen.dart';
import 'package:auto_calendar_reminder/presentation/data_controllers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_util.dart';

class CreateOptionScreenTestCases {
  CreateOptionScreenTestCases(this.repository);

  final AppRepository repository;

  Future<void> testDatePicker(WidgetTester tester) async {
   //TODO: Write test cases for date picker
  }

  Future<void> testButtonState(WidgetTester tester) async {

    //TODO: Write test cases for button state
  }

  Future<void> _setTextField(
      WidgetTester tester, String key, String text) async {
    //TODO: use tester to input text in a textfield
  }

  Future<void> testScreenUIState(WidgetTester tester) async {
    await TestUtils.pumpApp(
      tester,
      repository: repository,
      navigateToScreen2: true,
    );

    _updateScreenState(tester, UIState(data: false, loading: true));

    await tester.pump();

    expect(appButtonFinder, findsAppButtonInLoadingState);
  }

  void _updateScreenState(WidgetTester tester, UIState<bool> state) {
    tester
        .state<CreateOptionScreenState>(find.byType(CreateOptionScreen))
        .actionsDataController
        .state = state;
  }

  Future<void> testSaveAction(WidgetTester tester) async {
    TestNavigatorObserver navigatorObserver = TestNavigatorObserver()
      ..onPopped = (route, prevRoute) {
        if (route.runtimeType != CupertinoModalPopupRoute<void>) {
          expect(route.settings.name, CreateOptionScreen.pageName);
          expect(prevRoute?.settings.name, '/');
        }
      };

    await TestUtils.pumpApp(
      tester,
      repository: repository,
      navigateToScreen2: true,
      observer: navigatorObserver,
    );

    await _setTextField(tester, 'optionNameField', 'Coffee Break');

    await _setTextField(tester, 'descriptionField', 'Remember to take breaks');

    await _setTextField(tester, 'iconField',
        'https://cdn-icons-png.flaticon.com/512/1792/1792931.png');

    await _selectDateOnCalendar(tester);

    await tester.tap(find.byType(RawMaterialButton));

    await tester.pumpAndSettle();
  }

  Future<void> _selectDateOnCalendar(WidgetTester tester) async {
    await tester.tap(find.byKey(const ValueKey('dateField')));

    await tester.pumpAndSettle();

    final context = tester.state(find.byType(CreateOptionScreen)).context;

    if (Theme.of(context).platform == TargetPlatform.android) {
      await tester.tap(find.text("OK"));
    } else if (Theme.of(context).platform == TargetPlatform.iOS) {
      tester
          .widget<CupertinoDatePicker>(find.byType(CupertinoDatePicker))
          .onDateTimeChanged(DateTime.now());

      Navigator.of(context).pop();
    }

    await tester.pumpAndSettle();
  }
}
