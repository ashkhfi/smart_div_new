import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Partials/Card/ItemCard.dart';
import '../Provider/user_provider.dart';


class ListEnergy extends StatefulWidget {
  const ListEnergy({ super.key });

  @override
  _ListEnergyState createState() => _ListEnergyState();
}

class _ListEnergyState extends State<ListEnergy> {

 
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ItemCard(context, title: "PLTS", condition: false, data: "Mbuh"),
      )
    );
  }
}