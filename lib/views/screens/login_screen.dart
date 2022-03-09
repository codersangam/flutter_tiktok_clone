import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:tiktok_clone/contants.dart';
import 'package:tiktok_clone/views/screens/register_screen.dart';
import 'package:tiktok_clone/views/widgets/custom_text_field.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              'Cryptogram'
                  .text
                  .size(35)
                  .color(primayColor!)
                  .fontWeight(FontWeight.w900)
                  .make(),
              'Login'.text.size(25).fontWeight(FontWeight.w700).make(),
              25.heightBox,
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextField(
                    labelText: 'Email',
                    controller: emailController,
                    icon: Icons.person),
              ),
              10.heightBox,
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextField(
                  labelText: 'Password',
                  controller: passwordController,
                  icon: Icons.lock,
                  isPassword: authController.isPasswordHidden.value,
                  passwordIcon: authController.isPasswordHidden.value
                      ? Icons.visibility_off
                      : Icons.visibility,
                  onTap: () {
                    authController.isPasswordHidden.value =
                        !authController.isPasswordHidden.value;
                  },
                ),
              ),
              25.heightBox,
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width - 40,
                child: ElevatedButton(
                  onPressed: () {
                    authController.loginUser(
                        emailController.text, passwordController.text);
                  },
                  child: authController.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : 'Login'.text.lg.bold.make(),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(primayColor),
                  ),
                ),
              ),
              10.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  'Not have an account? '.text.make(),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: 'Register'.text.color(primayColor!).make()),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
