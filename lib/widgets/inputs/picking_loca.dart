import 'package:flutter/material.dart';
import 'package:week3/model/ride/locations.dart';
import 'package:week3/screens/picking_location/picking_location_screen.dart';
import 'package:week3/theme/theme.dart';
import 'package:week3/utils/animations_util.dart';

class LocationPickerField extends StatelessWidget {
  // this field can be create with or without initialize value
  final Location? initLocation;
  final String hint;// hint to put in the field when there is no value
  final Function(Location) onSelectLocation;
  const LocationPickerField({super.key, required this.initLocation,required this.hint, required this.onSelectLocation, Location? location});

  //check if it has initialize value to assign else, give user a hint
  String get selectedLocation => initLocation != null ? "${initLocation!.name}, ${initLocation!.country.name}" : hint;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.circle_outlined, size: 16, color: BlaColors.neutral,),
      title: Text(selectedLocation,style: BlaTextStyles.button.copyWith(color:BlaColors.neutral, ),),
      onTap:() {
        // open a full screen dialog of location picker
       Navigator.of(context).push(AnimationUtils.createBottomToTopRoute(
          LocationPickerScreen(
            onSelectLocation: onSelectLocation,
            )
          )
        );
      },
    );
  }
}