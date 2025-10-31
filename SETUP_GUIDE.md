# 🚀 Инструкция по запуску Flutter проекта WMS Testing

## ✅ Что уже сделано:

1. **Структура проекта** - Clean Architecture (core/data/domain/presentation)
2. **Зависимости** - pubspec.yaml настроен со всеми необходимыми пакетами
3. **Модели Hive** - QuestionModel и TestResultModel с аннотациями
4. **Данные** - Все 25 вопросов конвертированы из JavaScript в Dart
5. **Тема приложения** - Material Design 3 с темной и светлой темами
6. **Стартовый экран** - UI с статистикой и кнопками запуска
7. **Main.dart** - Инициализация Hive и загрузка вопросов

## 📋 Следующие шаги для запуска:

### 1. Установите Flutter SDK

Если Flutter еще не установлен, следуйте инструкции:
- https://docs.flutter.dev/get-started/install

### 2. Перейдите в директорию проекта

```bash
cd /workspaces/wms_testing_flutter
```

### 3. Установите зависимости

```bash
flutter pub get
```

### 4. Сгенерируйте код для Hive TypeAdapters

**ВАЖНО!** Перед запуском необходимо сгенерировать TypeAdapters для Hive:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Эта команда создаст файлы:
- `lib/data/models/question_model.g.dart`
- `lib/data/models/test_result_model.g.dart`

### 5. Раскомментируйте код в main.dart

После генерации кода, раскомментируйте в `lib/main.dart`:

```dart
// Было:
// Hive.registerAdapter(QuestionModelAdapter());
// Hive.registerAdapter(TestResultModelAdapter());

// Станет:
Hive.registerAdapter(QuestionModelAdapter());
Hive.registerAdapter(TestResultModelAdapter());
```

### 6. Запустите приложение

```bash
# Для Android эмулятора или устройства
flutter run

# Для iOS симулятора
flutter run -d ios

# Для Web
flutter run -d chrome

# Для desktop (Linux/MacOS/Windows)
flutter run -d linux    # или macos, windows
```

## 🔧 Что нужно доделать:

### Приоритет 1: Bloc для управления состоянием
- [ ] Создать `lib/presentation/blocs/test/test_bloc.dart`
- [ ] Создать `lib/presentation/blocs/test/test_event.dart`
- [ ] Создать `lib/presentation/blocs/test/test_state.dart`
- [ ] Интегрировать Bloc в главный виджет

### Приоритет 2: Go_Router навигация
- [ ] Создать `lib/core/router/app_router.dart`
- [ ] Настроить роуты: `/`, `/test`, `/result`, `/history`
- [ ] Заменить MaterialApp на MaterialApp.router

### Приоритет 3: Экраны UI
- [ ] `lib/presentation/pages/question_page.dart` - экран вопроса
- [ ] `lib/presentation/pages/result_page.dart` - экран результатов
- [ ] `lib/presentation/pages/history_page.dart` - история тестов
- [ ] Виджеты: AnswerButton, ProgressBar, QuestionCard

### Приоритет 4: Firebase (опционально)
- [ ] Создать проект в Firebase Console
- [ ] Настроить FlutterFire CLI
- [ ] Добавить конфигурационные файлы
- [ ] Раскомментировать `await Firebase.initializeApp()` в main.dart
- [ ] Добавить Firebase Analytics события

## 🎨 Особенности проекта:

- **Clean Architecture** - разделение на слои
- **Hive** - быстрое локальное хранилище
- **Material Design 3** - современный UI
- **Темная тема** - автоматическое переключение
- **Google Fonts** - красивая типографика (Inter)
- **Type-safe** - использование Equatable и const

## 📚 Полезные команды:

```bash
# Проверить установленные устройства
flutter devices

# Анализ кода
flutter analyze

# Запуск тестов
flutter test

# Сборка APK (Android)
flutter build apk --release

# Сборка IPA (iOS)
flutter build ios --release

# Очистка проекта
flutter clean && flutter pub get
```

## 🐛 Возможные проблемы:

### 1. Ошибка "Adapter not registered"
**Решение:** Запустите `build_runner` и раскомментируйте регистрацию адаптеров

### 2. Ошибка импортов
**Решение:** Запустите `flutter pub get`

### 3. Проблемы с Firebase
**Решение:** Firebase пока закомментирован, можно использовать без него

## 📞 Контакты

**Автор**: Kiryushaboy  
**Репозиторий**: github.com/Kiryushaboy/wms_testing

---

**Приятного кодинга! 🚀**
