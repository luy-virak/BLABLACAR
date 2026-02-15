import 'package:flutter/material.dart';
import '../../../widgets/inputs/forms.dart'; 
import '../../../../model/ride/locations.dart';
import '../../../../model/ride_pref/ride_pref.dart';
import '../../../widgets/inputs/Pick_location.dart';

import '../../../widgets/inputs/seat_picker_screen.dart';

class RidePrefForm extends StatefulWidget {
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  // Declare departure and arrival location variables
  Location? departure;
  Location? arrival;

  late DateTime departureDate;
  late int seat;

  @override
  void initState() {
    super.initState();
    departureDate = DateTime.now(); // Default to current date
    seat = 1; // Default to 1 seat

    // Initialize with the provided RidePref (if any)
    if (widget.initRidePref != null) {
      departure = widget.initRidePref!.departure;
      arrival = widget.initRidePref!.arrival;
    }
  }

  // Swap locations function
  void _swapLocations() {
    setState(() {
      final temp = departure;
      departure = arrival;
      arrival = temp;
    });
  }

  Future<void> _pickDepartureDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: departureDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != departureDate) {
      setState(() {
        departureDate = picked;
      });
    }
  }

  // Open the Seat Picker Screen
  void _openSeatPicker() async {
    final int? selectedSeats = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SeatPickerScreen(initialSeats: seat), // Pass current seat count
      ),
    );

    if (selectedSeats != null) {
      setState(() {
        seat = selectedSeats; // Update the seat count when the user confirms
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Swap locations button
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: _swapLocations,
                child: Icon(
                  Icons.swap_vert,
                  color: Colors.blue,
                  size: 30, // Adjust icon size
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SubBla(
            icon: Icons.place,
            label: departure?.name ?? "Leaving from",
            onTap: () async {
              final selected = await showLocationPicker(
                context,
                title: "Leaving from",
              );

              if (selected != null) {
                setState(() {
                  departure = selected.copyWith();
                });
              }
            },
          ),

          const SizedBox(height: 12, child: Divider()),

          SubBla(
            icon: Icons.place,
            label: arrival?.name ?? "Going to",
            onTap: () async {
              final selected = await showLocationPicker(
                context,
                title: "Going to",
              );

              if (selected != null) {
                setState(() {
                  arrival = selected.copyWith();
                });
              }
            },
          ),
          const SizedBox(height: 12, child: Divider()),

          // Departure date display
          SubBla(
            icon: Icons.calendar_month,
            label:
                "${departureDate.day}/${departureDate.month}/${departureDate.year}",
            onTap: () => _pickDepartureDate(context),
          ),
          const SizedBox(height: 12, child: Divider()),

          // Seat number display with SeatCounter widget
          GestureDetector(
            onTap: _openSeatPicker, // Open seat picker screen
            child: SubBla(
              icon: Icons.person,
              label: "$seat",
            ),
          ),
          const SizedBox(height: 12, child: Divider()),
        ],
      ),
    );
  }
}
