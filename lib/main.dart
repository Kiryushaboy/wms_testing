import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'data/datasources/questions_data.dart';
import 'data/models/question_model.dart';
import 'data/models/test_result_model.dart';
import 'presentation/pages/start_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register Hive Adapters
  Hive.registerAdapter(QuestionModelAdapter());
  Hive.registerAdapter(TestResultModelAdapter());

  // Open Hive Boxes
  await Hive.openBox<QuestionModel>(AppConstants.questionsBox);
  await Hive.openBox<TestResultModel>(AppConstants.resultsBox);
  await Hive.openBox(AppConstants.settingsBox);

  // Initialize questions in Hive if empty
  await _initializeQuestions();

  // TODO: Initialize Firebase
  // await Firebase.initializeApp();

  runApp(const WMSTestingApp());
}

Future<void> _initializeQuestions() async {
  final questionsBox = Hive.box<QuestionModel>(AppConstants.questionsBox);
  
  if (questionsBox.isEmpty) {
    final questions = QuestionsData.getAllQuestions();
    await questionsBox.addAll(questions);
    debugPrint('✅ Инициализировано ${questions.length} вопросов в Hive');
  } else {
    debugPrint('📦 Вопросы уже загружены: ${questionsBox.length} шт.');
  }
}

class WMSTestingApp extends StatelessWidget {
  const WMSTestingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const StartPage(),
      // TODO: Add Go_Router navigation
      // routerConfig: router,
    );
  }
}
