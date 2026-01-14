import 'package:cat_app_toy_project/core/constants/size/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../features/cats/presentation/blocs/cats/cats_cubit.dart';
import '../../features/cats/presentation/widgets/cats_view.dart';
import '../../features/tiers/presentation/blocs/tiers/tiers_cubit.dart';
import '../../features/tiers/presentation/widgets/tiers_view.dart';

///[ HomePage] is the main page of the application. Features [CatsView] and [TiersView] widgets.
///[CatsView] displays the list of cats and [TiersView] displays the list of tiers.
///[HomePage] is responsible for combine two features in a page.
///[HomePage] will be used a Routing page in the application.
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => GetIt.I.get<CatsCubit>()..getCats(),
        ),
        BlocProvider(
          create: (_) => GetIt.I.get<TiersCubit>()..getTiers(),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: Builder(
            builder: (context) {
              return const SafeArea(
                child: Column(
                  children: [
                    CatsView(),
                    TiersView(),
                    const SizedBox(height: AppSize.sizedBoxHeight),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
