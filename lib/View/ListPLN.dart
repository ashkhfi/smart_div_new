import 'package:flutter/material.dart';

import '../Partials/Card/ItemCard.dart';


class ListPLN extends StatefulWidget {
  const ListPLN({ super.key });

  @override
  _ListPLNState createState() => _ListPLNState();
}

class _ListPLNState extends State<ListPLN> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ItemCard(context, title: "PLTB", condition: true, data: "Mbuh"),
      )
    );
  }
}