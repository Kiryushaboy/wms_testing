# 🏗 Архитектура проекта WMS Testing Flutter

## Обзор

Проект использует **Clean Architecture** с разделением на три основных слоя:
- **Presentation Layer** (UI + State Management)
- **Domain Layer** (Business Logic + Use Cases)
- **Data Layer** (Repositories + Data Sources)

## Структура директорий

```
lib/
├── main.dart                      # Точка входа приложения
├── core/                          # Общие утилиты и конфигурации
│   ├── constants/
│   │   └── app_constants.dart    # Константы приложения
│   ├── theme/
│   │   └── app_theme.dart        # Темы Material Design 3
│   ├── utils/                     # Вспомогательные функции
│   ├── errors/                    # Обработка ошибок
│   └── router/                    # Конфигурация навигации (Go_Router)
│
├── data/                          # Data Layer
│   ├── datasources/
│   │   ├── questions_data.dart   # Источник данных вопросов
│   │   └── local_data_source.dart # Hive local storage
│   ├── models/
│   │   ├── question_model.dart   # Модель вопроса (Hive)
│   │   └── test_result_model.dart # Модель результата (Hive)
│   └── repositories/
│       └── test_repository_impl.dart # Реализация репозитория
│
├── domain/                        # Domain Layer
│   ├── entities/
│   │   ├── question.dart         # Бизнес-сущность вопроса
│   │   └── test_result.dart      # Бизнес-сущность результата
│   ├── repositories/
│   │   └── test_repository.dart  # Интерфейс репозитория
│   └── usecases/
│       ├── get_questions.dart    # Use Case: получить вопросы
│       ├── save_result.dart      # Use Case: сохранить результат
│       └── get_history.dart      # Use Case: получить историю
│
└── presentation/                  # Presentation Layer
    ├── blocs/
    │   └── test/
    │       ├── test_bloc.dart    # Bloc для управления состоянием теста
    │       ├── test_event.dart   # События теста
    │       └── test_state.dart   # Состояния теста
    ├── pages/
    │   ├── start_page.dart       # Стартовый экран ✅
    │   ├── question_page.dart    # Экран вопроса
    │   ├── result_page.dart      # Экран результатов
    │   └── history_page.dart     # История тестов
    └── widgets/
        ├── answer_button.dart    # Кнопка ответа
        ├── progress_bar.dart     # Прогресс-бар
        ├── question_card.dart    # Карточка вопроса
        └── stat_card.dart        # Карточка статистики
```

## Технологический стек

### State Management
- **flutter_bloc** (^8.1.6) - Управление состоянием по паттерну BLoC
- **equatable** (^2.0.5) - Сравнение объектов для состояний

### Navigation
- **go_router** (^14.0.0) - Декларативная навигация

### Local Storage
- **hive** (^2.2.3) - NoSQL база данных
- **hive_flutter** (^1.1.0) - Flutter интеграция Hive
- **path_provider** (^2.1.2) - Пути к директориям

### Backend & API
- **dio** (^5.4.0) - HTTP клиент для API запросов

### Firebase
- **firebase_core** (^3.0.0) - Ядро Firebase
- **firebase_auth** (^5.0.0) - Аутентификация
- **firebase_analytics** (^11.0.0) - Аналитика
- **firebase_crashlytics** (^4.0.0) - Отчеты об ошибках

### UI & Design
- **google_fonts** (^6.1.0) - Шрифты (Inter)
- **flutter_svg** (^2.0.9) - SVG изображения
- **Material Design 3** - Современный UI

### Code Generation
- **build_runner** (^2.4.6) - Генерация кода
- **hive_generator** (^2.0.1) - Генерация TypeAdapters

## Поток данных

### 1. Начало теста
```
StartPage (UI)
    ↓ (нажатие кнопки)
TestBloc → TestStarted event
    ↓
GetQuestionsUseCase
    ↓
TestRepository
    ↓
LocalDataSource (Hive)
    ↓ (возврат данных)
TestBloc → TestLoaded state
    ↓
QuestionPage (UI) - отображение вопроса
```

### 2. Ответ на вопрос
```
QuestionPage (UI)
    ↓ (выбор ответа)
TestBloc → AnswerSelected event
    ↓ (валидация ответа)
TestBloc → QuestionAnswered state
    ↓ (следующий вопрос или завершение)
TestBloc → TestCompleted state
    ↓
SaveResultUseCase
    ↓
TestRepository
    ↓
LocalDataSource (Hive) - сохранение результата
```

