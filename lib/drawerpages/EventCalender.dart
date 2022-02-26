
import 'package:flutter/material.dart';
import 'package:istanbulsokaksanatlari/widget/appBars/appBarBack.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventCalender extends StatelessWidget {
  const EventCalender({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = "Etkinlik Takvimi";
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Builder(
                  builder: (context) {
                    return SfCalendar(
                      todayTextStyle: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 30),
                      appointmentTextStyle: const TextStyle(fontWeight: FontWeight.bold),
                      blackoutDatesTextStyle:const TextStyle(fontWeight: FontWeight.bold),
                      view: CalendarView.month,
                      cellBorderColor: Colors.black,
                      headerStyle: CalendarHeaderStyle(
                        backgroundColor: Colors.limeAccent.withOpacity(0.5),
                        textAlign: TextAlign.center,
                        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                      ),
                      viewHeaderStyle: ViewHeaderStyle(
                        backgroundColor: Colors.white.withOpacity(0.7),
                        dayTextStyle: TextStyle(fontSize: 14, color: Colors.black, ),
                        dateTextStyle: TextStyle(fontSize: 14, color: Colors.black, ),
                      ),
                      todayHighlightColor: Colors.black,
                      backgroundColor: Colors.white.withOpacity(0.5),
                      firstDayOfWeek: 1,
                      selectionDecoration: const BoxDecoration(
                        backgroundBlendMode: BlendMode.modulate,
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        shape: BoxShape.rectangle,
                      ),
                      onTap: (CalendarTapDetails details){
                        showModalBottomSheet(
                          backgroundColor: Colors.white,

                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16),
                                )
                            ),
                            context: context,
                            isScrollControlled: true,
                            builder: (context){
                              return gunDetaySheet();
                            }

                        );
                      },


                    );
                  }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget gunDetaySheet(){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 500,
        child: SfCalendar(
          view: CalendarView.day,
          backgroundColor: Colors.white,
          todayHighlightColor: Colors.blueGrey,
          cellBorderColor: Colors.grey,
        ),
      ),
    );
  }
}

