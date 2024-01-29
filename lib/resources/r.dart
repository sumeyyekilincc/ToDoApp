
import 'package:todo_app/resources/animations.dart';
import 'package:todo_app/resources/drawable.dart';

class R {
  static void refreshClass() {
    _drawable = null;

    _animations = null;
  }

  static Drawable? _drawable;
  static Drawable get drawable => _drawable ??= Drawable();



  static Animations? _animations;
  static Animations get animations => _animations ??= Animations();
}