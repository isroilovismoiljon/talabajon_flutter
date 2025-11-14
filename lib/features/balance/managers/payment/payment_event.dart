import 'package:talabajon/data/models/paymets/payment_model.dart';

sealed class PaymentEvent {}

final class PaymentNewEvent extends PaymentEvent {
  final PaymentModel data;

  PaymentNewEvent({required this.data});
}
