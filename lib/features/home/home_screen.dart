import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../../core/performance/graphics_quality_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_shadows.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/data/course_repository.dart';
import '../../shared/models/course.dart';
import '../../shared/widgets/animated_progress_bar.dart';
import '../../shared/widgets/depth_button.dart';
import '../../shared/widgets/floating_chip.dart';
import '../../shared/widgets/glass_card.dart';
import '../../shared/widgets/progress_ring.dart';
import 'widgets/course_carousel_card.dart';
import 'widgets/floating_nav_bar.dart';

/// Main home screen with coach hero, parallax, floating chips, carousel.
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  static void _noop() {}
  int _selectedTab = 0;
  double _gyroX = 0;
  double _gyroY = 0;
  StreamSubscription<GyroscopeEvent>? _gyroSub;

  @override
  void initState() {
    super.initState();
    final quality = ref.read(graphicsQualityProvider).quality;
    if (quality != GraphicsQuality.economy) {
      _gyroSub = gyroscopeEventStream().listen((event) {
        setState(() {
          _gyroX = (_gyroX + event.y * 0.3).clamp(-15.0, 15.0);
          _gyroY = (_gyroY + event.x * 0.3).clamp(-15.0, 15.0);
        });
      });
    }
  }

  @override
  void dispose() {
    _gyroSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final coursesAsync = ref.watch(allCoursesProvider);
    final quality = ref.watch(graphicsQualityProvider);
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // ── Hero Header ─────────────────────────────────────
              SliverToBoxAdapter(
                child: _buildHeroSection(size, quality),
              ),
              // ── Continue learning ───────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                  child: _buildContinueLearning(),
                ),
              ),
              // ── Offline banner ──────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: _buildOfflineBanner(),
                ),
              ),
              // ── Course carousel ─────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 8),
                  child: Text(
                    'Formations populaires',
                    style: AppTypography.headlineLarge,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: coursesAsync.when(
                  data: (courses) => _buildCourseCarousel(courses),
                  loading: () => const SizedBox(
                    height: 220,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (_, __) => const SizedBox.shrink(),
                ),
              ),
              // ── Stats section ───────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                  child: _buildStatsSection(),
                ),
              ),
              // Bottom spacing for floating nav bar.
              const SliverToBoxAdapter(
                child: SizedBox(height: 100),
              ),
            ],
          ),
          // ── Floating navigation bar ─────────────────────────────
          Positioned(
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).padding.bottom + 12,
            child: FloatingNavBar(
              selectedIndex: _selectedTab,
              onTap: (i) => setState(() => _selectedTab = i),
            ),
          ),
        ],
      ),
    );
  }

  // ── Hero Section ──────────────────────────────────────────────────
  Widget _buildHeroSection(Size size, GraphicsQualityService quality) {
    return Container(
      height: size.height * 0.52,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.indigo, Color(0xFF312E81)],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      child: SafeArea(
        bottom: false,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // ── Parallax glow circle ──
            Positioned(
              left: size.width * 0.5 - 100 + _gyroX * 0.5,
              top: 60 + _gyroY * 0.5,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.gold.withAlpha(50),
                      AppColors.gold.withAlpha(15),
                      Colors.transparent,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.gold.withAlpha(40),
                      blurRadius: 60,
                      spreadRadius: 20,
                    ),
                  ],
                ),
              ),
            )
                .animate()
                .scale(
                  begin: const Offset(0.5, 0.5),
                  duration: 1000.ms,
                  curve: Curves.easeOut,
                ),

            // ── Coach placeholder (head overflows the circle) ──
            Positioned(
              left: size.width * 0.5 - 70 + _gyroX * 1.2,
              top: 30 + _gyroY * 1.2,
              child: Container(
                width: 140,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(70),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.gold.withAlpha(60),
                      AppColors.indigo.withAlpha(60),
                    ],
                  ),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person, size: 64, color: Colors.white54),
                    SizedBox(height: 4),
                    Text(
                      'Coach',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            )
                .animate()
                .fadeIn(duration: 800.ms)
                .slideY(begin: 0.3, curve: Curves.easeOut),

            // ── Floating chips ──
            Positioned(
              right: 24 + _gyroX * 0.8,
              top: 50 + _gyroY * 0.4,
              child: FloatingChip(
                icon: Icons.local_fire_department_rounded,
                label: '3 jours 🔥',
                color: AppColors.coral,
                delay: 600.ms,
              ),
            ),
            Positioned(
              left: 20 + _gyroX * 0.6,
              top: 130 + _gyroY * 0.6,
              child: FloatingChip(
                icon: Icons.workspace_premium_rounded,
                label: 'Badge obtenu',
                color: AppColors.gold,
                delay: 800.ms,
              ),
            ),
            Positioned(
              right: 32 + _gyroX * 1.0,
              top: 180 + _gyroY * 0.9,
              child: FloatingChip(
                icon: Icons.trending_up_rounded,
                label: '45 %',
                color: AppColors.mint,
                delay: 1000.ms,
              ),
            ),

            // ── Greeting + XP ──
            Positioned(
              left: 20,
              right: 20,
              bottom: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bonjour, Awa 👋',
                    style: AppTypography.bodyMedium.copyWith(
                      color: Colors.white.withAlpha(180),
                    ),
                  ).animate().fadeIn(delay: 300.ms, duration: 500.ms),
                  const SizedBox(height: 6),
                  Text(
                    'Prête à progresser\naujourd\'hui ?',
                    style: AppTypography.displayMedium.copyWith(
                      color: Colors.white,
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 500.ms, duration: 600.ms)
                      .slideY(begin: 0.2, curve: Curves.easeOut),
                  const SizedBox(height: 14),
                  // Animated XP counter.
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.gold.withAlpha(40),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star_rounded,
                                color: AppColors.gold, size: 18),
                            const SizedBox(width: 6),
                            Text(
                              '1 250 XP',
                              style: AppTypography.labelMedium.copyWith(
                                color: AppColors.goldLight,
                              ),
                            ),
                          ],
                        ),
                      )
                          .animate()
                          .fadeIn(delay: 700.ms, duration: 500.ms)
                          .slideX(begin: -0.3, curve: Curves.easeOut),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Continue Learning Card ────────────────────────────────────────
  Widget _buildContinueLearning() {
    return RepaintBoundary(
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.indigo, Color(0xFF3730A3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(22),
          boxShadow: AppShadows.glow(AppColors.indigo),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'CONTINUER MON APPRENTISSAGE',
                    style: AppTypography.labelSmall.copyWith(
                      color: Colors.white.withAlpha(180),
                    ),
                  ),
                ),
                const Icon(Icons.auto_awesome,
                    color: AppColors.goldLight, size: 18),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              "Les bases de l'entrepreneuriat",
              style: AppTypography.headlineMedium.copyWith(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 14),
            AnimatedProgressBar(
              value: 0.45,
              height: 6,
              backgroundColor: Colors.white.withAlpha(40),
              foregroundColor: AppColors.gold,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '45 % terminé · Leçon 6 sur 12',
                    style: AppTypography.bodySmall.copyWith(
                      color: Colors.white.withAlpha(180),
                    ),
                  ),
                ),
                const DepthButton(
                  label: 'Reprendre',
                  onPressed: _noop,
                  color: Color(0x33FFFFFF),
                ),
              ],
            ),
          ],
        ),
      )
          .animate()
          .fadeIn(delay: 200.ms, duration: 500.ms)
          .slideY(begin: 0.2, curve: Curves.easeOut),
    );
  }

  // ── Offline Banner ────────────────────────────────────────────────
  Widget _buildOfflineBanner() {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.mint.withAlpha(30),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.download_done_rounded,
                color: AppColors.mint, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lecture hors connexion protégée',
                  style: AppTypography.labelMedium,
                ),
                const SizedBox(height: 2),
                Text(
                  'Vos vidéos restent accessibles sans internet',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.shield_rounded,
              color: AppColors.mint, size: 22),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms, duration: 500.ms);
  }

  // ── Course Carousel ───────────────────────────────────────────────
  Widget _buildCourseCarousel(List<Course> courses) {
    return SizedBox(
      height: 230,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: courses.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          return CourseCarouselCard(course: courses[index]);
        },
      ),
    )
        .animate()
        .fadeIn(delay: 600.ms, duration: 500.ms)
        .slideX(begin: 0.1, curve: Curves.easeOut);
  }

  // ── Stats Section ─────────────────────────────────────────────────
  Widget _buildStatsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Vos statistiques', style: AppTypography.headlineLarge),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardTheme.color,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: AppShadows.card,
                ),
                child: Column(
                  children: [
                    ProgressRing(
                      value: 0.45,
                      foregroundColor: AppColors.indigo,
                      child: Text(
                        '45%',
                        style: AppTypography.labelLarge.copyWith(
                          color: AppColors.indigo,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text('Progression', style: AppTypography.labelMedium),
                    Text(
                      'totale',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                children: [
                  _statMiniCard(
                    icon: Icons.play_circle_rounded,
                    value: '6',
                    label: 'Leçons terminées',
                    color: AppColors.mint,
                  ),
                  const SizedBox(height: 14),
                  _statMiniCard(
                    icon: Icons.timer_rounded,
                    value: '2h 10',
                    label: "Temps d'étude",
                    color: AppColors.gold,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    )
        .animate()
        .fadeIn(delay: 800.ms, duration: 500.ms)
        .slideY(begin: 0.15, curve: Curves.easeOut);
  }

  Widget _statMiniCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(18),
        boxShadow: AppShadows.card,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withAlpha(25),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: AppTypography.headlineMedium),
                Text(
                  label,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
