import 'package:flutter/material.dart';

class HomeP extends StatefulWidget {
  const HomeP({super.key});

  @override
  State<HomeP> createState() => _HomePState();
}

class _HomePState extends State<HomeP> {
  var tiles = List.filled(9, 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          SizedBox(
            height: 380,
            child: AspectRatio(
              aspectRatio: 1,
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 3,
                children: [
                  for (var i = 0; i < 9; i++)
                    InkWell(
                      onTap: () {
                        setState(() {
                          tiles[i] = 1;
                          runAi();
                        });
                      },
                      child: Center(
                        child:
                            // Text(
                            //     // "X",
                            //     tiles[i] == 0
                            //         ? " "
                            //         : tiles[i] == 1
                            //             ? "X"
                            //             : "O"),
                            tiles[i] == 0
                                ? Container(
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black)),
                                  )
                                : tiles[i] == 1
                                    ?
                                    // Text('X')
                                    Container(
                                        width: 150,
                                        height: 150,
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            border: Border.all(
                                                color: Colors.black)),
                                        child: const Center(
                                          child: Text(
                                            "X",
                                            style: TextStyle(
                                                fontSize: 80,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      )
                                    :
                                    //const Text("O"),
                                    Container(
                                        width: 150,
                                        height: 150,
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            border: Border.all(
                                                color: Colors.black)),
                                        child: const Center(
                                          child: Text(
                                            "O",
                                            style: TextStyle(
                                                fontSize: 80,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                      ),
                    )
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                isWinning(1, tiles)
                    ? "you won!"
                    : isWinning(2, tiles)
                        ? "you lost"
                        : "Your Move",
              ),
              OutlinedButton(
                  onPressed: () {
                    setState(() {
                      tiles = List.filled(9, 0);
                    });
                  },
                  child: const Text("Restart"))
            ],
          ),
        ]),
      ),
    );
  }

  void runAi() async {
    await Future.delayed(const Duration(microseconds: 200));

    int? winning;
    int? blocking;
    int? normal;

    for (var i = 0; i < 9; i++) {
      var val = tiles[i];

      if (val > 0) {
        continue;
      }
      var future = [...tiles]..[i] = 2;
      print(future);
      if (isWinning(2, future)) {
        winning = i;
      }
      future[i] = 1;
      if (isWinning(1, future)) {
        blocking = i;
      }
      normal = i;
    }
    var move = winning ?? blocking ?? normal;
    if (move != null) {
      setState(() {
        tiles[move] = 2;
      });
    }
  }

  bool isWinning(int who, List<int> tiles) {
    return
        //
        (tiles[0] == who && tiles[1] == who && tiles[2] == who) ||
            (tiles[3] == who && tiles[4] == who && tiles[5] == who) ||
            (tiles[6] == who && tiles[7] == who && tiles[8] == who) ||
            (tiles[0] == who && tiles[4] == who && tiles[8] == who) ||
            (tiles[2] == who && tiles[4] == who && tiles[6] == who) ||
            (tiles[0] == who && tiles[3] == who && tiles[6] == who) ||
            (tiles[1] == who && tiles[4] == who && tiles[7] == who) ||
            (tiles[2] == who && tiles[5] == who && tiles[8] == who);
  }
}

