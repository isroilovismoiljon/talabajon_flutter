import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:talabajon/core/constants/status.dart';
import 'package:talabajon/features/balance/managers/my_payments/my_payments_bloc.dart';
import 'package:talabajon/features/balance/managers/my_payments/my_payments_event.dart';
import 'package:talabajon/features/balance/managers/my_payments/my_payments_state.dart';
import 'package:talabajon/features/balance/widgets/payment_payment_info.dart';

import '../../../core/l10n/app_localizations.dart';

class PaymentsWidget extends StatelessWidget {
  const PaymentsWidget({
    super.key,
    required this.transitionAnimationController,
    required this.local,
  });

  final AnimationController transitionAnimationController;
  final MyLocalizations local;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<MyPaymentsBloc>().add(MyPaymentsEvent());
        },
        child: BlocBuilder<MyPaymentsBloc, MyPaymentsState>(
          builder: (context, state) {
            if (state.paymentStatus == Status.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.payments == null || state.payments!.data.isEmpty) {
              return Center(
                child: Text("no_payments_found"),
              );
            }

            return ListView.builder(
              itemCount: state.payments!.data.length,
              itemBuilder: (context, index) {
                final payment = state.payments!.data[index];

                String formatDate(String isoDate) {
                  final date = DateTime.parse(isoDate);
                  final formatter = DateFormat('dd.MM.yyyy | HH:mm');
                  return formatter.format(date);
                }

                return PaymentPaymentInfo(
                  transitionAnimationController: transitionAnimationController,
                  payment: payment,
                  local: local,
                  formatDate: formatDate(payment.createdAt),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
