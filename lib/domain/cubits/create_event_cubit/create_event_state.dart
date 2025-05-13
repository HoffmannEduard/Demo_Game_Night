part of 'create_event_cubit.dart';

class CreateEventState extends Equatable {
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;
  final int? recurrence;
  final String? errorMessage;
  final bool isSuccess;

  const CreateEventState({
    this.selectedDate,
    this.selectedTime,
    this.recurrence,
    this.errorMessage,
    this.isSuccess = false
});

  CreateEventState copyWith({
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
    int? recurrence,
    String? errorMessage,
    bool? isSuccess
  }) {
    return CreateEventState(
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
      recurrence: recurrence ?? this.recurrence,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess
    );
  }

  String get formattedDate {
    if (selectedDate == null) return 'Datum auswählen';
    return '${selectedDate!.day}.${selectedDate!.month}.${selectedDate!.year}';
  }

  String get formattedTime {
    if (selectedTime == null) return 'Uhrzeit auswählen';
    final hour = selectedTime!.hour.toString().padLeft(2, '0');
    final minute = selectedTime!.minute.toString().padLeft(2, '0');
    return '$hour:$minute Uhr';
  }

  @override
List<Object?> get props => [
  selectedDate, 
  selectedTime,
  recurrence,
  errorMessage,
  isSuccess
  ];
}

final class CreateEventInitial extends CreateEventState {}
