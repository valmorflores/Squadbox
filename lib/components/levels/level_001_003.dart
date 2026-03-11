import 'package:squadbox/components/enemy.dart';
import 'package:squadbox/components/tools.dart';
import 'package:squadbox/controllers/gameController.dart';
import 'package:squadbox/controllers/gameDesafios.dart';
import 'package:squadbox/models/enum_desafios.dart';
import 'package:squadbox/models/enum_enemy.dart';
import 'package:squadbox/models/enum_tools.dart';

class Level001003 {
  final GameController gameController;

  Level001003({required this.gameController}) {
    this.gameController.inimigos = 20;
    this.gameController.gameLevel.percentual = 40;
     
    this.gameController.tools.items.add(ToolsItem(
        gameController: this.gameController,
        tooltype: ToolsType.add_energyblock,
        name: 'Tools',
        quantidade: 20));

    this.gameController.tools.items.add( ToolsItem(
            gameController: this.gameController,
            tooltype: ToolsType.status_cutblock,
            name: 'Tools',
            quantidade: 100000000 ) );
    
  }
}
