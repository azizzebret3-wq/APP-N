import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Three-tier graphics quality for adaptive rendering.
enum GraphicsQuality { economy, medium, high }

/// Detects device capability and exposes a [GraphicsQuality] level.
///
/// Heuristic: uses logical pixel count * device pixel ratio as a proxy for
/// GPU fill-rate. Low-end phones typically have small screens with low DPR.
/// Users can override via [setOverride].
class GraphicsQualityService {
  GraphicsQualityService() {
    _detect();
  }

  GraphicsQuality _quality = GraphicsQuality.high;
  GraphicsQuality? _override;

  /// Current effective quality.
  GraphicsQuality get quality => _override ?? _quality;

  /// Whether animations should be reduced (economy mode or OS preference).
  bool get reduceAnimations => quality == GraphicsQuality.economy;

  /// Number of parallax layers for the current quality.
  int get parallaxLayers => switch (quality) {
        GraphicsQuality.high => 4,
        GraphicsQuality.medium => 2,
        GraphicsQuality.economy => 0,
      };

  /// Particle count multiplier (1.0 = full).
  double get particleMultiplier => switch (quality) {
        GraphicsQuality.high => 1.0,
        GraphicsQuality.medium => 0.5,
        GraphicsQuality.economy => 0.0,
      };

  /// User override (from Profile > Settings).
  void setOverride(GraphicsQuality? value) {
    _override = value;
  }

  void _detect() {
    try {
      final display = ui.PlatformDispatcher.instance.displays.first;
      final pixels = display.size.width * display.size.height;
      final dpr = display.devicePixelRatio;
      final score = pixels * dpr;

      // Thresholds tuned for common Burkina Faso devices:
      // - Low-end: ~720×1280 @1.5 ≈ 1_382_400
      // - Mid-range: ~1080×2400 @2.0 ≈ 5_184_000
      if (score < 2000000) {
        _quality = GraphicsQuality.economy;
      } else if (score < 5000000) {
        _quality = GraphicsQuality.medium;
      } else {
        _quality = GraphicsQuality.high;
      }
    } catch (e) {
      // Fallback to medium if detection fails.
      _quality = GraphicsQuality.medium;
      debugPrint('GraphicsQualityService: detection failed ($e), using medium');
    }
  }
}

/// Riverpod provider for the graphics quality service.
final graphicsQualityProvider = Provider<GraphicsQualityService>((ref) {
  return GraphicsQualityService();
});
