import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/pages/home_page.dart';
import 'package:todo_app/resources/r.dart';

class Welcoming extends StatelessWidget {
  const Welcoming({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(fit: BoxFit.cover,
            image: AssetImage(R.drawable.jpg.background),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 190,
            ),
            Container(
              width: 350,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(40)),
              child: const Text(
                textAlign: TextAlign.center,
                "TODO",
                style: TextStyle(
                    fontSize: 55,
                    color: Colors.teal,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 130,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
              child: Lottie.asset(R.animations.ani.getStartedAni), 
            ),
           
          ],
        ),
      ),
    );
  }
}
