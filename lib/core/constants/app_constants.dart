// App Constants
class AppConstants {
  // App Info
  static const String appName = 'WMS Testing';
  static const String appVersion = '1.0.0';

  // Hive Box Names
  static const String questionsBox = 'questions_box';
  static const String resultsBox = 'results_box';
  static const String settingsBox = 'settings_box';

  // Test Configuration
  static const int totalQuestions = 25;
  static const int passingPercentage = 70;

  // Levels
  static const String levelBeginner = 'Начальный';
  static const String levelIntermediate = 'Средний';
  static const String levelAdvanced = 'Продвинутый';

  // Categories
  static const String categoryReceiving = 'Приемка';
  static const String categoryPlacement = 'Размещение';
  static const String categoryPicking = 'Комплектация';
  static const String categoryInventory = 'Инвентаризация';
  static const String categoryShipment = 'Отгрузка';
  static const String categoryReturns = 'Возвраты';
  static const String categorySystem = 'Система';

  // Routes
  static const String routeSplash = '/';
  static const String routeStart = '/start';
  static const String routeTest = '/test';
  static const String routeResult = '/result';
  static const String routeHistory = '/history';

  // Animation Durations
  static const Duration shortDuration = Duration(milliseconds: 200);
  static const Duration mediumDuration = Duration(milliseconds: 300);
  static const Duration longDuration = Duration(milliseconds: 500);

  // Firebase Event Names
  static const String eventTestStarted = 'test_started';
  static const String eventTestCompleted = 'test_completed';
  static const String eventQuestionAnswered = 'question_answered';
}
