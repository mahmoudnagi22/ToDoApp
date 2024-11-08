import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/core/assets_manager.dart';
import 'package:to_do_app/core/constant_manager.dart';
import 'package:to_do_app/core/reusable_components/custom_text_form_field.dart';
import 'package:to_do_app/core/routes_manager.dart';
import 'package:to_do_app/core/strings_manager.dart';
import 'package:to_do_app/core/utils/dialog_utils.dart';
import 'package:to_do_app/database_manager/model/user_dm.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  TextEditingController fullNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePassordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF004182),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Image.asset(AssetsManager.routLogoPng),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Full Name",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    CustomTextFormField(
                      hintText: "enter your full name",
                      validatot: (input) {
                        if (input == null || input.trim().isEmpty) {
                          return 'Please enter full name';
                        }
                        if (input.length < 6) {
                          return 'Invalid input';
                        }
                      },
                      controller: fullNameController,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "User Name",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    CustomTextFormField(
                      hintText: "enter user name",
                      validatot: (input) {
                        if (input == null || input.trim().isEmpty) {
                          return 'Please enter user name';
                        }
                        if (input.length < 6) {
                          return 'Invalid input';
                        }
                      },
                      controller: userNameController,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        " E-mail",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    CustomTextFormField(
                      hintText: "enter your email-address",
                      validatot: (input) {
                        if (input == null || input.trim().isEmpty) {
                          return 'Please enter  email address';
                        }
                        if (input.length < 6) {
                          return 'Invalid input';
                        }
                      },
                      controller: emailController,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "Password",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    CustomTextFormField(
                      hintText: "enter your Password",
                      validatot: (input) {
                        if (input == null || input.trim().isEmpty) {
                          return 'Please enter password';
                        }
                        if (input.length < 6) {
                          return 'Short password ';
                        }
                      },
                      controller: passwordController,
                      isScure: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "Re-Password",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    CustomTextFormField(
                      hintText: "Confirm p\Password",
                      validatot: (input) {
                        if (input == null || input.trim().isEmpty) {
                          return 'Please enter password';
                        }
                        if (input.length < 6) {
                          return 'Short password ';
                        }
                      },
                      controller: rePassordController,
                      isScure: true,
                    ),
                    SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: MaterialButton(
                        padding: EdgeInsets.symmetric(vertical: 18),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        onPressed: () {
                          signUp(context);
                        },
                        child: Text(StringsManager.signUp,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Color(0xFF004182),
                            )),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have Account? ",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, RoutesManager.loginRoute);
                          },
                          child: Text(
                            StringsManager.signIn,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void signUp(context) async {
    try {
      DialogUtils.showLoadingDialog(context, message: "Loading...");
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      UserDM user = UserDM(
          id: credential.user!.uid,
          email: emailController.text,
          fullName: fullNameController.text,
          userName: userNameController.text);
      addUserToFireStore(user);
      DialogUtils.hideDialog(context);
      DialogUtils.showMessageDialog(context,
          content: "User register successfully ",
          posActionTitle: "ok", posAction: () {
        Navigator.pushReplacementNamed(context, RoutesManager.loginRoute);
      });
    } on FirebaseAuthException catch (authError) {
      DialogUtils.hideDialog(context);
      String message;
      if (authError.code == AppConstant.weakPassword) {
        message = AppConstant.passwordProvidedMessage;
      } else if (authError.code == AppConstant.emailAlreadyInUse) {
        message = AppConstant.accountAlreadyExistsMessage;
      } else {
        message = "try agin ";
      }
      DialogUtils.showMessageDialog(context,
          titel: "Error", content: message, posActionTitle: "ok");
    } catch (e) {
      DialogUtils.hideDialog(context);
      DialogUtils.showMessageDialog(context,
          titel: "Error", content: e.toString(), posActionTitle: "ok");
    }
  }

  addUserToFireStore(UserDM user) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(UserDM.collectionName);
    DocumentReference newUserDoc = collectionReference.doc(user.id);
    newUserDoc.set(await user.toFireStor());
  }
}
