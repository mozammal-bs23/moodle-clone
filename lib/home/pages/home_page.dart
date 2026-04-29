import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/home/home_page.dart';
import 'package:flutter_boilerplate/src/injection/di.dart' as di;
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';

/// Home page - main dashboard screen
///
/// Displays home data with pull-to-refresh and error handling.
class HomePage extends StatelessWidget {
  /// Creates an instance of [HomePage]
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.getIt<HomeCubit>()..fetchHomeData(),
      child: const Scaffold(body: SafeArea(child: _HomePageBody())),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => context.read<HomeCubit>().refresh(),
      child: const SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(children: [_HomeAppBar(), _HomeContent()]),
      ),
    );
  }
}

/// App bar with title and refresh button
class _HomeAppBar extends StatelessWidget {
  const _HomeAppBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Dashboard',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            onPressed: () => context.read<HomeCubit>().refresh(),
            icon: const Icon(Icons.refresh, color: Colors.white),
            tooltip: 'Refresh',
          ),
        ],
      ),
    );
  }
}

/// Main content area that responds to cubit state changes
class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const HomeLoadingWidget(),
          loaded: (home, lastRefresh) =>
              HomeContentWidget(home: home, lastRefresh: lastRefresh),
          detailLoading: () => const Center(child: CircularProgressIndicator()),
          detailLoaded: (detail) => HomeContentWidget(home: detail),
          error: (message, canRetry, errorCode) => HomeErrorWidget(
            message: message,
            canRetry: canRetry,
            onRetry: () => context.read<HomeCubit>().fetchHomeData(),
          ),
        );
      },
    );
  }
}
