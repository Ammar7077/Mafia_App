import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mafia_app/providers/provider.dart';

Row role(String role, int number, MyProvider provider) => Row(
      children: [
        Text(role),
        const Spacer(),
        IconButton(
            onPressed: () => provider.minus(role, number),
            icon: const Icon(Icons.remove)),
        Text(number.toString()),
        IconButton(
            onPressed: () => provider.plus(role), icon: const Icon(Icons.add)),
      ],
    );

Column textField(TextEditingController roleController, MyProvider provider) =>
    Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 250,
              child: TextField(
                onChanged: (role) => provider.check(role),
                controller: roleController,
                decoration: const InputDecoration(
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
                icon: const Icon(Icons.remove)),
            Text(provider.number.toString()),
            IconButton(
                onPressed: () => provider.plusNew(),
                icon: const Icon(Icons.add)),
          ],
        ),
        TextButton(
          onPressed: provider.callback
              ? () => provider.addToRoles({
                    provider.roleController.text: provider.number,
                  })
              : null,
          child: Text("إضافة شخصية جديدة",
              style: TextStyle(
                  fontSize: 16,
                  color: provider.callback ? Colors.blue : Colors.grey)),
        ),
        const SizedBox(height: 50),
      ],
    );

void navigateTo(context, route) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));

Future navigateToReplacement(context, route) => Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (context) => route));
