import 'package:flutter/material.dart';
import 'package:week3/screens/picking_location/picking_location_screen.dart';
import 'package:week3/screens/search/search_screen.dart';
import 'package:week3/theme/theme.dart';
import 'package:week3/utils/animations_util.dart';
import 'package:week3/widgets/actions/action_button.dart';
import 'package:week3/widgets/display/bla_divider.dart';
import 'package:week3/widgets/inputs/date_picker.dart';
import 'package:week3/widgets/inputs/picking_loca.dart';
import 'package:week3/widgets/inputs/seats_num.dart';
import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  DateTime departureDate = DateTime.now();
  Location? arrival;
  int requestedSeats = 1;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    // TODO
    bool isInitRidePref = widget.initRidePref != null;
    if (isInitRidePref) {
      departure = widget.initRidePref!.departure;
      arrival = widget.initRidePref!.arrival;
      requestedSeats = widget.initRidePref!.requestedSeats;
      departureDate = widget.initRidePref!.departureDate;
    }
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------

// Swap location funtion
  void swapLocations() {
    final tempDeparture = departure;
    final tempArrival = arrival;
    setState(() {
      departure = tempArrival;
      arrival = tempDeparture;
    });
  }

  //Function to change each value

  void onSelectArrival(Location location) {
    setState(() {
      arrival = location;
    });
  }

  void onSelectDeparture(Location location) {
    setState(() {
      departure = location;
    });
  }

  void onSelectDepartureDate(DateTime dateTime) {
    setState(() {
      departureDate = dateTime;
      print("function trigger");
    });
  }

  void onSelectSeats(int newSeats) {
    setState(() {
      requestedSeats = newSeats;
    });
  }
  // Search button and validor for the form

  void onSearch() async {
    //validate depature, if null show location picker;
    if (departure == null) {
      //show the full screen dialog of select location
      Navigator.of(context)
          .push(AnimationUtils.createBottomToTopRoute(LocationPickerScreen(
        onSelectLocation: onSelectDeparture,
      )));
      //validate arrival, if null show location picker;
    } else if (arrival == null) {
      //show the full screen dialog of select location
      Navigator.of(context)
          .push(AnimationUtils.createBottomToTopRoute(LocationPickerScreen(
        onSelectLocation: onSelectArrival,
      )));
    } else {
      RidePref ridePref = RidePref(
          departure: departure!,
          departureDate: departureDate,
          arrival: arrival!,
          requestedSeats: requestedSeats);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SearchRideScreen(
                    ridePref: ridePref,
                  )
                )
              );
    }
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(onPressed: swapLocations, icon: Icon(Icons.swap_vert,color: BlaColors.primary,))
            ],
          ),
          // 1 - Leaving from Listtile
          LocationPickerField(
            hint: "Leaving from",
            initLocation: departure,
            onSelectLocation: onSelectDeparture,
          ),
          BlaDivider(),
          // 2 - Going to Listtile
          LocationPickerField(
            hint: "Going to",
            initLocation: arrival,
            onSelectLocation: onSelectArrival,
          ),
          BlaDivider(),
          // 3 - Select date Listtile, default today
          DatePickerField(
            initDateTime: departureDate,
            onSelectDate: onSelectDepartureDate,
          ),
          BlaDivider(),
          // 4 - Select seats Listitle, default 1
          SeatPickerField(onSelectSeats: onSelectSeats, initSeats: requestedSeats,),
          const SizedBox(
            height: BlaSpacings.s,
          ),
          BlaButton(
              type: ButtonType.primary,
              title: "Search",
              onButtonClick: onSearch)
        ]);
  }
}