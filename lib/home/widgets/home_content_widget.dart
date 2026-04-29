import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_boilerplate_domain/flutter_boilerplate_domain.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../presentation.dart';
import 'home_header_widget.dart';

/// Main content widget for home page
///
/// Displays list of home items with header section.
class HomeContentWidget extends StatelessWidget {
  /// Creates an instance of [HomeContentWidget]
  const HomeContentWidget({required this.home, super.key, this.lastRefresh});

  /// Home data to display
  final HomeEntity home;

  /// Last refresh time
  final DateTime? lastRefresh;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeHeaderWidget(home: home),
        Expanded(
          child: home.items.isEmpty
              ? const _EmptyStateWidget()
              : _ItemsListWidget(items: home.items),
        ),
      ],
    );
  }
}

/// List of home items
class _ItemsListWidget extends StatelessWidget {
  const _ItemsListWidget({required this.items});

  final List<HomeItemEntity> items;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: items.length,
      separatorBuilder: (context, index) => SizedBox(height: AppSpacing.md.h),
      itemBuilder: (context, index) {
        final item = items[index];
        return _HomeItemCard(
          title: item.title,
          description: item.description,
          imageUrl: item.thumbnailUrl,
          isFeatured: item.isFeatured,
          rank: item.rank,
          onTap: () {
            // Navigate to detail page
            // context.push(AppRoutes.homeDetail, extra: item.id);
          },
        );
      },
    );
  }
}

/// Individual item card
class _HomeItemCard extends StatelessWidget {
  const _HomeItemCard({
    required this.title,
    required this.rank,
    this.description,
    this.imageUrl,
    this.isFeatured = false,
    this.onTap,
  });

  final String title;
  final String? description;
  final String? imageUrl;
  final bool isFeatured;
  final int rank;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              // Rank indicator
              Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(
                  color: _getRankColor(rank, context),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    rank.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(width: AppSpacing.md.w),
              // Thumbnail
              if (imageUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.network(
                    imageUrl!,
                    width: 60.w,
                    height: 60.h,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 60.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: const Icon(Icons.image, color: Colors.grey),
                    ),
                  ),
                )
              else
                Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: const Icon(Icons.category, color: Colors.grey),
                ),
              SizedBox(width: AppSpacing.md.w),
              // Text content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isFeatured) ...[
                          SizedBox(width: AppSpacing.xs.w),
                          Icon(Icons.star, size: 16.sp, color: Colors.amber),
                        ],
                      ],
                    ),
                    if (description != null) ...[
                      SizedBox(height: AppSpacing.xs.h),
                      Text(
                        description!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              // Arrow icon
              Icon(Icons.chevron_right, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }

  Color _getRankColor(int rank, BuildContext context) {
    switch (rank) {
      case 1:
        return Colors.amber;
      case 2:
        return Colors.grey;
      case 3:
        return Colors.brown;
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }
}

/// Empty state when no items are available
class _EmptyStateWidget extends StatelessWidget {
  const _EmptyStateWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox, size: 80.sp, color: Colors.grey[400]),
          SizedBox(height: AppSpacing.md.h),
          Text(
            'No items available',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: AppSpacing.sm.h),
          Text(
            'Pull down to refresh',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
