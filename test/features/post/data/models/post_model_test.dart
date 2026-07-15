import 'package:flutter_boilerplate_data/feature_post/models/post_model.dart';
import 'package:flutter_boilerplate_domain/feature_post/entities/post_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PostModel', () {
    const tPostModel = PostModel(
      id: 1,
      userId: 1,
      title: 'Test Title',
      body: 'Test Body',
    );

    test('fromJson creates correct model', () {
      final json = <String, dynamic>{
        'id': 1,
        'userId': 1,
        'title': 'Test Title',
        'body': 'Test Body',
      };

      final model = PostModel.fromJson(json);

      expect(model.id, 1);
      expect(model.userId, 1);
      expect(model.title, 'Test Title');
      expect(model.body, 'Test Body');
    });

    test('fromJson without id (server-created post)', () {
      final json = <String, dynamic>{
        'userId': 1,
        'title': 'Test Title',
        'body': 'Test Body',
      };

      final model = PostModel.fromJson(json);

      expect(model.id, isNull);
    });

    test('toJson produces correct map', () {
      final json = tPostModel.toJson();

      expect(json['id'], 1);
      expect(json['userId'], 1);
      expect(json['title'], 'Test Title');
      expect(json['body'], 'Test Body');
    });

    test('toEntity maps to PostEntity correctly', () {
      final entity = tPostModel.toEntity();

      expect(entity, isA<PostEntity>());
      expect(entity.id, tPostModel.id);
      expect(entity.userId, tPostModel.userId);
      expect(entity.title, tPostModel.title);
      expect(entity.body, tPostModel.body);
    });

    test('toModel maps PostEntity back to PostModel correctly', () {
      const entity = PostEntity(
        id: 2,
        userId: 3,
        title: 'Entity Title',
        body: 'Entity Body',
      );

      final model = entity.toModel();

      expect(model, isA<PostModel>());
      expect(model.id, entity.id);
      expect(model.userId, entity.userId);
      expect(model.title, entity.title);
      expect(model.body, entity.body);
    });

    test('equality works with same values', () {
      const model1 = PostModel(id: 1, userId: 1, title: 'A', body: 'B');
      const model2 = PostModel(id: 1, userId: 1, title: 'A', body: 'B');

      expect(model1, model2);
    });
  });
}
