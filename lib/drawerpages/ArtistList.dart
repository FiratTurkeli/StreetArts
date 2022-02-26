import 'package:flutter/material.dart';
import 'package:istanbulsokaksanatlari/constant/text_style.dart';
import 'package:istanbulsokaksanatlari/models/ui_helper.dart';
import 'package:istanbulsokaksanatlari/widget/appBars/appBarBack.dart';
import 'package:istanbulsokaksanatlari/widget/artistCardView.dart';

class ArtistList extends StatefulWidget {

  final String category_name;


  ArtistList({required this.category_name});

  @override
  _ArtistListState createState() => _ArtistListState();
}

class _ArtistListState extends State<ArtistList> with TickerProviderStateMixin{








  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images1/duvar3.webp"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
          ),),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBarBack(),
        body: SingleChildScrollView(
          primary: true,
          child: Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(
                    child: buildArtistList())]),
        ),
      ),
    );
  }

  Widget buildArtistList() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.category_name, style: headerStyle.copyWith(color: Colors.white),),
            UIHelper.verticalSpace(16),
            SizedBox(
              width: double.infinity,
              child: artistCardView(category_name: widget.category_name,)
            )
          ],
        ),
      ),
    );
  }


}
