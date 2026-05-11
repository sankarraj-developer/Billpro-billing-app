 import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

 class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPagestate();
 }

 class LoginPagestate extends State<LoginPage> {

 final GlobalKey<FormState> formKey = GlobalKey<FormState>();
 final TextEditingController emailController = TextEditingController();
 final TextEditingController passwordController = TextEditingController();

       bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
        
        
           //notification bar
      appBar: AppBar(title: const Text("BillPro Login"),centerTitle: true,),

          //interface

      body: SafeArea(child: SingleChildScrollView(child: Padding(padding: const EdgeInsets.all(20.0),

           child: Form(key: formKey,
           child: Column(crossAxisAlignment: CrossAxisAlignment.center,children: [

     //image
             Image.asset("assets/page.jpg",height: 220,fit: BoxFit.contain,),

     //text
             const SizedBox(height: 20,),

                 const Text("Welcome To BillPro", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,),),

     //2nd text
             const SizedBox(height: 10,),

                  const Text("Login To Continue", style: TextStyle(fontSize: 20,color: Colors.grey),),

     //Email
             const SizedBox(height: 30,),
      
                   TextFormField(controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                            hintText: 'Enter your email',
                              prefixIcon: const Icon(Icons.email),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),),),

     //validation logic for email  

             validator: (value) {
  final input = value?.trim() ?? '';

  if (input.isEmpty) {
    return 'Please enter your email';
  }

  if (!input.contains('@') || !input.contains('.')) {
    return 'Enter a valid email';
  }

  return null;
},
          ),

     //password
        
             const SizedBox(height: 20,),
               TextFormField(controller: passwordController,
                 obscureText: obscurePassword,
                   decoration: InputDecoration(
                     labelText: 'Password',
                       hintText: 'Enter your Password',
                         prefixIcon: const Icon(Icons.lock),
                           suffixIcon: IconButton(icon: Icon(obscurePassword ? Icons.visibility : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  obscurePassword =!obscurePassword; }); }, ),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),),),

    //validation logic for password
            
             validator: (value) {
               if (value==null || value.isEmpty) {
                 return 'Enter your Password';
                 
               }
                 if (value.length <6) {
                   return 'Pasword must be atleast 6 characters';  
                 }
                    return null;
             },
               ),

     //forgot password
             const SizedBox(height: 10,),
               Align(alignment: Alignment.centerRight,
                 child: TextButton(onPressed: () {},child: const Text('Forgot password'),),
                   ),
                   
     //Login Button
             const SizedBox(height: 20,),

              SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    onPressed: () async {
      if (formKey.currentState!.validate()) {
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("SUCCESS: User created")),
          );

        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("ERROR: $e")),
          );
        }
      }
    },

    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),

    child: const Text('Login', style: TextStyle(fontSize: 18)),
  ),
),

          //Create account

              Row(mainAxisAlignment: MainAxisAlignment.center,
                 children: [const Text('Dont have an account'),
                   TextButton(onPressed: () {
                       
                       //navigation addad latter

                   },
                     child: const Text('Create account'),
                   ),   
                   ],
                   ),
           ],
           ),
           ),

      ),  
      ), 
      ),  
      );
  }
}   