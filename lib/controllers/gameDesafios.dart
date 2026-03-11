import 'package:squadbox/controllers/gameController.dart';
import 'package:squadbox/models/enum_desafios.dart';
import 'package:squadbox/models/enum_enemy.dart';

class Desafios {

  final List<DesafiosItem> items;
  final GameController gameController;

  Desafios({required this.gameController, required this.items});

  void add(DesafiosItem item) {
    items.add(item);
  }

  int countbyenemytype(EnemyType enemyTypehere) {
    int count = 0;
    for (final f in items) {
      if (f.enemytype == enemyTypehere) {
        count = f.quantidade;
      }
    }
    return count;
  }
}

class DesafiosItem {
   final EnemyType enemytype;
   final String name;
   final DesafiosGame desafio;
   final int quantidade;

   DesafiosItem({
     required this.name,
     required this.enemytype,
     required this.desafio,
     required this.quantidade,
   });
}
