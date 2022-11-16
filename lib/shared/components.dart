import 'package:flutter/material.dart';
import 'package:mafia_app/providers/provider.dart';

getHeight(context) => MediaQuery.of(context).size.height;

getWidth(context) => MediaQuery.of(context).size.width;

Row role(String role, int number, MyProvider provider, size) => Row(
      children: [
        Text(
          role,
          style: TextStyle(
              color: Colors.white, fontSize: size, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        IconButton(
            onPressed: () => provider.minus(role, number),
            icon: const Icon(
              Icons.remove,
              color: Color.fromRGBO(203, 15, 15, 1),
            )),
        Text(
          number.toString(),
          style: TextStyle(color: Colors.white, fontSize: size),
        ),
        IconButton(
          onPressed: () => provider.plus(role),
          icon: Icon(
            Icons.add,
            color: Colors.blue,
            size: size * 1.5,
          ),
        ),
      ],
    );

Column textField(
        context, TextEditingController roleController, MyProvider provider) =>
    Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 180,
              child: TextField(
                onChanged: (role) => provider.check(role),
                controller: roleController,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  labelText: "شخصية جديدة",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1.5, color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                ),
              ),
            ),
            const Spacer(),
            IconButton(
                onPressed: () => provider.minusNew(),
                icon: const Icon(
                  Icons.remove,
                  color: Color.fromRGBO(203, 15, 15, 1),
                )),
            Text(
              provider.number.toString(),
              style: TextStyle(
                  color: Colors.white, fontSize: getHeight(context) * 0.022),
            ),
            IconButton(
              onPressed: () => provider.plusNew(),
              icon: const Icon(
                Icons.add,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        SizedBox(height: getHeight(context) * 0.01),
        OutlinedButton(
          onPressed: provider.callback
              ? () {
                  provider.addToRoles({
                    provider.roleController.text: provider.number,
                  });
                  provider.callback = false;
                }
              : null,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                provider.callback ? Colors.blue : Colors.white),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          child: Text("إضافة شخصية جديدة",
              style: TextStyle(
                  fontSize: 16,
                  color: provider.callback ? Colors.white : Colors.grey)),
        ),
        SizedBox(height: getHeight(context) * 0.1),
      ],
    );

void navigateTo(context, route) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));

Future navigateToReplacement(context, route) => Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (context) => route));
