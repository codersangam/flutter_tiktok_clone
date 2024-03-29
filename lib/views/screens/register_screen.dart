import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';
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
    return Obx(() {
      return Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                'Cryptogram'
                    .text
                    .size(35)
                    .color(primayColor!)
                    .fontWeight(FontWeight.w900)
                    .make(),
                25.heightBox,
                VStack([
                  authController.profileImage.value == ""
                      ? VxCircle(
                          radius: 100,
                          backgroundImage: const DecorationImage(
                            fit: BoxFit.cover,
                            // image: MemoryImage(_image!),
                            image:
                                AssetImage('assets/images/default_image.png'),
                          ),
                          child: Align(
                            child: IconButton(
                              onPressed: () =>
                                  authController.pickImage(ImageSource.gallery),
                              icon: const Icon(Icons.add_a_photo),
                            ),
                            alignment: Alignment.bottomRight,
                          ),
                        )
                      : VxCircle(
                          radius: 100,
                          backgroundImage: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(
                              File(authController.profileImage.toString()),
                            ),
                          ),
                          child: Align(
                            child: IconButton(
                              onPressed: () =>
                                  authController.pickImage(ImageSource.gallery),
                              icon: const Icon(Icons.add_a_photo),
                            ),
                            alignment: Alignment.bottomRight,
                          ),
                        )
                ]),
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
                    onPressed: () => authController.registerUser(
                        usernameController.text,
                        emailController.text,
                        passwordController.text,
                        File(authController.profileImage.toString())),
                    child: authController.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : 'Register'.text.lg.bold.make(),
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
                      child: 'Login'.text.color(primayColor!).make(),
                    ),
                  ],
                ),
                50.heightBox,
                'Login with Google'.text.xl.make(),
                20.heightBox,
                InkWell(
                  onTap: () => authController.googleSignUp(),
                  child: SvgPicture.asset(
                    'assets/images/google.svg',
                    width: 40,
                    height: 40,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
