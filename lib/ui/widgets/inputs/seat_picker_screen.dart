import 'package:flutter/material.dart';

class SeatPickerScreen extends StatefulWidget {
  final int initialSeats; // Pass the initial number of seats selected
  const SeatPickerScreen({Key? key, required this.initialSeats}) : super(key: key);

  @override
  _SeatPickerScreenState createState() => _SeatPickerScreenState();
}

class _SeatPickerScreenState extends State<SeatPickerScreen> {
  late int seatCount;

  @override
  void initState() {
    super.initState();
    seatCount = widget.initialSeats; // Initialize with the passed value
  }

  // Function to increase the seat count
  void _increaseSeat() {
    setState(() {
      seatCount++;
    });
  }

  // Function to decrease the seat count
  void _decreaseSeat() {
    if (seatCount > 1) {
      setState(() {
        seatCount--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Seats"),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              // When the user confirms the selection, pop and pass the value back
              Navigator.pop(context, seatCount);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Number of seats to book",
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: _decreaseSeat, // Decrease seat count
                ),
                Text(
                  "$seatCount",
                  style: TextStyle(fontSize: 30),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _increaseSeat, // Increase seat count
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
