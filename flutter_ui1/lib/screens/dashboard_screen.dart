import 'package:flutter/material.dart';
import 'package:flutter_ui1/models/transaction_model.dart';

const Color appColor = Color(0xff31343c);
const Color dashboardColor = Color(0xff33343a);
const Color transactionItemColor = Color(0xff3a3b41);
class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;
  int currentPageIndex = 0;
  late Size size;
  Duration duration = const Duration(milliseconds: 300);
  late AnimationController _controller;
  late Animation<double> _dashboardScaled;
  late Animation<Offset> _menuTranslated;
  late Animation<double> _menuScaled;

  final List<Transaction> transactionData = [
    Transaction("MacBook Pro 15", "Apple", 2499, Icons.apple),
    Transaction("MacBook Pro 15", "Apple", 2499, Icons.apple),
    Transaction("MacBook Pro 15", "Apple", 2499, Icons.apple),
    Transaction("MacBook Pro 15", "Apple", 2499, Icons.apple),
    Transaction("MacBook Pro 15", "Apple", 2499, Icons.apple),
    Transaction("MacBook Pro 15", "Apple", 2499, Icons.apple),
  ];

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: duration);
    _dashboardScaled = Tween<double>(begin: 1, end: .6).animate(_controller);
    _menuScaled = Tween<double>(begin: .5, end: 1).animate(_controller);
    _menuTranslated =
        Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0))
            .animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: appColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Sidebar(menuScaled: _menuScaled, menuTranslated: _menuTranslated),
          dashboard(context),
        ],
      ),
    );
  }

  void handleTap() {
    setState(() {
      if (isExpanded) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
      isExpanded = !isExpanded;
    });
  }
  void handlePageChange(int index){
    setState(() {
      currentPageIndex = index;
    });
  }
  List<Widget> buildTransactionList() {
    return transactionData.map((transaction) {
      return Container(
        margin: const EdgeInsets.only(top: 18),
        decoration: BoxDecoration(
          color: isExpanded ? transactionItemColor : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: ListTile(
          title: Text(transaction.title,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: isExpanded ?  Colors.white.withOpacity(0.8) : Colors.black.withOpacity(0.8))),
          leading: Icon(
            transaction.icon,
            color: isExpanded ?  Colors.white.withOpacity(0.8) : Colors.black,
          ),
          trailing: Text("${transaction.price} \u0024",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: isExpanded ?  Colors.white.withOpacity(0.8) : Colors.red.withOpacity(0.8))),
          subtitle: Text(transaction.subtitle, style: TextStyle(color: isExpanded ?  Colors.white.withOpacity(0.8) : Colors.black.withOpacity(0.8)),),
        ),
      );
    }).toList();
  }

  Widget dashboard(context) {
    return AnimatedPositioned(
      top: 0,
      bottom: 0,
      left: !isExpanded ? 0 : .55 * size.width,
      right: !isExpanded ? 0 : -.55 * size.width,
      duration: duration,
      child: ScaleTransition(
        scale: _dashboardScaled,
        child: Material(
          borderRadius: isExpanded
              ? const BorderRadius.all(Radius.circular(30))
              : const BorderRadius.all(Radius.circular(0)),
          animationDuration: duration,
          elevation: 8,
          color: isExpanded ? dashboardColor : Colors.white,
          child: Container(
            padding: const EdgeInsets.only(left: 16, top: 48, right: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                      onTap: handleTap,
                      child: Icon(
                        Icons.menu,
                        color: !isExpanded
                            ? Colors.black
                            : Colors.white.withOpacity(0.6),
                      ),
                    ),
                    Text(
                      "Dashboard",
                      style: TextStyle(
                          fontSize: 22,
                          color: !isExpanded
                              ? Colors.black
                              : Colors.white.withOpacity(0.8)),
                    ),
                    Icon(
                      Icons.settings,
                      color: !isExpanded
                          ? Colors.black
                          : Colors.white.withOpacity(0.6),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 200,
                        child: PageView(
                          scrollDirection: Axis.horizontal,
                          pageSnapping: true,
                          controller: PageController(viewportFraction: 0.84),
                          onPageChanged: handlePageChange,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xff3881fe),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              margin: const EdgeInsets.only(left: 10, right: 0),
                              padding: const EdgeInsets.all(18),
                              width: size.width * .7,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Current Balance",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                color: Colors.white
                                                    .withOpacity(0.5)),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "\u0024 12.435.123",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20,
                                                color: Colors.white
                                                    .withOpacity(0.9)),
                                          )
                                        ],
                                      ),
                                      Text(
                                        "BankX",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color:
                                                Colors.white.withOpacity(0.8)),
                                      )
                                    ],
                                  ),
                                  Text("* * * *   * * * *   * * * *   1 2 3 4",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 19,
                                          color:
                                              Colors.white.withOpacity(0.9))),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Text("Card holder",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 13,
                                                  color: Colors.white
                                                      .withOpacity(0.6))),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text("John ken",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  color: Colors.white
                                                      .withOpacity(0.8))),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text("Expired",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 13,
                                                  color: Colors.white
                                                      .withOpacity(0.6))),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text("05/20",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  color: Colors.white
                                                      .withOpacity(0.8))),
                                        ],
                                      ),
                                      Icon(
                                        Icons.credit_card,
                                        color: Colors.white.withOpacity(0.8),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xff3881fe),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              margin: const EdgeInsets.only(left: 10, right: 0),
                              padding: const EdgeInsets.all(18),
                              width: size.width * .7,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Current Balance",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                color: Colors.white
                                                    .withOpacity(0.5)),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "\u0024 12.435.123",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20,
                                                color: Colors.white
                                                    .withOpacity(0.9)),
                                          )
                                        ],
                                      ),
                                      Text(
                                        "BankX",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color:
                                                Colors.white.withOpacity(0.8)),
                                      )
                                    ],
                                  ),
                                  Text("* * * *   * * * *   * * * *   1 2 3 4",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 19,
                                          color:
                                              Colors.white.withOpacity(0.9))),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Text("Card holder",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 13,
                                                  color: Colors.white
                                                      .withOpacity(0.6))),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text("John ken",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  color: Colors.white
                                                      .withOpacity(0.8))),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text("Expired",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 13,
                                                  color: Colors.white
                                                      .withOpacity(0.6))),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text("05/20",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  color: Colors.white
                                                      .withOpacity(0.8))),
                                        ],
                                      ),
                                      Icon(
                                        Icons.credit_card,
                                        color: Colors.white.withOpacity(0.8),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xff3881fe),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              margin: const EdgeInsets.only(left: 10, right: 0),
                              padding: const EdgeInsets.all(18),
                              width: size.width * .7,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Current Balance",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                color: Colors.white
                                                    .withOpacity(0.5)),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "\u0024 12.435.123",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20,
                                                color: Colors.white
                                                    .withOpacity(0.9)),
                                          )
                                        ],
                                      ),
                                      Text(
                                        "BankX",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color:
                                                Colors.white.withOpacity(0.8)),
                                      )
                                    ],
                                  ),
                                  Text("* * * *   * * * *   * * * *   1 2 3 4",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 19,
                                          color:
                                              Colors.white.withOpacity(0.9))),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Text("Card holder",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 13,
                                                  color: Colors.white
                                                      .withOpacity(0.6))),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text("John ken",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  color: Colors.white
                                                      .withOpacity(0.8))),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text("Expired",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 13,
                                                  color: Colors.white
                                                      .withOpacity(0.6))),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text("05/20",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  color: Colors.white
                                                      .withOpacity(0.8))),
                                        ],
                                      ),
                                      Icon(
                                        Icons.credit_card,
                                        color: Colors.white.withOpacity(0.8),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                     Container(
                       margin: const EdgeInsets.only(top : 15),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Container(
                             width: 10,
                             height: 10,
                             decoration:  BoxDecoration(
                                 color: currentPageIndex == 0 ? const Color(0xff3881fe) : Colors.grey,
                               shape: BoxShape.circle,
                               boxShadow: currentPageIndex == 0 ? [
                                 const BoxShadow(
                                   color: Color(0xff3881fe),
                                   blurRadius: 5,
                                   offset: Offset(0, 0)
                                 )
                               ] : null
                             ),
                           ),
                           const SizedBox(
                             width: 5,
                           ),
                           Container(
                             width: 10,
                             height: 10,
                             decoration:  BoxDecoration(
                                 color: currentPageIndex == 1 ? const Color(0xff3881fe) : Colors.grey,
                                 shape: BoxShape.circle,
                                 boxShadow: currentPageIndex == 1 ? [
                                 const BoxShadow(
                                  color: Color(0xff3881fe),
                                   blurRadius: 5,
                                   offset: Offset(0, 0)
                               )
                         ] : null
                             ),
                           ),
                           const SizedBox(
                             width: 5,
                           ),
                           Container(
                             width: 10,
                             height: 10,
                             decoration: BoxDecoration(
                                 color: currentPageIndex == 2 ? const Color(0xff3881fe) : Colors.grey,
                                 shape: BoxShape.circle,
                                 boxShadow: currentPageIndex == 2 ? [
                                  const BoxShadow(
                                       color: Color(0xff3881fe),
                                       blurRadius: 5,
                                       offset: Offset(0, 0)
                                   )
                                 ] : null
                             ),
                           )
                         ],
                       ),
                     )
                    ]),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: Container(
                    decoration: BoxDecoration(
                      color: isExpanded ? dashboardColor : const Color(0xfff9fbfc),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)
                      )
                    ),
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Transactions",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 22,
                                  color: isExpanded ?  Colors.white.withOpacity(0.8) : Colors.black.withOpacity(0.8))),
                          Icon(
                            Icons.share,
                            color: Colors.black.withOpacity(0.6),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Today",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: isExpanded ?  Colors.white.withOpacity(0.8) : Colors.black.withOpacity(0.6))),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top :10.0, bottom :14.0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  children: buildTransactionList(),
                                ),
                              ),
                            ),
                          )
                        ],
                      ))
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Sidebar extends StatelessWidget {
  const Sidebar(
      {Key? key, required this.menuTranslated, required this.menuScaled})
      : super(key: key);
  final Animation<Offset> menuTranslated;
  final Animation<double> menuScaled;
  @override
  Widget build(BuildContext context) {
    return menu(context);
  }

  Widget menu(context) {
    return SlideTransition(
      position: menuTranslated,
      child: ScaleTransition(
        scale: menuScaled,
        child: Padding(
          padding: const EdgeInsets.only(left: 40.0),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                "https://wme-gep-drupal-hbo-prod.s3.amazonaws.com/content/dam/hbodata/series/girls/character/jessa-johansson-512.jpg?w=160",
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "John Ken",
                              style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.place_outlined,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Sanfancisco",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white.withOpacity(.5)),
                                )
                              ],
                            )
                          ],
                        )),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 10,
                          children: [
                            Icon(Icons.dashboard,
                                color: Colors.white.withOpacity(0.6)),
                            Text(
                              "DashBoard",
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.white.withOpacity(0.6)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Wrap(
                          spacing: 10,
                          children: [
                            Icon(Icons.message,
                                color: Colors.white.withOpacity(0.6)),
                            Text(
                              "Messages",
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.white.withOpacity(0.6)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Wrap(
                          spacing: 10,
                          children: [
                            Icon(Icons.help,
                                color: Colors.white.withOpacity(0.6)),
                            Text(
                              "Utility",
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.white.withOpacity(0.6)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Wrap(
                          spacing: 10,
                          children: [
                            Icon(Icons.transfer_within_a_station,
                                color: Colors.white.withOpacity(0.6)),
                            Text(
                              "Funds Transfer",
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.white.withOpacity(0.6)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Wrap(
                          spacing: 10,
                          children: [
                            Icon(Icons.more,
                                color: Colors.white.withOpacity(0.6)),
                            Text(
                              "Branches",
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.white.withOpacity(0.6)),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                Wrap(
                  spacing: 10,
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.white.withOpacity(0.6),
                    ),
                    Text(
                      "Logout",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.6)),
                    )
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
