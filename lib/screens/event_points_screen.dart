import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:istanbulsokaksanatlari/screens/location_sheet_screen.dart';

class EventPointsScreen extends StatefulWidget {
  const EventPointsScreen({Key? key}) : super(key: key);

  @override
  _EventPointsScreenState createState() => _EventPointsScreenState();
}

class _EventPointsScreenState extends State<EventPointsScreen> {


  Completer<GoogleMapController> haritaKontrol = Completer();


  var baslangicKonum = const CameraPosition(target: LatLng(40.9903, 29.0205), zoom: 15);

  final List<Marker> _markers = <Marker>[];
  late BitmapDescriptor mapMarker;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCustomMaker();
  }
  void setCustomMaker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(const ImageConfiguration(), "images1/musicmarker.png");
  }

  void _onMapCreated(GoogleMapController controller){
    setState(() {

      _markers.add( Marker(
        markerId:const MarkerId("2penas7ZF7gdMx8si5TQ"),
        position: const LatLng(40.988947, 29.026791),
        infoWindow: const InfoWindow(title: "Caferağa Sahnesi" , snippet: " Osmanağa,, Sakız Sokak, No:18"),
        onTap: (){
          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                )
            ),
              context: context,
              builder: (builder){
            return LocationSheetScreen(location_uid: "2penas7ZF7gdMx8si5TQ");

          });
        },
      ),

      );
      _markers.add( Marker(
        markerId:const MarkerId("98oI5BRTkcTynD9gtMwd"),
        position: const LatLng(40.984561, 29.022941),
        infoWindow: const InfoWindow(title: "Duvar" , snippet: "Cafarağa, Rıza Paşa Sokak:18"),
        onTap: (){
          showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  )
              ),
              context: context,
              builder: (builder){
                return LocationSheetScreen(location_uid: "98oI5BRTkcTynD9gtMwd");

              });
        }
      ),

      );

      _markers.add( Marker(
        markerId:const MarkerId("kFdA0hQdaGkmCWESXzvv"),
        position: const LatLng(40.987537, 29.028504),
        infoWindow: const InfoWindow(title: "Bahariye Sahnesi" , snippet: "Caferağa, General Asım Gündüz Cd. No: 64"),
          onTap: (){
            showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    )
                ),
                context: context,
                builder: (builder){
                  return LocationSheetScreen(location_uid: "kFdA0hQdaGkmCWESXzvv");

                });
          }

      ),

      );

      _markers.add( Marker(
          markerId:const MarkerId("xIxPddmvrn5NBK61ISJ2"),
          position: const LatLng(40.981857 , 29.023093),
          infoWindow: const InfoWindow(title: "Moda Yolu" , snippet: "Caferağa, Moda Cd. No: 166"),
          onTap: (){
            showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    )
                ),
                context: context,
                builder: (builder){
                  return LocationSheetScreen(location_uid: "xIxPddmvrn5NBK61ISJ2");

                });
    }

      ),

      );

    });
  }


  Future<void> konum1() async {
    GoogleMapController controller = await haritaKontrol.future;

    var gidilecekKonum = const CameraPosition(target: LatLng(40.979872, 29.022822) , zoom: 18);

    controller.animateCamera(CameraUpdate.newCameraPosition(gidilecekKonum));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: (MediaQuery.of(context).size.height-50),
                  width: MediaQuery.of(context).size.width,
                  child: GoogleMap(
                    myLocationButtonEnabled: true,
                      zoomControlsEnabled: true,
                    markers: Set<Marker>.of(_markers),
                    mapType: MapType.satellite,
                    initialCameraPosition: baslangicKonum,
                    onMapCreated: _onMapCreated,
                  ),
                )

              ],
            ),
          ),
        ),
        SizedBox(
          height: 100,
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true,
            toolbarHeight: 80,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
                  color: Colors.transparent
              ),
            ),

            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Image.asset("images1/StreetArts2.png"),
              )
            ],
          ),
        ),


      ],
    );
  }


}
