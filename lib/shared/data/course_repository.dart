import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/course.dart';

/// Abstract contract – swappable with Firebase/Supabase later.
abstract class CourseRepository {
  Future<List<Course>> getAllCourses();
  Future<List<Course>> getPurchasedCourses(String userId);
  Future<Course?> getCourseById(String id);
}

/// Mock implementation with local data.
class MockCourseRepository implements CourseRepository {
  static const _courses = <Course>[
    Course(
      id: 'entrepreneuriat',
      title: "Les bases de l'entrepreneuriat",
      category: 'Business',
      description:
          "Transformez votre idée en un projet solide : étude de marché, "
          "modèle économique et premières étapes pour vous lancer.",
      duration: '3 h 20',
      lessons: 12,
      price: 15000,
      icon: Icons.lightbulb_outline_rounded,
      color: Color(0xFFF59E0B),
      progress: 0.45,
    ),
    Course(
      id: 'marketing-digital',
      title: 'Maîtriser le marketing digital',
      category: 'Marketing',
      description:
          "Apprenez à développer votre présence en ligne, créer du contenu "
          "efficace et trouver vos premiers clients.",
      duration: '4 h 10',
      lessons: 16,
      price: 20000,
      icon: Icons.campaign_outlined,
      color: Color(0xFF7C83FD),
    ),
    Course(
      id: 'finance-personnelle',
      title: 'Finance personnelle au quotidien',
      category: 'Finance',
      description:
          "Prenez le contrôle de votre budget, épargnez avec méthode "
          "et posez les bases d'une bonne santé financière.",
      duration: '2 h 45',
      lessons: 10,
      price: 12000,
      icon: Icons.account_balance_wallet_outlined,
      color: Color(0xFF10B981),
    ),
    Course(
      id: 'contenu-smartphone',
      title: 'Créer du contenu avec son smartphone',
      category: 'Créativité',
      description:
          "Filmez, montez et publiez des vidéos soignées avec les outils "
          "que vous avez déjà dans votre poche.",
      duration: '2 h 15',
      lessons: 9,
      price: 10000,
      icon: Icons.video_camera_back_outlined,
      color: Color(0xFFEF4444),
    ),
    Course(
      id: 'leadership',
      title: 'Leadership et gestion d\'équipe',
      category: 'Business',
      description:
          "Développez votre capacité à motiver, déléguer et conduire "
          "une équipe vers ses objectifs.",
      duration: '3 h 00',
      lessons: 11,
      price: 18000,
      icon: Icons.groups_outlined,
      color: Color(0xFF3730A3),
    ),
  ];

  @override
  Future<List<Course>> getAllCourses() async => _courses;

  @override
  Future<List<Course>> getPurchasedCourses(String userId) async {
    // Mock: first course is purchased.
    return [_courses.first];
  }

  @override
  Future<Course?> getCourseById(String id) async {
    return _courses.where((c) => c.id == id).firstOrNull;
  }
}

/// Riverpod providers.
final courseRepositoryProvider = Provider<CourseRepository>(
  (_) => MockCourseRepository(),
);

final allCoursesProvider = FutureProvider<List<Course>>((ref) {
  return ref.read(courseRepositoryProvider).getAllCourses();
});
