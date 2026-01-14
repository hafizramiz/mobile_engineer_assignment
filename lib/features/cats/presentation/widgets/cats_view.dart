import 'package:cat_app_toy_project/core/constants/app/app_strings.dart';
import 'package:cat_app_toy_project/core/constants/size/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../domain/entities/cat.dart';
import '../blocs/cats/cats_cubit.dart';
import '../blocs/cats/cats_state.dart';
part '_cats_grid_builder.dart';
final class CatsView extends StatelessWidget {
  const CatsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatsCubit, CatsState>(
      builder: (context, state) {
        if (state is CatsInProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is CatsSuccess) {
          final List<Cat> cats = state.cats;
          return Expanded(child: _CatsGridBuilder(cats: cats));
        }
        if (state is CatsFailure) {
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
