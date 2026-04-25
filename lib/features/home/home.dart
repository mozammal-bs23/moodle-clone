/// Home feature library
/// 
/// Exports all home feature components following clean architecture:
/// - Domain layer (entities, usecases, repository interfaces)
/// - Data layer (datasources, models, repository implementations)
/// - Presentation layer (cubit, pages, widgets)
library home;

// Domain layer exports
export 'domain/entities/home_entity.dart';
export 'domain/repositories/home_repository.dart';
export 'domain/usecases/get_home_data_usecase.dart';
export 'domain/usecases/get_home_detail_usecase.dart';

// Data layer exports
export 'data/datasources/home_remote_datasource.dart';
export 'data/models/home_model.dart';
export 'data/repositories/home_repository_impl.dart';

// Presentation layer exports
export 'presentation/cubit/home_cubit.dart';
export 'presentation/pages/home_page.dart';
export 'presentation/pages/home_detail_page.dart';
export 'presentation/widgets/home_header_widget.dart';
export 'presentation/widgets/home_content_widget.dart';
export 'presentation/widgets/home_loading_widget.dart';
export 'presentation/widgets/home_error_widget.dart';
