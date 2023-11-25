import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:uangku_app/pages/hutang.dart';
import 'package:uangku_app/pages/transaksi.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;
  DateTime? _datePicker;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 1, length: 4, vsync: this)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Uangku'),
          bottom: TabBar(controller: _tabController, tabs: const [
            Tab(
              icon: Icon(Icons.data_usage),
            ),
            Tab(
              icon: Icon(Icons.list),
            ),
            Tab(
              icon: Icon(Icons.menu_book),
            ),
            Tab(
              icon: Icon(Icons.settings),
            ),
          ]),
          actions: [
            // Previous month Button
            IconButton(
                onPressed: () {
                  if (_datePicker != null) {
                    _datePicker = DateTime(_datePicker!.year,
                        _datePicker!.month - 1, _datePicker!.day);
                    setState(() {});
                  }
                },
                icon: const Icon(Icons.navigate_before)),
            // Calendar Button
            TextButton(
                onPressed: () async {
                  DateTime? selectedDate = await showMonthPicker(
                      context: context,
                      initialDate:
                          (_datePicker == null) ? DateTime.now() : _datePicker,
                      firstDate: DateTime(2023),
                      lastDate: DateTime(2025));
                  if (selectedDate != null) {
                    _datePicker = selectedDate;
                  }
                  if (kDebugMode) {
                    print(_datePicker);
                  }
                  setState(() {});
                },
                child: Text(_datePicker != null
                    ? DateFormat.yMMM().format(_datePicker!)
                    : "")),
            // Next month Button
            IconButton(
                onPressed: () {
                  if (_datePicker != null) {
                    _datePicker = DateTime(_datePicker!.year,
                        _datePicker!.month + 1, _datePicker!.day);
                    if (kDebugMode) {
                      print(_datePicker);
                    }
                    setState(() {});
                  }
                },
                icon: const Icon(Icons.navigate_next)),
          ],
        ),
        body: TabBarView(controller: _tabController, children: [
          ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                height: 300,
                child: Column(
                  children: [
                    Expanded(
                      child: PieChart(PieChartData(sectionsSpace: 0, sections: [
                        PieChartSectionData(
                            value: 20,
                            color: Colors.purple.shade300,
                            title: ''),
                        PieChartSectionData(
                            value: 80, color: Colors.purple.shade200, title: '')
                      ])),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              width: 15,
                              height: 15,
                              color: Colors.purple.shade300,
                            ),
                            const Text('Pemasukan'),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              width: 15,
                              height: 15,
                              color: Colors.purple.shade300,
                            ),
                            const Text('Pengeluaran'),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Center(
            child: Text('Tidak ada Transaksi'),
          ),
          Center(
            child: Text('Tidak ada Hutang'),
          ),
          Center(
            child: Text('Pengaturan'),
          ),
        ]),
        floatingActionButton:
            _tabController.index == 0 || _tabController.index == 3
                ? null
                : FloatingActionButton(
                    onPressed: () {
                      // Checking if tab in transaction or debt
                      if (_tabController.index == 1) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TransaksiPage()));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HutangPage()));
                      }
                    },
                    child: const Icon(Icons.add),
                  ));
  }
}
