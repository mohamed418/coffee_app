import 'dart:developer';
import 'package:coffee_app/models/coffee.dart';
import 'package:coffee_app/screens/coffee_details.dart';
import 'package:coffee_app/screens/home.dart';
import 'package:flutter/material.dart';

const initialPage = 8.0;

class CoffeeConceptList extends StatefulWidget {
  const CoffeeConceptList({Key? key}) : super(key: key);

  @override
  State<CoffeeConceptList> createState() => _CoffeeConceptListState();
}

class _CoffeeConceptListState extends State<CoffeeConceptList> {
  final pageCoffeeController = PageController(
    viewportFraction: 0.35,
    initialPage: initialPage.toInt(),
  );
  final pageTextController = PageController(
    initialPage: initialPage.toInt(),
  );

  double currentPage = initialPage;
  double textPage = initialPage;
  double pricePage = initialPage;


  void coffeeScrollListener() {
    setState(() {
      currentPage = pageCoffeeController.page!;
    });
  }

  void textScrollingListener() {
    textPage = currentPage;
  }

  void priceScrollingListener() {
    pricePage = currentPage;
  }

  @override
  void initState() {
    pageCoffeeController.addListener(coffeeScrollListener);
    pageTextController.addListener(textScrollingListener);
    super.initState();
  }

  @override
  void dispose() {
    pageCoffeeController.removeListener(coffeeScrollListener);
    pageTextController.removeListener(textScrollingListener);
    pageCoffeeController.dispose();
    pageTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: BackButton(
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 650),
                  pageBuilder: (context, animation, _) {
                    return FadeTransition(
                      opacity: animation,
                      child: const Home(),
                    );
                  },
                ),
              );
            },
            color: Colors.brown,
          ),
        ),
        body: SafeArea(
          child: Stack(children: [
            Positioned(
              left: 20,
              right: 20,
              bottom: -size.height * 0.22,
              height: size.height * 0.3,
              child: const DecoratedBox(
                decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                  BoxShadow(
                    color: Colors.brown,
                    blurRadius: 80,
                    spreadRadius: 45,
                  )
                ]),
              ),
            ),
            Transform.scale(
              scale: 1.6,
              alignment: Alignment.bottomCenter,
              child: PageView.builder(
                key: const PageStorageKey<String>('image'),
                physics: const BouncingScrollPhysics(),
                controller: pageCoffeeController,
                scrollDirection: Axis.vertical,
                itemCount: coffees.length + 1,
                onPageChanged: (value) {
                  if (value < coffees.length) {
                    pageTextController.animateToPage(
                      value,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return const SizedBox.shrink();
                  }
                  final coffee = coffees[index - 1];
                  final result = currentPage - index + 1;
                  final value = -0.4 * result + 1;
                  final opacity = value.clamp(0.0, 1.0); // to put the lower and upper limit in the opacity
                  log(result.toString());
                  //print(index);
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 650),
                          pageBuilder: (context, animation, _) {
                            return FadeTransition(
                              opacity: animation,
                              child: CoffeeDetails(coffee: coffee),
                            );
                          },
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Transform(
                        alignment: Alignment.bottomCenter,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..translate(
                            0.0,
                            size.height / 2.6 * (1 - value).abs(),
                          )..scale(value),
                        child: Opacity(
                            opacity: opacity,
                            child: Hero(
                              tag: coffee.name,
                              child: Image.asset(
                                coffee.image,
                                fit: BoxFit.fitHeight,
                              ),
                            )),
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
                left: 0,
                top: 0,
                right: 0,
                height: 100,
                child: Column(children: [
                  Flexible(
                    flex: 4,
                    child: PageView.builder(
                      key: const PageStorageKey<String>('text'),
                      controller: pageTextController,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final opacity =
                            (1 - (index - textPage).abs()).clamp(0.0, 1.0);
                        return Opacity(
                          opacity: opacity,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.2),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Hero(
                                tag: 'text_${coffees[index].name}',
                                child: Material(
                                  child: Text(
                                    coffees[index].name,
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.brown,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                    ), // TextStyle
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: coffees.length,
                    ),
                  ),
                  const SizedBox(
                    height: 0,
                  ),
                  // Flexible(
                  //   flex: 1,
                  //   child: PageView.builder(
                  //     controller: pagePriceController,
                  //     //physics: const NeverScrollableScrollPhysics(),
                  //     itemBuilder: (context, index) {
                  //       final opacity =
                  //           (1 - (index - pricePage).abs()).clamp(0.0, 1.0);
                  //       return Opacity(
                  //         opacity: opacity,
                  //         child: Padding(
                  //           padding: EdgeInsets.symmetric(
                  //               horizontal: size.width * 0.2),
                  //           child: AnimatedSwitcher(
                  //             duration: const Duration(milliseconds: 500),
                  //             child: Hero(
                  //               tag: 'text_${coffees[index].price}',
                  //               child: Material(
                  //                 child: Text(
                  //                   '\$${coffees[index].price}',
                  //                   maxLines: 1,
                  //                   textAlign: TextAlign.center,
                  //                   style: const TextStyle(
                  //                     fontSize: 15,
                  //                     fontWeight: FontWeight.w600,
                  //                   ), // TextStyle
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //     itemCount: coffees.length,
                  //   ),
                  // ),
                  // AnimatedSwitcher(
                  //     duration: const Duration(milliseconds: 500),
                  //     child: Text(
                  //       '\$${coffees[currentPage.toInt()].price.toStringAsFixed(2)}',
                  //       style: const TextStyle(
                  //         fontSize: 18,
                  //       ), // TextStyle
                  //       key: Key(coffees[currentPage.toInt()].name),
                  //     ))
                ]))
          ]),
        ));
  }
}
