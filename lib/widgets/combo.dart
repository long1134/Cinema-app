import 'package:cinema_app/providers/combo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ComboWidget extends StatefulWidget {
  @override
  _ComboWidgetState createState() => _ComboWidgetState();
}

class _ComboWidgetState extends State<ComboWidget> {
  @override
  Widget build(BuildContext context) {
    List<ComboItem> combo = Provider.of<Combo>(context).items;
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: combo.length,
        itemBuilder: (ctx, index) {
          return Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width - 30,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Image.network(
                          "https://pbs.twimg.com/profile_images/424503436776706048/r6EsqH3n_400x400.png",
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes
                                    : null,
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          width: 10,
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              combo[index].name,
                              textAlign: TextAlign.left,
                              softWrap: true,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 50,
                              child: Text(
                                combo[index].detail,
                                textAlign: TextAlign.left,
                                softWrap: true,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
                              Provider.of<Combo>(context)
                                  .removeCombo(combo[index].name);
                            },
                            icon: Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.fill,
                            child: Container(
                              height: 25,
                              width: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.white60),
                              ),
                              child: Text(
                                combo[index].count.toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Provider.of<Combo>(context)
                                  .addCombo(combo[index].name);
                            },
                            icon: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
