import 'package:material_ui/material_ui.dart';

void main() {
  runApp(const NourouAcademyApp());
}

class NourouAcademyApp extends StatelessWidget {
  const NourouAcademyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF087F5B);
    return MaterialApp(
      title: 'Nourou Academy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F8F5),
        colorScheme: ColorScheme.fromSeed(
          seedColor: green,
          primary: green,
          surface: Colors.white,
        ),
        fontFamily: 'Roboto',
      ),
      home: const AcademyHomePage(),
    );
  }
}

class Course {
  const Course({
    required this.title,
    required this.category,
    required this.description,
    required this.duration,
    required this.lessons,
    required this.price,
    required this.icon,
    required this.color,
    required this.progress,
  });

  final String title;
  final String category;
  final String description;
  final String duration;
  final int lessons;
  final int price;
  final IconData icon;
  final Color color;
  final double progress;
}

const courses = <Course>[
  Course(
    title: 'Les bases de l’entrepreneuriat',
    category: 'Business',
    description:
        'Transformez votre idée en un projet solide : étude de marché, modèle économique et premières étapes pour vous lancer.',
    duration: '3 h 20',
    lessons: 12,
    price: 15000,
    icon: Icons.lightbulb_outline_rounded,
    color: Color(0xFFFFB64D),
    progress: 0.45,
  ),
  Course(
    title: 'Maîtriser le marketing digital',
    category: 'Marketing',
    description:
        'Apprenez à développer votre présence en ligne, créer du contenu efficace et trouver vos premiers clients.',
    duration: '4 h 10',
    lessons: 16,
    price: 20000,
    icon: Icons.campaign_outlined,
    color: Color(0xFF7C83FD),
    progress: 0,
  ),
  Course(
    title: 'Finance personnelle au quotidien',
    category: 'Finance',
    description:
        'Prenez le contrôle de votre budget, épargnez avec méthode et posez les bases d’une bonne santé financière.',
    duration: '2 h 45',
    lessons: 10,
    price: 12000,
    icon: Icons.account_balance_wallet_outlined,
    color: Color(0xFF44BBA4),
    progress: 0,
  ),
  Course(
    title: 'Créer du contenu avec son smartphone',
    category: 'Créativité',
    description:
        'Filmez, montez et publiez des vidéos soignées avec les outils que vous avez déjà dans votre poche.',
    duration: '2 h 15',
    lessons: 9,
    price: 10000,
    icon: Icons.video_camera_back_outlined,
    color: Color(0xFFFF7B72),
    progress: 0,
  ),
];

class AcademyHomePage extends StatefulWidget {
  const AcademyHomePage({super.key});

  @override
  State<AcademyHomePage> createState() => _AcademyHomePageState();
}

class _AcademyHomePageState extends State<AcademyHomePage> {
  int _selectedTab = 0;
  String _selectedCategory = 'Tout';
  String _searchQuery = '';
  final Set<String> _purchasedCourses = {'Les bases de l’entrepreneuriat'};

  List<Course> get _filteredCourses {
    return courses.where((course) {
      final matchesCategory =
          _selectedCategory == 'Tout' || course.category == _selectedCategory;
      final matchesSearch = course.title
              .toLowerCase()
              .contains(_searchQuery.trim().toLowerCase()) ||
          course.category.toLowerCase().contains(_searchQuery.trim().toLowerCase());
      final isOwned = _purchasedCourses.contains(course.title);
      return matchesCategory &&
          matchesSearch &&
          (_selectedTab != 1 || isOwned);
    }).toList();
  }

