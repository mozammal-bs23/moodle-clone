import 'package:flutter_boilerplate_domain/feature_post/entities/post_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PostEntity', () {
    const tPost = PostEntity(
      id: 1,
      userId: 1,
      title: 'Test Title',
      body: 'Test Body',
    );

    test('equality based on props', () {
      const post1 = PostEntity(id: 1, userId: 1, title: 'A', body: 'B');
      const post2 = PostEntity(id: 1, userId: 1, title: 'A', body: 'B');

      expect(post1, post2);
    });

    test('inequality when ids differ', () {
      const post1 = PostEntity(id: 1, userId: 1, title: 'A', body: 'B');
      const post2 = PostEntity(id: 2, userId: 1, title: 'A', body: 'B');

      expect(post1, isNot(post2));
    });

    test('id defaults to null for a post not yet created', () {
      const post = PostEntity(userId: 1, title: 'A', body: 'B');

      expect(post.id, isNull);
    });

    test('copyWith returns new instance with updated values', () {
      final updated = tPost.copyWith(title: 'Updated Title');

      expect(updated.id, tPost.id);
      expect(updated.userId, tPost.userId);
      expect(updated.title, 'Updated Title');
      expect(updated.body, tPost.body);
    });

    test('copyWith with no arguments keeps original', () {
      final updated = tPost.copyWith();

      expect(updated, tPost);
    });

    test('hashCode is consistent for equal objects', () {
      const post1 = PostEntity(id: 1, userId: 1, title: 'A', body: 'B');
      const post2 = PostEntity(id: 1, userId: 1, title: 'A', body: 'B');

      expect(post1.hashCode, post2.hashCode);
    });

    test('toString contains id and title', () {
      expect(tPost.toString(), contains('PostEntity'));
      expect(tPost.toString(), contains('id: 1'));
      expect(tPost.toString(), contains('title: Test Title'));
    });
  });
}
