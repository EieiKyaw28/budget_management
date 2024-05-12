import 'package:budget_management/constant/number_formatter.dart';
import 'package:budget_management/constant/style.dart';
import 'package:budget_management/db/daily_expense.dart';
import 'package:budget_management/presentation/balance_detail_page.dart';
import 'package:budget_management/presentation/create_screen.dart';
import 'package:budget_management/presentation/graph_page.dart';
import 'package:budget_management/presentation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realm/realm.dart';

// final dataProvider = StreamProvider<List<DailyExpense>>((ref) {
//   return Stream.periodic(
//     const Duration(seconds: 2),
//     (
//       (list) => DailyExpense(id, amount, name)
//     )
//   );

// });
class DrawerList {
  String name;
  double price;
  String quantity;

  DrawerList({required this.name, required this.price, required this.quantity});
}

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List<DrawerList> drawerList = [
    DrawerList(name: "Graph", price: 0.0, quantity: "0"),
    DrawerList(name: "Graph", price: 0.0, quantity: "0"),
    DrawerList(name: "Graph", price: 0.0, quantity: "0"),
    DrawerList(name: "Graph", price: 0.0, quantity: "0"),
  ];

  var config = Configuration.local([DailyExpense.schema]);
  int totalAmount = 0;

  @override
  Widget build(BuildContext context) {
    var realm = Realm(config);
    final expense = ref.watch(expenseProvider);
    var exp = realm.all<DailyExpense>();
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        automaticallyImplyLeading: true,
        title: Text("Manage Your Budet"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            for (var i in drawerList) ...[
              ListTile(
                title: Text(
                  "${i.name}",
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  context.pushNav(screen: GraphPage());
                },
              )
            ]
          ],
        ),
      ),
      body: expense.when(
        data: (data) {
          for (int i = 0; i < data.length; i++) {
            totalAmount += data[i].amount;
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BalanceDetailPage()));
                    },
                    child: _balanceCard(totalAmount)),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    // height: 500,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: exp.length,
                              itemBuilder: (context, index) {
                                return _listCard(
                                  exp[index].name,
                                  exp[index].amount,
                                  exp[index].createDate,
                                );
                              })
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
        error: (e, st) => Text("$e"),
        loading: () {},
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: b4Color,
        onPressed: () {
          context.pushNav(screen: const CreateScreen());
        },
        child: Icon(Icons.add), // You can use different icons
      ),
    );
  }

  Widget _balanceCard(int totalAmount) {
    return Card(
      elevation: 4,
      child: Container(
        // height: 150,
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [b3Color, b4Color, b5Color]),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Your Balance",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  " ${numberFormatter(totalAmount.toString()).toString()} Ks",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                // Row(
                //   children: [
                //     Text(
                //       "Remaining Balance",
                //       style: TextStyle(
                //           color: Colors.black,
                //           fontSize: 15,
                //           fontWeight: FontWeight.bold),
                //     ),
                //     SizedBox(
                //       width: 15,
                //     ),
                //     Text(
                //       "\$ 2000",
                //       style: TextStyle(
                //           color: Colors.black,
                //           fontSize: 15,
                //           fontWeight: FontWeight.bold),
                //     ),
                //   ],
                // )
              ],
            ),
            // Positioned(
            //     top: 5,
            //     right: 5,
            //     child: Image.asset(
            //       'assets/images/money.png',
            //       height: 130,
            //       width: 100,
            //     ))
          ]),
        ),
      ),
    );
  }

  Widget _listCard(
    String name,
    int amount,
    String date,
  ) {
    return Card(
      elevation: 2,
      color: white,
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
            // color: g1Color.withOpacity(0.15),
            borderRadius: BorderRadius.all(Radius.circular(18))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: 50,
                    // decoration: BoxDecoration(
                    //     color: b2Color.withOpacity(0.15),
                    //     borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/images/trolley.png',
                        height: 60,
                        width: 60,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      Text(
                        "$date",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "${numberFormatter(amount.toString())} Ks",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