### 3. Просмотр истории
```
HistoryPage (UI)
    ↓
TestBloc → LoadHistory event
    ↓
GetHistoryUseCase
    ↓
TestRepository
    ↓
LocalDataSource (Hive)
    ↓
TestBloc → HistoryLoaded state
    ↓
HistoryPage (UI) - отображение списка
```

## Bloc Pattern

### Events (TestEvent)
```dart
abstract class TestEvent extends Equatable {}

class TestStarted extends TestEvent {}
class AnswerSelected extends TestEvent {
  final int questionIndex;
  final int answerIndex;
}
class NextQuestion extends TestEvent {}
class TestCompleted extends TestEvent {}
class LoadHistory extends TestEvent {}
```

### States (TestState)
```dart
abstract class TestState extends Equatable {}

class TestInitial extends TestState {}
class TestLoading extends TestState {}
class TestLoaded extends TestState {
  final List<Question> questions;
  final int currentIndex;
}
class QuestionAnswered extends TestState {
  final bool isCorrect;
}
class TestCompleted extends TestState {
  final TestResult result;
}
class HistoryLoaded extends TestState {
  final List<TestResult> history;
}
class TestError extends TestState {
  final String message;
}
```

## Hive Box Structure

### 1. questions_box
```
Box<QuestionModel>
├── Key: 0  → QuestionModel (вопрос 1)
├── Key: 1  → QuestionModel (вопрос 2)
└── Key: 24 → QuestionModel (вопрос 25)
```

### 2. results_box
```
Box<TestResultModel>
├── Key: "uuid-1"  → TestResultModel (результат 1)
├── Key: "uuid-2"  → TestResultModel (результат 2)
└── Key: "uuid-n"  → TestResultModel (результат n)
```

### 3. settings_box
```
Box (dynamic)
├── "theme_mode"     → String (light/dark/system)
├── "sound_enabled"  → bool
└── "last_completed" → DateTime
```

## Навигация (Go_Router)

```dart
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => StartPage(),
    ),
    GoRoute(
      path: '/test',
      builder: (context, state) => QuestionPage(),
    ),
    GoRoute(
      path: '/result',
      builder: (context, state) => ResultPage(
        result: state.extra as TestResult,
      ),
    ),
    GoRoute(
      path: '/history',
      builder: (context, state) => HistoryPage(),
    ),
  ],
);
```

## Firebase Events (Analytics)

```dart
// Начало теста
FirebaseAnalytics.instance.logEvent(
  name: 'test_started',
  parameters: {'timestamp': DateTime.now().toString()},
);

// Завершение теста
FirebaseAnalytics.instance.logEvent(
  name: 'test_completed',
  parameters: {
    'score': result.percentage,
    'correct': result.correctAnswers,
    'wrong': result.wrongAnswers,
  },
);

// Ответ на вопрос
FirebaseAnalytics.instance.logEvent(
  name: 'question_answered',
  parameters: {
    'question_index': index,
    'is_correct': isCorrect,
    'category': question.category,
  },
);
```

## Принципы разработки

### SOLID
- **S** - Single Responsibility: каждый класс отвечает за одну функцию
- **O** - Open/Closed: открыт для расширения, закрыт для изменения
- **L** - Liskov Substitution: подклассы заменяемы базовыми классами
- **I** - Interface Segregation: много специализированных интерфейсов
- **D** - Dependency Inversion: зависимость от абстракций

### DRY (Don't Repeat Yourself)
- Переиспользование виджетов
- Общие утилиты в `core/utils`
- Константы в одном месте

### KISS (Keep It Simple, Stupid)
- Простая и понятная структура
- Минимум магии
- Четкое разделение ответственности

## Тестирование

```bash
# Unit тесты
flutter test test/unit/

# Widget тесты
flutter test test/widget/

# Integration тесты
flutter test test/integration/

# Bloc тесты (с bloc_test)
flutter test test/bloc/
```

## Производительность

### Оптимизации
- `const` конструкторы везде где возможно
- Кэширование изображений
- Lazy loading списков истории
- Debouncing для поиска
- Использование `ValueListenableBuilder` для Hive

### Мониторинг
- Firebase Crashlytics для ошибок
- Firebase Analytics для метрик
- Performance overlay в debug режиме

---

**Дата создания**: 31.10.2025  
**Версия**: 1.0.0  
**Автор**: Kiryushaboy
