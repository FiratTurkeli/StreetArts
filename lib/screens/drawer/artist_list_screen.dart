import 'package:flutter/material.dart';
import 'package:istanbulsokaksanatlari/constant/text_style.dart';
import 'package:istanbulsokaksanatlari/constant/ui_helper.dart';
import 'package:istanbulsokaksanatlari/widget/appBars/app_bar_back.dart';
import 'package:istanbulsokaksanatlari/widget/background.dart';
import 'package:istanbulsokaksanatlari/widget/cards/artist_card_view.dart';

class ArtistListScreen extends StatefulWidget {

  final String category_name;


  ArtistListScreen({required this.category_name});

  @override
  _ArtistListScreenState createState() => _ArtistListScreenState();
}

class _ArtistListScreenState extends State<ArtistListScreen> with TickerProviderStateMixin{



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: background(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBarBack(),
        body: SingleChildScrollView(
          primary: true,
          child: buildArtistList(),
        ),
      ),
    );
  }

  Widget buildArtistList() {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Flexible(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.category_name, style: headerStyle.copyWith(color: Colors.white),),
                  UIHelper.verticalSpace(16),
                  SizedBox(
                    width: double.infinity,
                    child: ArtistCardView(category_name: widget.category_name,)
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }


}
