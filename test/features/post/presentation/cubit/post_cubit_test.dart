import 'package:flutter_boilerplate/feature_post/cubit/post_cubit.dart';
import 'package:flutter_boilerplate_core/utils/failure/app_failure.dart';
import 'package:flutter_boilerplate_domain/flutter_boilerplate_domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'post_cubit_test.mocks.dart';

@GenerateMocks([
  GetPostsUseCase,
  CreatePostUseCase,
  UpdatePostUseCase,
  PatchPostUseCase,
  DeletePostUseCase,
])
void main() {
  late PostCubit cubit;
  late MockGetPostsUseCase mockGetPostsUseCase;
  late MockCreatePostUseCase mockCreatePostUseCase;
  late MockUpdatePostUseCase mockUpdatePostUseCase;
  late MockPatchPostUseCase mockPatchPostUseCase;
  late MockDeletePostUseCase mockDeletePostUseCase;

  const tPosts = [
    PostEntity(id: 1, userId: 1, title: 'Title 1', body: 'Body 1'),
  ];

  setUp(() {
    mockGetPostsUseCase = MockGetPostsUseCase();
    mockCreatePostUseCase = MockCreatePostUseCase();
    mockUpdatePostUseCase = MockUpdatePostUseCase();
    mockPatchPostUseCase = MockPatchPostUseCase();
    mockDeletePostUseCase = MockDeletePostUseCase();

    cubit = PostCubit(
      getPostsUseCase: mockGetPostsUseCase,
      createPostUseCase: mockCreatePostUseCase,
      updatePostUseCase: mockUpdatePostUseCase,
      patchPostUseCase: mockPatchPostUseCase,
      deletePostUseCase: mockDeletePostUseCase,
    );
  });

  tearDown(() => cubit.close());

  test('initial state is PostInitial', () {
    expect(cubit.state, const PostState.initial());
  });

  group('fetchPosts', () {
    test('emits [loading, loaded] on success', () async {
      when(
        mockGetPostsUseCase(),
      ).thenAnswer((_) async => (tPosts, null));

      final states = <PostState>[];
      final sub = cubit.stream.listen(states.add);

      await cubit.fetchPosts();
      await Future<void>.delayed(Duration.zero);
      await sub.cancel();

      expect(states, [
        const PostState.loading(),
        const PostState.loaded(posts: tPosts),
      ]);
    });

    test('emits [loading, error] on failure', () async {
      const tFailure = NetworkFailure(message: 'Server error', statusCode: 500);
      when(
        mockGetPostsUseCase(),
      ).thenAnswer((_) async => (null, tFailure));

      final states = <PostState>[];
      final sub = cubit.stream.listen(states.add);

      await cubit.fetchPosts();
      await Future<void>.delayed(Duration.zero);
      await sub.cancel();

      expect(states, [
        const PostState.loading(),
        const PostState.error(message: 'Server error', canRetry: true),
      ]);
    });
  });

  group('createPost', () {
    test('emits [mutating, loading, loaded] and refetches on success', () async {
      const tNewPost = PostEntity(id: 101, userId: 1, title: 'New', body: 'B');
      when(
        mockCreatePostUseCase(any),
      ).thenAnswer((_) async => (tNewPost, null));
      when(
        mockGetPostsUseCase(),
      ).thenAnswer((_) async => (tPosts, null));

      final states = <PostState>[];
      final sub = cubit.stream.listen(states.add);

      await cubit.createPost(userId: 1, title: 'New', body: 'B');
      await Future<void>.delayed(Duration.zero);
      await sub.cancel();

      expect(states, [
        const PostState.mutating(posts: []),
        const PostState.loading(),
        const PostState.loaded(posts: tPosts),
      ]);
      verify(mockCreatePostUseCase(any)).called(1);
      verify(mockGetPostsUseCase()).called(1);
    });

    test('emits [mutating, error] and does not refetch on failure', () async {
      const tFailure = NetworkFailure(message: 'Server error', statusCode: 500);
      when(
        mockCreatePostUseCase(any),
      ).thenAnswer((_) async => (null, tFailure));

      final states = <PostState>[];
      final sub = cubit.stream.listen(states.add);

      await cubit.createPost(userId: 1, title: 'New', body: 'B');
      await Future<void>.delayed(Duration.zero);
      await sub.cancel();

      expect(states, [
        const PostState.mutating(posts: []),
        const PostState.error(message: 'Server error', canRetry: true),
      ]);
      verifyNever(mockGetPostsUseCase());
    });
  });

  group('deletePost', () {
    test('emits [mutating, loading, loaded] and refetches on success', () async {
      when(
        mockDeletePostUseCase(1),
      ).thenAnswer((_) async => (null, null));
      when(
        mockGetPostsUseCase(),
      ).thenAnswer((_) async => (<PostEntity>[], null));

      final states = <PostState>[];
      final sub = cubit.stream.listen(states.add);

      await cubit.deletePost(1);
      await Future<void>.delayed(Duration.zero);
      await sub.cancel();

      expect(states, [
        const PostState.mutating(posts: []),
        const PostState.loading(),
        const PostState.loaded(posts: []),
      ]);
      verify(mockDeletePostUseCase(1)).called(1);
    });
  });
}
