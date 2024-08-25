import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// futures that needs to be added :
// 1- create a dialoge that you can add the name of the two players.
// 2- have a button to replay another time and ask is it your first time.
// 3- try to make the application to have night mode and light mode
// 4- ...
class _HomePageState extends State<HomePage> {
  var priBackground = Colors.grey.shade900;
  var secBackground = Colors.grey.shade600;
  var textColor = Colors.white;
  var mytextst = TextStyle(color: Colors.white, fontSize: 30);
  bool oturn = false; // the first player will be X
  List<String> xoState = ['', '', '', '', '', '', '', '', ''];
  int OScore = 0;
  int XScore = 0;
  int boxesFilled = 0;

  static var blackFont = GoogleFonts.pressStart2p(
    textStyle: TextStyle(
      color: Colors.black, letterSpacing: 3));
  static var whiteFont = GoogleFonts.pressStart2p(
    textStyle: TextStyle(
      color: Colors.white, letterSpacing: 3, fontSize: 20));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: priBackground,
      body: Column(
        children: [
          Expanded(
              child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Player X',
                        style: whiteFont,
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      Text(
                        XScore.toString(),
                        style: whiteFont,
                      )
                    ],
                  ))),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                itemCount: 9,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: secBackground)),
                      child: Center(
                        child: Text(
                          xoState[index],
                          style: TextStyle(color: textColor, fontSize: 40),
                        ),
                      ),
                    ),
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
              ),
            ),
          ),
          Expanded(child: Container(
            child:
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: RotatedBox(
                quarterTurns: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Player O',
                      style: whiteFont,
                    ),
                    const Padding(padding: EdgeInsets.all(5)),
                    Text(
                      OScore.toString(),
                      style: whiteFont,
                    )
                  ],
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (oturn && xoState[index] == '') {
        xoState[index] = 'O';
        boxesFilled += 1;
        _winner();
        oturn = !oturn;
      } else if (!oturn && xoState[index] == '') {
        xoState[index] = 'X';
        boxesFilled += 1;
        _winner();
        oturn = !oturn;
      }
    });
  }

  void _winner() {
    if (xoState[0] == xoState[1] &&
        xoState[0] == xoState[2] &&
        xoState[0] != '') {
      _showWinnerDialog(xoState[0]);
    }
    if (xoState[3] == xoState[4] &&
        xoState[3] == xoState[5] &&
        xoState[3] != '') {
      _showWinnerDialog(xoState[3]);
    }
    if (xoState[6] == xoState[7] &&
        xoState[6] == xoState[8] &&
        xoState[6] != '') {
      _showWinnerDialog(xoState[6]);
    }
    if (xoState[0] == xoState[3] &&
        xoState[0] == xoState[6] &&
        xoState[0] != '') {
      _showWinnerDialog(xoState[0]);
    }
    if (xoState[1] == xoState[4] &&
        xoState[1] == xoState[7] &&
        xoState[1] != '') {
      _showWinnerDialog(xoState[1]);
    }
    if (xoState[2] == xoState[5] &&
        xoState[2] == xoState[8] &&
        xoState[2] != '') {
      _showWinnerDialog(xoState[2]);
    }
    if (xoState[0] == xoState[4] &&
        xoState[0] == xoState[8] &&
        xoState[0] != '') {
      _showWinnerDialog(xoState[0]);
    }
    if (xoState[2] == xoState[4] &&
        xoState[2] == xoState[6] &&
        xoState[2] != '') {
      _showWinnerDialog(xoState[2]);
    }
    else if ( boxesFilled >= 9 ) {
      _showDrawDialog();
    }
  }
  void _showDrawDialog(){
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Draw !!!'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    _clearBoard();
                    Navigator.of(context).pop();
                  },
                  child: Text('Play Again!'))
            ],
          );
        });
    !!oturn;
  }

  void _showWinnerDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('The winner is: ' + winner),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    _clearBoard();
                    Navigator.of(context).pop();
                  },
                  child: Text('Play Again!'))
            ],
          );
        });
    if (oturn) {
      OScore += 1;
    } else if (!oturn) {
      XScore += 1;
    }
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        xoState[i] = '';
      }
      boxesFilled = 0 ;
    });
  }
}
