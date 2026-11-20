import 'package:flutter_test/flutter_test.dart';
import 'package:nourou_academy/core/performance/graphics_quality_service.dart';

void main() {
  group('GraphicsQualityService', () {
    test('default quality is determined without error', () {
      final service = GraphicsQualityService();
      expect(service.quality, isA<GraphicsQuality>());
    });

    test('manual override changes effective quality', () {
      final service = GraphicsQualityService();
      service.setOverride(GraphicsQuality.economy);
      expect(service.quality, equals(GraphicsQuality.economy));
      expect(service.reduceAnimations, isTrue);
      expect(service.parallaxLayers, equals(0));
      expect(service.particleMultiplier, equals(0.0));

      service.setOverride(GraphicsQuality.high);
      expect(service.quality, equals(GraphicsQuality.high));
      expect(service.reduceAnimations, isFalse);
      expect(service.parallaxLayers, equals(4));
      expect(service.particleMultiplier, equals(1.0));

      service.setOverride(null);
      // Returns to detected quality.
      expect(service.quality, isA<GraphicsQuality>());
    });
  });
}
