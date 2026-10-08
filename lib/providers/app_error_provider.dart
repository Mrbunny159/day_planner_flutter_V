import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppErrorState {
  final String? message;
  final bool isVisible;

  const AppErrorState({this.message, this.isVisible = false});
}

class AppErrorNotifier extends Notifier<AppErrorState> {
  @override
  AppErrorState build() {
    return const AppErrorState();
  }

  void showError(String message) {
    state = AppErrorState(message: message, isVisible: true);
  }

  void dismiss() {
    state = const AppErrorState(isVisible: false);
  }
}

final appErrorProvider = NotifierProvider<AppErrorNotifier, AppErrorState>(() {
  return AppErrorNotifier();
});