  void _openCourse(Course course) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CourseDetailsSheet(
        course: course,
        isPurchased: _purchasedCourses.contains(course.title),
        onPurchase: () {
          setState(() => _purchasedCourses.add(course.title));
          Navigator.pop(context);
          ScaffoldMessenger.of(this.context).showSnackBar(
            const SnackBar(
              content: Text('Formation ajoutée à vos cours !'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isProfile = _selectedTab == 3;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F8F5),
        surfaceTintColor: Colors.transparent,
        titleSpacing: 20,
        title: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: const Color(0xFF087F5B),
                borderRadius: BorderRadius.circular(13),
              ),
              child: const Icon(Icons.auto_awesome, color: Colors.white, size: 21),
            ),
            const SizedBox(width: 10),
            const Text(
              'Nourou',
              style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: -0.5),
            ),
            const SizedBox(width: 4),
            const Text(
              'Academy',
              style: TextStyle(
                color: Color(0xFF087F5B),
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Notifications',
            onPressed: () {},
            icon: const Badge(
              smallSize: 8,
              backgroundColor: Color(0xFFFF7B72),
              child: Icon(Icons.notifications_none_rounded),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        top: false,
        child: isProfile
            ? const ProfileView()
            : _buildCourseContent(),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedTab,
        onDestinationSelected: (index) {
          setState(() {
            _selectedTab = index;
            _selectedCategory = 'Tout';
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Accueil',
          ),
          NavigationDestination(
            icon: Icon(Icons.play_circle_outline_rounded),
            selectedIcon: Icon(Icons.play_circle_rounded),
            label: 'Mes cours',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore_rounded),
            label: 'Catalogue',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  Widget _buildCourseContent() {
    final isMyCourses = _selectedTab == 1;
    final showWelcome = _selectedTab == 0;
    final categories = ['Tout', 'Business', 'Marketing', 'Finance', 'Créativité'];

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
      children: [
        if (showWelcome) ...[
          const Text(
            'Apprenez quelque chose\nde nouveau aujourd’hui ✨',
            style: TextStyle(
              fontSize: 25,
              height: 1.2,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.8,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Bonjour, Awa 👋 Prête à progresser ?',
            style: TextStyle(color: Colors.blueGrey.shade600, fontSize: 14),
          ),
          const SizedBox(height: 20),
          _buildLearningCard(),
          const SizedBox(height: 26),
        ],
        TextField(
          onChanged: (value) => setState(() => _searchQuery = value),
          decoration: InputDecoration(
            hintText: 'Rechercher une formation',
            prefixIcon: const Icon(Icons.search_rounded),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 22),
        Row(
          children: [
            Expanded(
              child: Text(
                isMyCourses ? 'Mes formations' : 'Explorer les formations',
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.4,
                ),
              ),
            ),
            Text(
              '${_filteredCourses.length} formations',
              style: TextStyle(color: Colors.blueGrey.shade500, fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 13),
        SizedBox(
          height: 38,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final category = categories[index];
              final selected = category == _selectedCategory;
              return ChoiceChip(
                label: Text(category),
                selected: selected,
                showCheckmark: false,
                onSelected: (_) => setState(() => _selectedCategory = category),
                labelStyle: TextStyle(
                  color: selected ? Colors.white : const Color(0xFF53615C),
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                backgroundColor: Colors.white,
                selectedColor: const Color(0xFF087F5B),
                side: BorderSide.none,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 15),
        if (_filteredCourses.isEmpty)
          _buildEmptyState(isMyCourses)
        else
          ..._filteredCourses.map(
            (course) => Padding(
              padding: const EdgeInsets.only(bottom: 13),
              child: CourseCard(
                course: course,
                isPurchased: _purchasedCourses.contains(course.title),
                onTap: () => _openCourse(course),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildLearningCard() {
    final course = courses.first;
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF087F5B), Color(0xFF10A477)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF087F5B).withAlpha(46),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'CONTINUER MON APPRENTISSAGE',
                  style: TextStyle(
                    color: Color(0xFFD8F4E9),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              Icon(Icons.auto_awesome, color: Colors.amber.shade200, size: 18),
            ],
          ),
          const SizedBox(height: 13),
          Text(
            course.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: LinearProgressIndicator(
              value: course.progress,
              minHeight: 6,
              backgroundColor: const Color(0x5577C9AA),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Color(0xFFFFD166)),
            ),
          ),
          const SizedBox(height: 9),
          Row(
            children: [
              const Expanded(
                child: Text(
                  '45 % terminé · Leçon 6 sur 12',
                  style: TextStyle(color: Colors.white, fontSize: 11),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () => _openCourse(course),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 13,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Row(
                    children: [
                      Text(
                        'Reprendre',
                        style: TextStyle(
                          color: Color(0xFF087F5B),
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: Color(0xFF087F5B),
                        size: 14,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(bool isMyCourses) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 42),
      child: Column(
        children: [
          const Icon(
            Icons.menu_book_outlined,
            size: 42,
            color: Color(0xFF9BAAA3),
          ),
          const SizedBox(height: 12),
          Text(
            isMyCourses ? 'Vos cours apparaîtront ici' : 'Aucun résultat trouvé',
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
          const SizedBox(height: 5),
          Text(
            isMyCourses
                ? 'Explorez le catalogue pour commencer.'
                : 'Essayez un autre mot-clé ou une catégorie.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.blueGrey.shade500, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  const CourseCard({
    required this.course,
    required this.isPurchased,
    required this.onTap,
    super.key,
  });

  final Course course;
  final bool isPurchased;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 76,
                height: 84,
                decoration: BoxDecoration(
                  color: course.color.withAlpha(36),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(course.icon, size: 33, color: course.color),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.category.toUpperCase(),
                      style: TextStyle(
                        color: course.color,
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.7,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      course.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        Icon(
                          Icons.play_circle_outline_rounded,
                          size: 14,
                          color: Colors.blueGrey.shade400,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          '${course.lessons} leçons · ${course.duration}',
                          style: TextStyle(
                            color: Colors.blueGrey.shade500,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      isPurchased ? 'Déjà dans mes cours' : '${course.price} FCFA',
                      style: const TextStyle(
                        color: Color(0xFF26332D),
                        fontWeight: FontWeight.w800,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.chevron_right_rounded,
                color: Colors.blueGrey.shade300,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CourseDetailsSheet extends StatelessWidget {
  const CourseDetailsSheet({
    required this.course,
    required this.isPurchased,
    required this.onPurchase,
    super.key,
  });

  final Course course;
  final bool isPurchased;
  final VoidCallback onPurchase;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.78,
      minChildSize: 0.55,
      maxChildSize: 0.92,
      builder: (context, scrollController) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFFF7F8F5),
          borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
        ),
        child: ListView(
          controller: scrollController,
          padding: const EdgeInsets.fromLTRB(22, 12, 22, 28),
          children: [
            Center(
              child: Container(
                width: 38,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFD4DCD7),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 165,
              decoration: BoxDecoration(
                color: course.color.withAlpha(41),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(course.icon, size: 64, color: course.color),
            ),
            const SizedBox(height: 20),
            Text(
              course.category.toUpperCase(),
              style: TextStyle(
                color: course.color,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              course.title,
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w800,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _detailMetric(Icons.schedule_rounded, course.duration),
                const SizedBox(width: 18),
                _detailMetric(
                  Icons.video_library_outlined,
                  '${course.lessons} leçons',
                ),
                const SizedBox(width: 18),
                _detailMetric(Icons.star_rounded, '4,9'),
              ],
            ),
            const SizedBox(height: 22),
            const Text(
              'À propos de cette formation',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              course.description,
              style: TextStyle(
                color: Colors.blueGrey.shade700,
                height: 1.55,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 22),
            const Text(
              'Ce que vous allez apprendre',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
            ),
            const SizedBox(height: 11),
            const _LearningPoint(text: 'Des compétences pratiques à appliquer'),
            const _LearningPoint(text: 'Un parcours progressif en vidéo'),
            const _LearningPoint(text: 'Un suivi de votre progression'),
            const SizedBox(height: 24),
            SizedBox(
              height: 54,
              child: FilledButton(
                onPressed: isPurchased ? null : onPurchase,
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF087F5B),
                  disabledBackgroundColor: const Color(0xFFD8E8E1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  isPurchased
                      ? 'Déjà dans mes cours'
                      : 'Acheter · ${course.price} FCFA',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: isPurchased ? const Color(0xFF087F5B) : Colors.white,
                  ),
                ),
              ),
            ),
            if (!isPurchased) ...[
              const SizedBox(height: 8),
              Text(
                'Paiement de démonstration — aucun débit réel',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blueGrey.shade500, fontSize: 11),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _detailMetric(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 15, color: const Color(0xFF087F5B)),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class _LearningPoint extends StatelessWidget {
  const _LearningPoint({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_rounded,
            color: Color(0xFF087F5B),
            size: 18,
          ),
          const SizedBox(width: 9),
          Text(text, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SizedBox(height: 14),
        Center(
          child: Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
              color: const Color(0xFFDDF2E9),
              borderRadius: BorderRadius.circular(28),
            ),
            child: const Center(
              child: Text(
                'A',
                style: TextStyle(
                  color: Color(0xFF087F5B),
                  fontSize: 38,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 13),
        const Text(
          'Awa Diallo',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 21),
        ),
        const SizedBox(height: 4),
        Text(
          'awa.diallo@example.com',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.blueGrey.shade500, fontSize: 13),
        ),
        const SizedBox(height: 25),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFF087F5B),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            children: [
              Icon(Icons.local_fire_department_rounded, color: Colors.amber),
              SizedBox(width: 11),
              Expanded(
                child: Text(
                  'Votre série d’apprentissage',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
              Text(
                '3 jours 🔥',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const _ProfileOption(
          icon: Icons.receipt_long_outlined,
          title: 'Historique des achats',
        ),
        const _ProfileOption(
          icon: Icons.workspace_premium_outlined,
          title: 'Mes certificats',
        ),
        const _ProfileOption(
          icon: Icons.devices_outlined,
          title: 'Mes appareils',
        ),
        const _ProfileOption(
          icon: Icons.settings_outlined,
          title: 'Paramètres',
        ),
      ],
    );
  }
}

class _ProfileOption extends StatelessWidget {
  const _ProfileOption({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
      leading: Icon(icon, color: const Color(0xFF087F5B)),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      ),
      trailing: const Icon(Icons.chevron_right_rounded),
      onTap: () {},
    );
  }
}
