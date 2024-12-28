import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:see_weather/core/utils/date_time_utils.dart';
import 'package:see_weather/core/utils/image_utils.dart';
import 'package:see_weather/core/constants/integer_constants.dart';
import 'package:see_weather/core/constants/string_constants.dart';
import 'package:see_weather/core/widgets.dart';
import 'package:see_weather/service/models/astro_response_model.dart';
import 'package:see_weather/service/weather_service.dart/astro_service.dart';

class AstroView extends StatefulWidget {
  const AstroView({super.key, required this.cityName});
  final String cityName;

  @override
  State<AstroView> createState() => _AstroViewState();
}

class _AstroViewState extends State<AstroView> with SingleTickerProviderStateMixin {
  late final AstroService astroService;
  bool _isLoading = false;
  late final DateTimeUtils dateTimeUtils;
  AstroResponseModel? response;
  bool _isNight = false;
  late AnimationController _controller;
  late final Widget _lottieWidget;

  @override
  void initState() {
    super.initState();
    astroService = AstroService();
    dateTimeUtils = DateTimeUtils();
    fetchAstroData();
    checkTimeZone();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 3))..repeat();
    _adjustLottie();
  }

  void _adjustLottie() {
    if (_isNight) {
      _lottieWidget = Lottie.asset(
        'assets/lottiefiles/moonanimation.json',
        height: 150,
        controller: _controller,

        onLoaded: (composition) {
          _controller.duration = composition.duration;
        },
      );
    } else {
      _lottieWidget = Lottie.asset(
        'assets/lottiefiles/bloomingflower.json',
        height: 150,
        controller: _controller,

        onLoaded: (composition) {
          _controller.duration = composition.duration;
        },
      );
    }
  }

  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  void changeisNight(bool value) {
    setState(() {
      _isNight = value;
    });
  }

  Future<void> fetchAstroData() async {
    _changeLoading();
    response = await astroService.fetchAstroData(widget.cityName.toLowerCase());
    _changeLoading();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isNight ? Color(0xFF5f3d8f) : Color(0xFFf2e9c2),
      appBar: AppBar(title: Text(StringConstants.astroHeader)),
      body: Stack(
        children: [
          // Arka plandaki görsel
          compareTimeZone(),

          // Alt kısmı kapatan widget
          Padding(
            padding: const EdgeInsets.only(top: 200),
            child: Positioned(
              bottom: 0,
              left: 0,
              right: 0,

              child: ListView(
                children: [
                  customSizedBox(StringConstants.localTime, response?.location?.localtime),
                  Divider(thickness: IntegerConstants().thickness, color: Color(0xffe4d3ed)),
                  SizedBox(
                    height: 60,
                    child: CustomCard("${StringConstants.sunrise} : ${response?.astronomy?.astro?.sunrise} ",_isNight),
                  ),
                  Divider(thickness: IntegerConstants().thickness, color: Color(0xffe4d3ed)),
                  SizedBox(
                    height: 60,
                    child: CustomCard("${StringConstants.sundown} : ${response?.astronomy?.astro?.sunset} ",_isNight),
                  ),
                  Divider(thickness: IntegerConstants().thickness, color: Color(0xffe4d3ed)),
                  SizedBox(
                    height: 60,
                    child: CustomCard("${StringConstants.moonState} : ${response?.astronomy?.astro?.moonPhase} ",_isNight),
                  ),
            
                  Divider(thickness: IntegerConstants().thickness, color: Color(0xffe4d3ed)),
                  _lottieWidget,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox customSizedBox(String header, String? content) {
    return SizedBox(height: 60, child: CustomCard("$header : $content ",_isNight));
  }

  Future<void> checkTimeZone() async {
    final result = dateTimeUtils.compareTimes(
      response?.location?.localtime ?? "",
      response?.astronomy?.astro?.moonrise ?? "",
      response?.astronomy?.astro?.sunrise ?? "",
    );
    print(result != StringConstants.gunduz);
    changeisNight(result != StringConstants.gunduz);
  }

  Image compareTimeZone() {
    return ImageUtils.getImageFromAssets(_isNight ? StringConstants.gece : StringConstants.gunduz);
  }


}

class TextStyles {
  final textStyle = TextStyle().copyWith(fontSize: 20, color: Colors.white);
}
