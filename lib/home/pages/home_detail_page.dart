import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate_domain/flutter_boilerplate_domain.dart';
import '../home_page.dart';
import '../../src/injection/di.dart' as di;

/// Home detail page
///
/// Shows detailed view of a specific home item.
/// Receives [id] parameter from route.
class HomeDetailPage extends StatelessWidget {
  /// Home detail page
  const HomeDetailPage({required this.id, super.key});

  /// ID of the home item to display
  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.getIt<HomeCubit>()..fetchHomeDetail(id),
      child: Scaffold(
        appBar: AppBar(title: const Text('Detail')),
        body: const _HomeDetailBody(),
      ),
    );
  }
}

class _HomeDetailBody extends StatelessWidget {
  const _HomeDetailBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const Center(child: CircularProgressIndicator()),
          loaded: (home, lastRefresh) => _buildDetailContent(context, home),
          detailLoading: () => const Center(child: CircularProgressIndicator()),
          detailLoaded: (detail) => _buildDetailContent(context, detail),
          error: (message, canRetry, errorCode) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text('Error: $message'),
                if (canRetry) ...[
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<HomeCubit>().fetchHomeDetail(
                      (state as HomeError).errorCode ?? '',
                    ),
                    child: const Text('Retry'),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailContent(BuildContext context, HomeEntity detail) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (detail.imageUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                detail.imageUrl!,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image, size: 64, color: Colors.grey),
                ),
              ),
            ),
          const SizedBox(height: 16),
          Text(
            detail.title,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          if (detail.subtitle != null) ...[
            const SizedBox(height: 8),
            Text(
              detail.subtitle!,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
            ),
          ],
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          Text(
            'Items (${detail.items.length})',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          ...detail.items.map(
            (item) => ListTile(
              leading: item.thumbnailUrl != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(item.thumbnailUrl!),
                    )
                  : const CircleAvatar(child: Icon(Icons.category)),
              title: Text(item.title),
              subtitle: item.description != null
                  ? Text(item.description!)
                  : null,
              trailing: item.isFeatured
                  ? const Icon(Icons.star, color: Colors.amber, size: 20)
                  : null,
              onTap: () {
                // Navigate to item detail if needed
              },
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Total: ${detail.totalCount}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            'Last updated: ${detail.lastUpdated.toLocal()}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
