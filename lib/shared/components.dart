import 'package:flutter/material.dart';
import '../providers/provider.dart';

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
            color: Colors.white,
            // color: Color.fromRGBO(203, 15, 15, 1),
          ),
        ),
        Text(
          number.toString(),
          style: TextStyle(color: Colors.white, fontSize: size),
        ),
        IconButton(
          onPressed: () => provider.plus(role),
          icon: Icon(
            Icons.add,
            color: const Color.fromRGBO(203, 15, 15, 0.8),
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
              width: getWidth(context) * 0.45,
              child: TextField(
                onChanged: (role) => provider.check(role),
                controller: roleController,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  fillColor: Colors.grey[300],
                  filled: true,
                  hintText: "شخصية جديدة",
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
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
                  color: Colors.white,
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
                color: Color.fromRGBO(203, 15, 15, 0.8),
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
                provider.callback ? Colors.blue : Colors.grey[350]),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          child: Text("إضافة شخصية جديدة",
              style: TextStyle(
                  fontSize: getWidth(context) * 0.04,
                  color: provider.callback ? Colors.white : Colors.black45,
                  fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: getHeight(context) * 0.1),
      ],
    );

void navigateTo(context, route) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));

Future navigateToReplacement(context, route) => Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (context) => route));
