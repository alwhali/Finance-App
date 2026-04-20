1. Add Dependencies
dependencies:
  hive: ^2.2.3
  hive_flutter: ^1.1.0

dev_dependencies:
  hive_generator: ^2.0.1
  build_runner: ^2.4.6

2. Annotate Your Data Model
Annotate your class and its fields so the generator knows what to include: 
- @HiveType(typeId: number): Annotate the class with a unique typeId (0–223).
- @HiveField(index): Annotate every field you want to store with a unique index number.
- part 'filename.g.dart';: Add this directive at the top of your file to link the generated code. 

Example (user.dart):
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  int age;

  User({required this.name, required this.age});
}


3. Run the Generator
Run the following command in your terminal to generate the .g.dart file:
dart run build_runner build

Note: Use --delete-conflicting-outputs if you encounter errors from previous runs.

4. Register the Adapter
Before opening a box that uses your custom type, you must register the generated adapter in your main() function:

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter()); // UserAdapter is generated in user.g.dart
  await Hive.openBox<User>('userBox');
  runApp(MyApp());
}

