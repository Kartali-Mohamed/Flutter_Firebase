import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_question.dart';
import '../widgets/custom_subtitlepage.dart';
import '../widgets/custom_titlepage.dart';
import '../widgets/custom_buttonauth.dart';
import '../widgets/custom_textform.dart';
import '../widgets/custom_title.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _Registertate();
}

class _Registertate extends State<Register> {
  /* ========= Business Logic ========= */
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formStateKey = GlobalKey<FormState>();

  void signUp(String email, String password) async {
    if (formStateKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        FirebaseAuth.instance.currentUser!.sendEmailVerification();
        Navigator.of(context)
            .pushNamedAndRemoveUntil("login", (route) => false);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("The password provided is too weak.")));
          // print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("The account already exists for that email.")));
          // print('The account already exists for that email.');
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.message!)));
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }

  /* ========= Presentation ========= */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(children: [
          Form(
            key: formStateKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                const CustomTitlePage(title: "Register"),
                const SizedBox(height: 10),
                const CustomSubtitlePage(
                    subtitle: "Register To Continue Using The App"),
                const SizedBox(height: 20),
                const CustomTitle(text: "Username"),
                const SizedBox(height: 10),
                CustomTextForm(
                  hinttext: "ُEnter Your Username",
                  mycontroller: usernameController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "please enter your username";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                const CustomTitle(text: "Email"),
                const SizedBox(height: 10),
                CustomTextForm(
                  hinttext: "ُEnter Your Email",
                  mycontroller: emailController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "please enter your email";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                const CustomTitle(text: "Password"),
                const SizedBox(height: 10),
                CustomTextForm(
                  hinttext: "ُEnter Your Password",
                  mycontroller: passwordController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "please enter your password";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          CustomButtonAuth(
              title: "SignUp",
              onPressed: () {
                signUp(emailController.text, passwordController.text);
              }),
          const SizedBox(height: 20),
          CustomQuestion(
              question: "Have An Account ? ",
              answer: "Login",
              onTap: () {
                Navigator.of(context).pushReplacementNamed("login");
              }),
        ]),
      ),
    );
  }
}
