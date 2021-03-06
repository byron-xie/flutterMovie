import 'package:flutter/material.dart';

import '../component/item_game_container.dart';
import '../model/game.dart';

class HorizontalGameController extends StatelessWidget {
  HorizontalGameController(this.gameItems);
  final List<Game> gameItems;

  @override
  Widget build(BuildContext context) {
    return new SizedBox.fromSize(
      size: const Size.fromHeight(240.0),
      child: new ListView.builder(
          itemCount: gameItems.length,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: 12.0, top: 4.0),
          itemBuilder: itemBuild),
    );
  }

  Widget itemBuild(BuildContext context, int index) {
      return GameContainerItem(context, gameItems[index]);
    }
  }
