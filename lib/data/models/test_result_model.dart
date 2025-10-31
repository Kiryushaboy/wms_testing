import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'test_result_model.g.dart';

@HiveType(typeId: 1)
class TestResultModel extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime completedAt;

  @HiveField(2)
  final int totalQuestions;

  @HiveField(3)
  final int correctAnswers;

  @HiveField(4)
  final int wrongAnswers;

  @HiveField(5)
  final double percentage;

  @HiveField(6)
  final String level;

  @HiveField(7)
  final Map<String, int> categoryStats; // category -> correct count

  @HiveField(8)
  final List<int> userAnswers; // индексы выбранных ответов

  @HiveField(9)
  final int durationSeconds;

  const TestResultModel({
    required this.id,
    required this.completedAt,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.percentage,
    required this.level,
    required this.categoryStats,
    required this.userAnswers,
    required this.durationSeconds,
  });

  @override
  List<Object?> get props => [
        id,
        completedAt,
        totalQuestions,
        correctAnswers,
        wrongAnswers,
        percentage,
        level,
        categoryStats,
        userAnswers,
        durationSeconds,
      ];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'completedAt': completedAt.toIso8601String(),
      'totalQuestions': totalQuestions,
      'correctAnswers': correctAnswers,
      'wrongAnswers': wrongAnswers,
      'percentage': percentage,
      'level': level,
      'categoryStats': categoryStats,
      'userAnswers': userAnswers,
      'durationSeconds': durationSeconds,
    };
  }

  factory TestResultModel.fromJson(Map<String, dynamic> json) {
    return TestResultModel(
      id: json['id'] as String,
      completedAt: DateTime.parse(json['completedAt'] as String),
      totalQuestions: json['totalQuestions'] as int,
      correctAnswers: json['correctAnswers'] as int,
      wrongAnswers: json['wrongAnswers'] as int,
      percentage: (json['percentage'] as num).toDouble(),
      level: json['level'] as String,
      categoryStats: Map<String, int>.from(json['categoryStats'] as Map),
      userAnswers: List<int>.from(json['userAnswers'] as List),
      durationSeconds: json['durationSeconds'] as int,
    );
  }
}
