import 'package:menuapp/models/models.dart';

class Mapper {
  static String mapHardnessToText(DishHardness hardness) {
    switch (hardness) {
      case DishHardness.easy:
        return 'Easy';
      case DishHardness.medium:
        return 'Medium';
      case DishHardness.hard:
        return 'Hard';
      case DishHardness.veryHard:
        return 'Very Hard';
    }
  }

  static String mapTimeToText(CookingTime time) {
    switch (time) {
      case CookingTime.lessThan15min:
        return 'less 15 min';
      case CookingTime.min15:
        return '15 min';
      case CookingTime.min30:
        return '30 min';
      case CookingTime.min45:
        return '45 min';
      case CookingTime.hour1:
        return '1 hour';
      case CookingTime.moreThanHour1:
        return '1 hour+';
    }
  }
}
