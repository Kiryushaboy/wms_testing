# Руководство по участию в проекте

Спасибо за интерес к проекту WMS Testing App! 🎉

## Как внести вклад

### 1. Сообщение об ошибках (Bug Reports)

Если вы нашли ошибку:

1. Проверьте, не была ли она уже сообщена в [Issues](https://github.com/Kiryushaboy/wms_testing/issues)
2. Создайте новый Issue с описанием:
   - Подробное описание проблемы
   - Шаги для воспроизведения
   - Ожидаемое поведение
   - Фактическое поведение
   - Скриншоты (если применимо)
   - Версия Flutter и устройство
   
**Шаблон:**
```markdown
**Описание:**
Краткое описание проблемы

**Шаги воспроизведения:**
1. Откройте...
2. Нажмите на...
3. Увидите...

**Ожидаемое поведение:**
Что должно было произойти

**Фактическое поведение:**
Что произошло

**Окружение:**
- Flutter версия: 
- Устройство: 
- OS:
```

### 2. Предложение новых функций (Feature Requests)

Хотите предложить новую функцию?

1. Опишите проблему, которую решает функция
2. Предложите своё решение
3. Укажите альтернативные варианты
4. Добавьте примеры использования

**Шаблон:**
```markdown
**Описание проблемы:**
Какую задачу решает функция

**Предлагаемое решение:**
Как должна работать функция

**Альтернативы:**
Другие способы решения

**Дополнительный контекст:**
Скриншоты, схемы, примеры
```

### 3. Pull Requests

#### Процесс создания PR

1. **Fork репозитория**
   ```bash
   # Клонируйте свой fork
   git clone https://github.com/ваш-username/wms_testing.git
   cd wms_testing
   ```

2. **Создайте новую ветку**
   ```bash
   git checkout -b feature/название-функции
   # или
   git checkout -b fix/название-исправления
   ```

3. **Внесите изменения**
   - Следуйте стилю кодирования проекта
   - Добавьте комментарии к сложным участкам
   - Обновите документацию при необходимости

4. **Протестируйте изменения**
   ```bash
   flutter test
   flutter analyze
   ```

5. **Коммит изменений**
   ```bash
   git add .
   git commit -m "feat: Добавлена новая функция X"
   ```

6. **Push в ваш fork**
   ```bash
   git push origin feature/название-функции
   ```

7. **Создайте Pull Request**
   - Используйте понятный заголовок
   - Опишите что изменено и зачем
   - Добавьте скриншоты/видео (для UI изменений)
   - Свяжите с соответствующим Issue

#### Требования к PR

- ✅ Код проходит `flutter analyze` без ошибок
- ✅ Все тесты проходят успешно
- ✅ Добавлены комментарии к публичным API
- ✅ Обновлена документация (если требуется)
- ✅ Следует [Conventional Commits](https://www.conventionalcommits.org/)
- ✅ Один PR = одна задача (избегайте смешанных изменений)

## Стиль кодирования

### Flutter/Dart Style Guide

Следуйте официальному [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)

**Основные правила:**

```dart
// ✅ Правильно
class MyWidget extends StatelessWidget {
  const MyWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Text(title),
    );
  }
}

// ❌ Неправильно
class myWidget extends StatelessWidget {
  String title;
  
  myWidget(this.title);
  
  Widget build(context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Text(title));
  }
}
```

### Именование

- **Классы**: `PascalCase` (например, `TestBloc`, `QuestionModel`)
- **Методы/Функции**: `camelCase` (например, `submitAnswer`, `calculateScore`)
- **Константы**: `camelCase` (например, `totalQuestions`, `passingPercentage`)
- **Файлы**: `snake_case` (например, `test_bloc.dart`, `question_model.dart`)

### Структура кода

```
lib/
├── core/              # Общие компоненты
│   ├── constants/     # Константы приложения
│   ├── theme/         # Темы Material Design
│   └── utils/         # Утилиты
├── data/              # Слой данных
│   ├── datasources/   # Источники данных
│   ├── models/        # Модели данных
│   └── repositories/  # Реализация репозиториев
├── domain/            # Бизнес-логика
│   ├── entities/      # Сущности домена
│   ├── repositories/  # Абстракции репозиториев
│   └── usecases/      # Сценарии использования
└── presentation/      # UI слой
    ├── bloc/          # BLoC состояния
    ├── pages/         # Экраны приложения
    └── widgets/       # Переиспользуемые виджеты
```

## Commit Messages

Используйте [Conventional Commits](https://www.conventionalcommits.org/):

```
<тип>(<область>): <описание>

[необязательное тело]

[необязательный футер]
```

**Типы:**
- `feat`: Новая функция
- `fix`: Исправление ошибки
- `docs`: Изменения в документации
- `style`: Форматирование, отступы (без изменения кода)
- `refactor`: Рефакторинг кода
- `test`: Добавление тестов
- `chore`: Обновление зависимостей, конфигурации

**Примеры:**
```bash
feat(auth): добавлена авторизация через Firebase
fix(test): исправлен подсчет баллов при пропуске вопросов
docs(readme): обновлена инструкция по установке
refactor(bloc): упрощена логика TestBloc
test(models): добавлены unit-тесты для QuestionModel
```

## Настройка окружения

### Требования

- Flutter SDK >=3.2.0
- Dart SDK >=3.2.0
- IDE: Android Studio / VS Code с Flutter плагином

### Установка

1. Клонируйте репозиторий:
   ```bash
   git clone https://github.com/Kiryushaboy/wms_testing.git
   cd wms_testing
   ```

2. Установите зависимости:
   ```bash
   flutter pub get
   ```

3. Генерируйте код для Hive:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. Запустите приложение:
   ```bash
   flutter run
   ```

### Полезные команды

```bash
# Анализ кода
flutter analyze

# Запуск тестов
flutter test

# Проверка форматирования
dart format --set-exit-if-changed .

# Автоформатирование
dart format .

# Генерация кода
flutter pub run build_runner build --delete-conflicting-outputs

# Очистка билд кэша
flutter clean
```

## Процесс ревью

1. Автоматические проверки (CI/CD)
   - Flutter analyze
   - Тесты
   - Форматирование кода

2. Код-ревью от мейнтейнеров
   - Соответствие стилю
   - Архитектурные решения
   - Производительность
   - Тестирование

3. Одобрение и merge
   - Минимум 1 approve
   - Все проверки пройдены
   - Конфликты разрешены

## Вопросы?

Есть вопросы? Свяжитесь с нами:

- 📧 Email: kiryushaboy@example.com
- 💬 Telegram: @kiryushaboy
- 🐛 Issues: [GitHub Issues](https://github.com/Kiryushaboy/wms_testing/issues)

---

**Спасибо за вклад в проект! 🚀**
