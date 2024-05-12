

import 'package:beme_english/home/app_bottom_bar.dart';
import 'package:beme_english/home/helper/file_storage.dart';
import 'package:beme_english/home/view_model/import_csv_page_viewmodel.dart';

import 'package:flutter/material.dart';
import 'package:gtd_utils/base/page/base_stateless_page.dart';
import 'package:gtd_utils/helpers/extension/date_time_extension.dart';
import 'package:gtd_utils/utils/popup/gtd_popup_message.dart';


//!Table
class ImportCSVPage extends BaseStatelessPage<ImportCSVPageViewModel> {
  static const String route = '/importCSVPage';

  const ImportCSVPage({super.key, required super.viewModel});

  @override
  List<Widget> buildTrailingActions(BuildContext pageContext) {
    return [
      IconButton(
          onPressed: () async {
            GtdPopupMessage(pageContext).showError(
              error: "Do you want Export?",
              onConfirm: (value) async {
                final fileTuple = viewModel.generateCSVString(viewModel.generateDataTable());
                FileStorage.writeCounter(fileTuple.fileByte, fileTuple.fileName).then((value) {
                  ScaffoldMessenger.of(pageContext).showSnackBar(SnackBar(content: Text('File saved: ${value.path}')));
                });
              },
            );
          },
          icon: const Icon(Icons.import_export, size: 36, color: Colors.green))
    ];
  }

  @override
  Widget buildBody(BuildContext pageContext) {
    return Column(
      children: [
        StatefulBuilder(builder: (context, setState) {
          return InkWell(
            onTap: () {
              showDatePicker(
                context: pageContext,
                firstDate: DateTime.now().subtract(const Duration(days: 36500)),
                lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
                initialDate: viewModel.dateExportTime,
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: const ColorScheme.light(
                        primary: appOrangeDarkColor, // header background color
                        onPrimary: Colors.black, // header text color
                        onSurface: appBlueDeepColor, // body text color
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.blueAccent, textStyle: const TextStyle(fontSize: 20)),
                      ),
                    ),
                    child: child!,
                  );
                },
              ).then((value) {
                if (value != null) {
                  setState(
                    () {
                      viewModel.setExportDate(value);
                    },
                  );
                }
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const SizedBox(
                    height: 48,
                    width: 48,
                    child: Card(
                      shadowColor: Colors.black,
                      child: Icon(Icons.calendar_month, color: appBlueDeepColor),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(dateFormat.format(viewModel.dateExportTime ?? DateTime.now()),
                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: appBlueDeepColor))
                ],
              ),
            ),
          );
        }),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ListenableBuilder(
                listenable: viewModel,
                builder: (context, child) {
                  return viewModel.generateDataTable();
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  // List<DataColumn> _generateColumns() {
  //   // var rawData = viewModel.courses.map((e) => e.toDataSheet()).first;
  //   var rawData = viewModel.generateColumn;
  //   var columns = rawData.keys
  //       .map(
  //         (e) => DataColumn(label: Text(e)),
  //       )
  //       .toList();
  //   return columns;
  // }

  // List<DataRow> _generateRows() {
  //   // var rawData = viewModel.courses.map((e) => e.toDataSheet());
  //   var rawData = viewModel.generateDataFeedbacks();
  //   var rows = rawData
  //       .map((e) => e.values.map((rawValue) => DataCell(Text(rawValue.toString()))).toList())
  //       .map((e) => DataRow(cells: e))
  //       .toList();
  //   return rows;
  // }
}
