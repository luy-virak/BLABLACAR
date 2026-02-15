import 'package:flutter/material.dart';
import '../../../data/dummy_data.dart';
import '../../../model/ride/locations.dart';
import '../../theme/theme.dart';

Future<Location?> showLocationPicker(
  BuildContext context, {
  String title = 'Select Location',
}) async {
  return Navigator.push<Location>(
    context,
    MaterialPageRoute(builder: (context) => _PickerScreen(title: title)),
  );
}

class _PickerScreen extends StatefulWidget {
  final String title;

  const _PickerScreen({required this.title});

  @override
  State<_PickerScreen> createState() => _PickerScreenState();
}

class _PickerScreenState extends State<_PickerScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Location> _locations = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterLocations);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterLocations() {
    final query = _searchController.text.toLowerCase().trim();
    setState(() {
      if (query.isEmpty) {
        _locations = [];
      } else {
        _locations = fakeLocations.where((location) {
          final cityName = location.name.toLowerCase();
          final countryName = location.country.name.toLowerCase();
          return cityName.contains(query) || countryName.contains(query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: BlaSpacings.s),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: BlaTextStyles.body.copyWith(
                color: BlaColors.neutralLight,
              ),
              prefixIcon: IconButton(
                icon: Icon(Icons.arrow_back, color: BlaColors.iconNormal),
                onPressed: () => Navigator.pop(context),
              ),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.close, color: BlaColors.iconNormal),
                      onPressed: () {
                        _searchController.clear();
                      },
                    )
                  : null,
              filled: true,
              fillColor: BlaColors.backgroundAccent,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: BlaSpacings.m,
                vertical: BlaSpacings.s,
              ),
            ),
          ),
        ),
      ),
      body: ListView.separated(
        itemCount: _locations.length,
        separatorBuilder: (context, index) => Divider(
          height: 1,
          color: BlaColors.greyLight,
          indent: BlaSpacings.m,
        ),
        itemBuilder: (context, index) {
          final location = _locations[index];
          return ListTile(
            title: Text(
              location.name,
              style: BlaTextStyles.body.copyWith(color: BlaColors.neutralDark),
            ),
            subtitle: Text(
              location.country.name,
              style: BlaTextStyles.label.copyWith(
                color: BlaColors.neutralLight,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: BlaColors.iconLight,
            ),
            onTap: () => Navigator.pop(context, location),
          );
        },
      ),
    );
  }
}
