import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_typography.dart';
import '../../shared/widgets/depth_button.dart';

/// 3-page intro with parallax layers and "Commencer" button.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _currentPage = 0;

  static const _pages = <_OnboardingPage>[
    _OnboardingPage(
      icon: Icons.school_rounded,
      title: 'Apprenez à votre rythme',
      subtitle:
          'Des formations vidéo de qualité, accessibles partout, même sans connexion internet.',
      gradientColors: [Color(0xFF1E1B4B), Color(0xFF3730A3)],
    ),
    _OnboardingPage(
      icon: Icons.workspace_premium_rounded,
      title: 'Des compétences qui comptent',
      subtitle:
          'Business, marketing, finance, créativité — des parcours conçus par des experts locaux.',
      gradientColors: [Color(0xFF047857), Color(0xFF10B981)],
    ),
    _OnboardingPage(
      icon: Icons.rocket_launch_rounded,
      title: 'Lancez-vous maintenant',
      subtitle:
          'Rejoignez des milliers d\'apprenants au Burkina Faso et construisez votre avenir.',
      gradientColors: [Color(0xFFB45309), Color(0xFFF59E0B)],
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    if (_currentPage < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLast = _currentPage == _pages.length - 1;
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemCount: _pages.length,
            itemBuilder: (context, index) =>
                _OnboardingPageView(page: _pages[index]),
          ),
          // Bottom controls.
          Positioned(
            left: 24,
            right: 24,
            bottom: MediaQuery.of(context).padding.bottom + 32,
            child: Column(
              children: [
                // Page indicator dots.
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _pages.length,
                    (i) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: i == _currentPage ? 28 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: i == _currentPage
                            ? Colors.white
                            : Colors.white.withAlpha(80),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                DepthButton(
                  label: isLast ? 'Commencer' : 'Suivant',
                  icon: isLast ? Icons.arrow_forward_rounded : null,
                  color: Colors.white.withAlpha(40),
                  onPressed: _next,
                  width: double.infinity,
                ),
                if (!isLast) ...[
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => context.go('/home'),
                    child: Text(
                      'Passer',
                      style: AppTypography.labelMedium.copyWith(
                        color: Colors.white.withAlpha(160),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingPage {
  const _OnboardingPage({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.gradientColors,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final List<Color> gradientColors;
}

class _OnboardingPageView extends StatelessWidget {
  const _OnboardingPageView({required this.page});

  final _OnboardingPage page;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: page.gradientColors,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              // Parallax-ready icon placeholder (replace with 3D asset).
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.white.withAlpha(30),
                      Colors.white.withAlpha(8),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Icon(
                  page.icon,
                  size: 72,
                  color: Colors.white.withAlpha(230),
                ),
              )
                  .animate()
                  .scale(
                    begin: const Offset(0.6, 0.6),
                    duration: 700.ms,
                    curve: Curves.easeOutBack,
                  )
                  .fadeIn(duration: 500.ms),
              const Spacer(),
              Text(
                page.title,
                textAlign: TextAlign.center,
                style: AppTypography.displaySmall.copyWith(
                  color: Colors.white,
                ),
              )
                  .animate()
                  .fadeIn(delay: 200.ms, duration: 500.ms)
                  .slideY(begin: 0.2, curve: Curves.easeOut),
              const SizedBox(height: 16),
              Text(
                page.subtitle,
                textAlign: TextAlign.center,
                style: AppTypography.bodyLarge.copyWith(
                  color: Colors.white.withAlpha(200),
                  height: 1.6,
                ),
              )
                  .animate()
                  .fadeIn(delay: 400.ms, duration: 500.ms)
                  .slideY(begin: 0.2, curve: Curves.easeOut),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
