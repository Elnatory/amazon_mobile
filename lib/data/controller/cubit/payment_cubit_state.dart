part of 'payment_cubit_cubit.dart';

@immutable
abstract class PaymentCubitState {}

final class PaymentCubitInitial extends PaymentCubitState {}

// abstract class PaymentStates {}

// class PaymentInitialStates extends PaymentCubitState {}

class PaymentAuthLoadingState extends PaymentCubitState {}

class PaymentAuthSuccessState extends PaymentCubitState {}

class PaymentAuthErrorState extends PaymentCubitState {
  final String error;
  PaymentAuthErrorState(this.error);
}

// for order id
class PaymentOrderIdLoadingStates extends PaymentCubitState {}

class PaymentOrderIdSuccessStates extends PaymentCubitState {}

class PaymentOrderIdErrorStates extends PaymentCubitState {
  final String error;
  PaymentOrderIdErrorStates(this.error);
}

// for request token
class PaymentRequestTokenLoadingStates extends PaymentCubitState {}

class PaymentRequestTokenSuccessStates extends PaymentCubitState {}

class PaymentRequestTokenErrorStates extends PaymentCubitState {
  final String error;
  PaymentRequestTokenErrorStates(this.error);
}

// for ref code
class PaymentRefCodeLoadingStates extends PaymentCubitState {}

class PaymentRefCodeSuccessStates extends PaymentCubitState {}

class PaymentRefCodeErrorStates extends PaymentCubitState {
  final String error;
  PaymentRefCodeErrorStates(this.error);
}