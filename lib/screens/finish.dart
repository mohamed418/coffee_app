import 'package:coffee_app/screens/coffee_concept_list.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Finish extends StatelessWidget {
  const Finish({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/lotties/coffee3.json'),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CoffeeConceptList()));
                },
                child: const Text(
                  'again?',
                  style: TextStyle(
                    color: Colors.brown,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
