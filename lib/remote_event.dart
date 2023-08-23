abstract class RemoteEvent {}

class IncrementEvent extends RemoteEvent {
  IncrementEvent(this.increment);

  final int increment;
}

class DecrementEvent extends RemoteEvent {
  DecrementEvent(this.decrement);

  final int decrement;
}

class MuteEvent extends RemoteEvent {}
