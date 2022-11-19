import 'package:Mafia/providers/provider.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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

listViewCardsPage(context, provider, txtSize) => ListView.builder(
      itemCount: provider.list.length,
      itemBuilder: (context, i) => Card(
        color: provider.list[i] == "مافيا" || provider.list[i] == "زعيم المافيا"
            ? Colors.black
            : Colors.white70,
        child: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            '${i + 1}  ${provider.list[i]}',
            style: TextStyle(
                color: provider.list[i] == "مافيا" ||
                        provider.list[i] == "زعيم المافيا"
                    ? Colors.white
                    : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: txtSize),
          ),
        )),
      ),
    );
countDownTimer(context, provider) => CircularCountDownTimer(
      // Countdown duration in Seconds.
      duration: provider.duration,

      // Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
      controller: provider.timerController,

      // Width of the Countdown Widget.
      width: getWidth(context) / 2,

      // Height of the Countdown Widget.
      height: getHeight(context) / 2,

      // Ring Color for Countdown Widget.
      ringColor: Colors.white,

      // Filling Color for Countdown Widget.
      fillColor: const Color.fromRGBO(200, 15, 15, 1),

      // Background Color for Countdown Widget.
      backgroundColor: Colors.black,

      // Border Thickness of the Countdown Ring.
      strokeWidth: 20.0,

      // Begin and end contours with a flat edge and no extension.
      strokeCap: StrokeCap.round,

      // Text Style for Countdown Text.
      textStyle: TextStyle(
        fontSize: getWidth(context) * 0.07,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),

      // Format for the Countdown Text.
      textFormat: CountdownTextFormat.S,

      // Handles the timer start.
      autoStart: false,

      // This Callback will execute when the Countdown Ends.
      onComplete: () {
        provider.isTimeComplete = !provider.isTimeComplete;
        provider.isTimeComplete
            ? ''
            : Alert(
                    context: context,
                    title: 'انتهى الوقت',
                    style: AlertStyle(
                      isCloseButton: true,
                      isButtonVisible: false,
                      titleStyle: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 30.0,
                      ),
                    ),
                    type: AlertType.success)
                .show();
        provider.isPause = true;
        provider.timerController.reset();
      },

      // This Callback will execute when the Countdown Changes.
      onChange: (String timeStamp) {
        // Here, do whatever you want
        debugPrint('Countdown Changed $timeStamp');
      },
      timeFormatterFunction: (defaultFormatterFunction, duration) {
        if (duration.inSeconds == 0) {
          // only format for '0'
          return "Start";
        } else {
          // other durations by it's default format
          return Function.apply(defaultFormatterFunction, [duration]);
        }
      },
    );

void navigateTo(context, route) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));

Future navigateToReplacement(context, route) => Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (context) => route));
