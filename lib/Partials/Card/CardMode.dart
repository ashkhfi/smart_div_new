import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CardMode extends StatefulWidget {
  final String mode;
  final Future<void> Function() onRefresh;

  const CardMode({
    super.key,
    required this.mode,
    required this.onRefresh,
  });

  @override
  _CardModeState createState() => _CardModeState();
}

class _CardModeState extends State<CardMode> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    _controller.repeat();
    try {
      await widget.onRefresh();
    } finally {
      _controller.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Stack(
        children: [
          Container(
            height: 60.h,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(10.dm)),
          ),
          Container(
            height: 57.h,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [
                  Color.fromRGBO(2, 138, 234, 1),
                  Color.fromRGBO(77, 178, 250, 1),
                ]),
                borderRadius: BorderRadius.circular(10.dm)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Mode : [${widget.mode}]", style: TextStyle(
                  color: Colors.white, 
                  fontFamily: "Lato",
                  fontSize: 18.sp
                ),),
                SizedBox(width: 10.w,),
                InkWell(
                  onTap: _handleRefresh,
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _controller.value * 2.0 * 3.141592653589793,
                        child: Icon(LucideIcons.refreshCw, color: Colors.white, size: 25.sp),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}