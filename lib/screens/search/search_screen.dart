import 'package:flutter/material.dart';
import 'package:week3/screens/search/widgets/search_ride_card.dart';
import 'package:week3/theme/theme.dart';
import '../../model/ride/ride.dart';
import '../../model/ride_pref/ride_pref.dart';
import '../../service/rides_service.dart';
import 'widgets/search_tile.dart';

class SearchRideScreen extends StatefulWidget {
  final RidePref ridePref;
  const SearchRideScreen({super.key,required this.ridePref});

  @override
  State<SearchRideScreen> createState() => _SearchRideScreenState();
}

class _SearchRideScreenState extends State<SearchRideScreen> {
  
  late List<Ride> matchRide;
  late bool isNotFound;
  ///
  ///Prepare render data
  ///
  
 @override
void initState() {
  super.initState();
  ///
  /// Compare and find the match ride
  /// 
  matchRide = RidesService.availableRides
      .where((ride) =>
          ride.departureLocation.name == widget.ridePref.departure.name &&
          ride.arrivalLocation.name == widget.ridePref.arrival.name &&
          ride.departureDate.day == widget.ridePref.departureDate.day &&
          ride.departureDate.month == widget.ridePref.departureDate.month &&
          ride.departureDate.year == widget.ridePref.departureDate.year
          ) // Ensure full date match
      .toList();  
  if(matchRide.length == 0){
    isNotFound = true;
  }
}


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            RidePrefTile(ridePref: widget.ridePref),
            SizedBox(height: BlaSpacings.xl,),
            /// if match, then show the list of matchRide
            if(!isNotFound)...[
              Expanded(
                child: ListView.builder(
                  itemCount: matchRide.length,
                  itemBuilder: (context, index) => RideCard(ride: matchRide[index]),
                ),
              )],
            // else its show not found
            if(isNotFound)...[
              Center(
                child: Text(
                  "No Ride are available", style: BlaTextStyles.body,
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}