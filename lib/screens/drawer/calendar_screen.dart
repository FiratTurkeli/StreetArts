
import 'package:flutter/material.dart';
import 'package:istanbulsokaksanatlari/constant/text_style.dart';
import 'package:istanbulsokaksanatlari/widget/appBars/app_bar_back.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../constant/color.dart';
import '../../widget/background.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = "Etkinlik Takvimi";
    return Container(
      decoration: background(),
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
                      todayTextStyle: todayCalendarTextStyle,
                      appointmentTextStyle: appointmentCalendarTextStyle,
                      blackoutDatesTextStyle: blackoutDatesTextStyle,
                      view: CalendarView.month,
                      cellBorderColor: black,
                      headerStyle: CalendarHeaderStyle(
                        backgroundColor: backgroundColorCalendar,
                        textAlign: TextAlign.center,
                        textStyle: monthStyle,
                      ),
                      viewHeaderStyle: ViewHeaderStyle(
                        backgroundColor: calendarHeaderBackgroundColor,
                        dayTextStyle: subtitleStyle,
                        dateTextStyle: subtitleStyle,
                      ),
                      todayHighlightColor: black,
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
                          backgroundColor: white,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16),
                                )
                            ),
                            context: context,
                            isScrollControlled: true,
                            builder: (context){
                              return dayDetailsSheet();
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

  Widget dayDetailsSheet(){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 500,
        child: SfCalendar(
          view: CalendarView.day,
          backgroundColor: white,
          todayHighlightColor: Colors.blueGrey,
          cellBorderColor: Colors.grey,
        ),
      ),
    );
  }
}

