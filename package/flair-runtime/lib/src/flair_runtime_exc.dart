class FlairRuntimeExc {
  String message;
  String? todo;

  FlairRuntimeExc({required this.message, this.todo});

  @override
  String toString() {
    if (todo == null)
      return '$message';
    else
      return '$message: $todo';
  }
}
