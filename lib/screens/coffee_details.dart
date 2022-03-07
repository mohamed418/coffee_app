import 'package:coffee_app/models/coffee.dart';
import 'package:coffee_app/screens/coffee_concept_list.dart';
import 'package:coffee_app/screens/finish.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CoffeeDetails extends StatefulWidget {
  const CoffeeDetails({Key? key, required this.coffee}) : super(key: key);
  final Coffee coffee;

  @override
  State<CoffeeDetails> createState() => _CoffeeDetailsState();
}

class _CoffeeDetailsState extends State<CoffeeDetails> {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop(
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 650),
                pageBuilder: (context, animation, _) {
                  return FadeTransition(
                    opacity: animation,
                    child: const CoffeeConceptList(),
                  );
                },
              ),
            );
          },
          color: Colors.brown,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
              child: Hero(
                tag: 'text_${widget.coffee.name}',
                child: Material(
                  child: Text(
                    widget.coffee.name,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.brown,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ), // TextStyle
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: size.height * 0.4,
              child: Stack(children: [
                Positioned.fill(
                  child: Hero(
                    tag: widget.coffee.name,
                    child: Image.asset(
                      widget.coffee.image,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ]),
            ),
            Align(
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(children: [
                  const TextSpan(
                    text: '\$',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF005706),
                        shadows: [
                          BoxShadow(
                            color: Colors.green,
                            blurRadius: 10,
                            spreadRadius: 20,
                          )
                        ]),
                  ),
                  TextSpan(
                    text: widget.coffee.price.toString(),
                    style: const TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w900,
                        color: Colors.brown,
                        shadows: [
                          BoxShadow(
                            color: Color(0xFF5F2500),
                            blurRadius: 10,
                            spreadRadius: 20,
                          )
                        ]),
                  ),
                ]),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'if u want one click me...',
                    style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFFD59035),
                        ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const Finish()));
                    },
                    child: Lottie.asset(
                      'assets/lotties/coffee1.json',
                      height: 150,
                      width: 150,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
