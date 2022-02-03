import 'package:flutter/material.dart';
import 'package:tiktok_clone/contants.dart';
import 'package:tiktok_clone/views/screens/login_screen.dart';
import 'package:tiktok_clone/views/widgets/custom_text_field.dart';
import 'package:velocity_x/velocity_x.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            'Tuk Tuk'
                .text
                .size(35)
                .color(primayColor!)
                .fontWeight(FontWeight.w900)
                .make(),
            'Register'.text.size(25).fontWeight(FontWeight.w700).make(),
            25.heightBox,
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomTextField(
                  labelText: 'Username',
                  controller: usernameController,
                  icon: Icons.person),
            ),
            10.heightBox,
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomTextField(
                  labelText: 'Email',
                  controller: emailController,
                  icon: Icons.email),
            ),
            10.heightBox,
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomTextField(
                labelText: 'Password',
                controller: passwordController,
                icon: Icons.lock,
                isPassword: true,
              ),
            ),
            25.heightBox,
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width - 40,
              child: ElevatedButton(
                onPressed: () {},
                child: 'Register'.text.lg.bold.make(),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(primayColor),
                ),
              ),
            ),
            10.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                'Already have an Account? '.text.make(),
                InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: 'Login'.text.color(primayColor!).make()),
              ],
            )
          ],
        ),
      ),
    );
  }
}
