import 'package:cat_app_toy_project/features/tiers/presentation/widgets/tier_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/tiers/tiers_cubit.dart';
import '../blocs/tiers/tiers_state.dart';

final class TiersView extends StatelessWidget {
  const TiersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TiersCubit, TiersState>(
      builder: (context, state) {
        if (state is TiersInProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is TiersSuccess) {
          return Expanded(
              child: TierChart(
            resultModel: state.resultModel
          ));
        }
        if (state is TiersFailure) {
          return Center(
            child: Center(
              child: Text("Error!: ${state.message}"),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
