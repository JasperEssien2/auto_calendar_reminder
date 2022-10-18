import 'package:flutter/material.dart';

import '../domain/domain_export.dart';

abstract class BaseDataController<T> extends ChangeNotifier {
  BaseDataController({required T data}) : _data = data;

  final T _data;

  late AppState<T> _state = AppState<T>(data: _data);

  set state(AppState<T> newState) {
    if (newState == _state) return;

    _state = newState;
    notifyListeners();
  }

  AppState<T> get state => _state;
}

class AppDataController extends BaseDataController<EventOptionList> {
  AppDataController({required this.repository, super.data = const []});

  final AppRepository repository;

  @visibleForTesting
  @override
  set state(AppState<EventOptionList> newState) {
    super.state = newState;
  }

  void loadEventOptions() async {
    state = _state.loadingState(true);

    await _loadOptions();
  }

  Future<void> _loadOptions({String? successText}) async {
    try {
      final options = await repository.getEventOptions();

      state = _state.successState(options, successText: successText);
    } catch (e) {
      state = _state.errorState("An error occurred");
    }
  }

  void removeEvent(String id) {
    _data.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}

class ActionsDataController extends BaseDataController<bool?> {
  ActionsDataController({
    required this.controller,
    super.data,
  });

  final AppDataController controller;

  void deleteEventOption(String optionId) async {
    state = _state.loadingState(true);

    bool successful = await controller.repository.deleteOptions(optionId);

    if (successful) {
      controller.removeEvent(optionId);

      state = _state.successState(successful,
          successText: "Successfully deleted event option");
    } else {
      state = _state.errorState("Deleting option failed!");
    }
  }

  void addEventOption(CalendarEventOption option) async {
    state = _state.loadingState(true);

    bool successful = await controller.repository.addOptions(option);

    if (successful) {
      state = _state.successState(successful,
          successText: "Successfully added event option");

      controller._loadOptions();
    } else {
      state = _state.errorState("Adding option failed!");
    }
  }
}

class AppState<T> {
  AppState(
      {required this.data, this.error, this.successText, this.loading = false});

  final T data;
  final String? error;
  final String? successText;
  final bool loading;

  AppState<T> loadingState(bool isLoading) =>
      copyWith(loading: isLoading, error: null, successText: null);

  AppState<T> errorState(String error) =>
      copyWith(loading: false, successText: null, error: error);

  AppState<T> successState(T data, {String? successText}) => copyWith(
      loading: false, error: null, data: data, successText: successText);

  AppState<T> copyWith({
    T? data,
    String? error,
    bool? loading,
    String? successText,
  }) {
    return AppState(
      data: data ?? this.data,
      error: error ?? this.error,
      loading: loading ?? this.loading,
      successText: successText ?? this.successText,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppState &&
        other.data == data &&
        other.error == error &&
        other.loading == loading &&
        other.successText == successText;
  }

  @override
  int get hashCode =>
      data.hashCode ^ error.hashCode ^ loading.hashCode ^ successText.hashCode;

  @override
  String toString() {
    return 'AppState(data: $data, error: $error, successText: $successText, loading: $loading)';
  }
}
