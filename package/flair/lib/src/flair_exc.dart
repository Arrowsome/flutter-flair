class FlairExc {
  String message;
  String? todo;

  FlairExc({required this.message, this.todo});

  @override
  String toString() {
    if (todo == null)
      return '$message';
    else
      return '$message: $todo';
  }
}
