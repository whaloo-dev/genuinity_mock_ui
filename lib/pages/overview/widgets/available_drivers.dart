import 'package:dash_santos/constants/style.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class AvailableDrivers extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const AvailableDrivers();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.only(top: 10),
        margin: const EdgeInsets.only(bottom: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: kSpacing),
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                "Available Drivers",
                style: TextStyle(
                  color: kLightGreyColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DataTable2(
              columnSpacing: 12,
              horizontalMargin: 12,
              minWidth: 200,
              smRatio: 0.75,
              lmRatio: 1.5,
              columns: const [
                DataColumn2(size: ColumnSize.S, label: Text('Name')),
                DataColumn(label: Text('Location')),
                DataColumn(label: Text('Rating')),
                DataColumn(label: Text('Action')),
              ],
              rows: List<DataRow>.generate(
                7,
                (index) => DataRow(
                  cells: [
                    DataCell(Text("Driver$index")),
                    const DataCell(Text("Guelma")),
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star,
                              color: Colors.deepOrange, size: 18),
                          SizedBox(width: kSpacing),
                          Text("4.$index")
                        ],
                      ),
                    ),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          border: Border.all(color: kActiveColor, width: .5),
                          color: kLightColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "Assign Delivery",
                          style: TextStyle(
                            color: kActiveColor.withOpacity(.7),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
