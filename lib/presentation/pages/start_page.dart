import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/test_result_model.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo/Icon
              const Icon(
                Icons.warehouse_rounded,
                size: 120,
                color: AppTheme.primaryColor,
              ),
              const SizedBox(height: 32),
              
              // Title
              Text(
                'WMS Testing',
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              
              // Subtitle
              Text(
                'Проверьте свои знания по системам управления складом',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.textSecondaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              
              // Stats Card
              _buildStatsCard(context),
              const SizedBox(height: 32),
              
              // Start Test Button
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Navigate to test
                  _showComingSoonDialog(context);
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text('Начать тест'),
              ),
              const SizedBox(height: 16),
              
              // History Button
              OutlinedButton.icon(
                onPressed: () {
                  // TODO: Navigate to history
                  _showComingSoonDialog(context);
                },
                icon: const Icon(Icons.history),
                label: const Text('История результатов'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsCard(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<TestResultModel>(AppConstants.resultsBox).listenable(),
      builder: (context, Box<TestResultModel> box, _) {
        final totalTests = box.length;
        
        if (totalTests == 0) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Icon(
                    Icons.quiz_outlined,
                    size: 48,
                    color: AppTheme.primaryColor.withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Вы еще не прошли ни одного теста',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${AppConstants.totalQuestions} вопросов ждут вас!',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }

        // Calculate average score
        double avgScore = 0;
        if (totalTests > 0) {
          double sum = 0;
          for (var result in box.values) {
            sum += result.percentage;
          }
          avgScore = sum / totalTests;
        }

        // Find best result
        TestResultModel? bestResult;
        for (var result in box.values) {
          if (bestResult == null || result.percentage > bestResult.percentage) {
            bestResult = result;
          }
        }

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Text(
                  'Ваша статистика',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem(
                      context,
                      'Тестов пройдено',
                      totalTests.toString(),
                      Icons.assignment_turned_in,
                    ),
                    _buildStatItem(
                      context,
                      'Средний балл',
                      '${avgScore.toStringAsFixed(0)}%',
                      Icons.trending_up,
                    ),
                    _buildStatItem(
                      context,
                      'Лучший результат',
                      '${bestResult?.percentage.toStringAsFixed(0) ?? 0}%',
                      Icons.emoji_events,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Column(
      children: [
        Icon(icon, color: AppTheme.primaryColor),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            color: AppTheme.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  void _showComingSoonDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('🚧 В разработке'),
        content: const Text(
          'Эта функция будет доступна после завершения настройки Bloc и Go_Router.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
