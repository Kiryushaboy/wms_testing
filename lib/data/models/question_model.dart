import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'question_model.g.dart';

@HiveType(typeId: 0)
class QuestionModel extends Equatable {
  @HiveField(0)
  final String question;

  @HiveField(1)
  final List<String> answers;

  @HiveField(2)
  final int correct;

  @HiveField(3)
  final String level;

  @HiveField(4)
  final String category;

  @HiveField(5)
  final String explanation;

  const QuestionModel({
    required this.question,
    required this.answers,
    required this.correct,
    required this.level,
    required this.category,
    required this.explanation,
  });

  @override
  List<Object?> get props => [
        question,
        answers,
        correct,
        level,
        category,
        explanation,
      ];

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'answers': answers,
      'correct': correct,
      'level': level,
      'category': category,
      'explanation': explanation,
    };
  }

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      question: json['question'] as String,
      answers: List<String>.from(json['answers'] as List),
      correct: json['correct'] as int,
      level: json['level'] as String,
      category: json['category'] as String,
      explanation: json['explanation'] as String,
    );
  }
}
