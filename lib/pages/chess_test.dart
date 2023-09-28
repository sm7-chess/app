import 'dart:math';

import 'package:bishop/bishop.dart' as bishop;
import 'package:d2chess/universal/theme.dart';
import 'package:d2chess/widgets/theme_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:square_bishop/square_bishop.dart';
import 'package:squares/squares.dart';

class ChessTestPage extends StatefulWidget {
  const ChessTestPage({Key? key}) : super(key: key);
  @override
  State<ChessTestPage> createState() => _ChessTestPageState();
}

class _ChessTestPageState extends State<ChessTestPage> {
  late bishop.Game game;
  late SquaresState state;
  int player = Squares.white;
  bool aiThinking = false;
  bool flipBoard = false;

  @override
  void initState() {
    _resetGame(false);
    super.initState();
  }

  void _resetGame([bool ss = true]) {
    game = bishop.Game(variant: bishop.Variant.standard());
    state = game.squaresState(player);
    if (ss) setState(() {});
  }

  void _flipBoard() => setState(() => flipBoard = !flipBoard);

  void _onMove(Move move) async {
    bool result = game.makeSquaresMove(move);

    if (result) {
      setState(() => state = game.squaresState(player));
    }
    if (state.state == PlayState.theirTurn && !aiThinking) {
      setState(() => aiThinking = true);
      await Future.delayed(
          Duration(milliseconds: Random().nextInt(4750) + 250));
      game.makeRandomMove();
      setState(() {
        aiThinking = false;
        state = game.squaresState(player);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: BoardController(
              state: flipBoard ? state.board.flipped() : state.board,
              playState: state.state,
              pieceSet: PieceSet.merida(),
              theme: Themes.materialToBoard(
                Theme.of(context),
                PlatformTheme.of(context)?.isDark == true
                    ? Brightness.dark
                    : Brightness.light,
              ),
              moves: state.moves,
              onMove: _onMove,
              onPremove: _onMove,
              markerTheme: MarkerTheme(
                empty: MarkerTheme.dot,
                piece: MarkerTheme.corners(),
              ),
              promotionBehaviour: PromotionBehaviour.alwaysSelect,
            ),
          ),
          const SizedBox(height: 32),
          PlatformTextButton(
            onPressed: _resetGame,
            child: const Text('New Game'),
          ),
          PlatformTextButton(
            onPressed: _flipBoard,
            child: const Text('Flip Board'),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            child: ThemeHuePicker(),
          )
        ],
      ),
    );
  }
}
