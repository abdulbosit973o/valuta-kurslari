import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:iconsax/iconsax.dart';

import '../data/source/model/response/currency_model.dart';
import '../lang/locale_keys.g.dart';
import '../presenter/currency/currency_bloc.dart';
import '../util/language.dart';
import '../util/status.dart';

class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({super.key});

  @override
  State<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  final bloc = CurrencyBloc();
  late BannerAd _bannerAd;
  bool isAdLoaded = false;
  var adUnit = "ca-app-pub-4924950656743042/4141857117";
  bool isSelect = false;

  // List<String> get _listGenderText => ["Male", "Female"];
  // final ValueNotifier<int> _tabIndexTextWithIcon = ValueNotifier(0);
  // List<IconData> get _listIconTabToggle => [
  //   Icons.person,
  //   Icons.pregnant_woman,
  // ];
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2016),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        bloc.add(InitialCurrencyEvent(
            date: selectedDate.toString().substring(0, 10)));
      });
    }
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
    _bannerAd.dispose();
  }

  @override
  void initState() {
    bloc.add(
        InitialCurrencyEvent(date: selectedDate.toString().substring(0, 10)));
    super.initState();
    _loadAd();
  }

  Language _lang = Language.UZ;

  String _getname(CurrencyModel? data) {
    if (data == null) return "";
    if (_lang == Language.UZ) return data.ccyNmUz!;
    if (_lang == Language.RU) return data.ccyNmRu!;
    return data.ccyNmEn!;
  }

  void _loadAd() {
    final bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: adUnit,
      request: const AdRequest(),
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }
          setState(() {
            isAdLoaded = true;
            _bannerAd = ad as BannerAd;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, error) {
          debugPrint('BannerAd failed to load: $error');
          ad.dispose();
        },
      ),
    );

    // Start loading.
    bannerAd.load();
  }

  @override
  Widget build(BuildContext buildContext) {
    return BlocProvider.value(
      value: bloc,
      child: BlocConsumer<CurrencyBloc, CurrencyState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.status == Status.LOADING) {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          } else if (state.status == Status.SUCCESS) {
            return Scaffold(
              appBar: AppBar(
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 13.0),
                    child: InkWell(
                      onTap: () => _selectDate(context),
                      // onTap: () {
                      //   selectedDate,
                      //   // showDatePicker(
                      //   //     context: context,
                      //   //     firstDate: DateTime(2000),
                      //   //     lastDate: DateTime(2044));
                      // },
                      child:
                          const Icon(Iconsax.calendar_25, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: InkWell(
                      onTap: () {

                      },
                      child: const Icon(Iconsax.language_circle,
                          color: Colors.white),
                    ),
                  ),
                ],
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20))),
                title: Text(
                  LocaleKeys.currency.tr().toUpperCase(),
                  style: const TextStyle(
                      fontFamily: 'PaynetB', color: Colors.white),
                ),
                backgroundColor: Colors.deepPurple,
                bottomOpacity: 8.0,
              ),
              body: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: state.data != null && state.data!.isNotEmpty
                    ? buildListView(state)
                    : const Center(
                        child: Text('Empty',
                            style: TextStyle(
                                fontSize: 22, fontFamily: 'PaynetB'))),
              ),
            );
          } else {
            return const Scaffold(
              body: Placeholder(),
            );
          }
        },
      ),
    );
  }

  ListView buildListView(CurrencyState state) {
    return ListView.builder(
        itemCount: state.data?.length,
        itemBuilder: (context, index) {
          String diff = state.data![index].diff == null ? '' : '';
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
            ),
            child: Card(
              child: Theme(
                data: ThemeData().copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  // backgroundColor: Colors.yellow,
                  // maintainState: true,
                  title: Column(children: [
                    Row(
                      children: [
                        Text(
                          _getname(state.data?[index]),
                          style: const TextStyle(
                              fontFamily: 'PaynetB',
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                        const Spacer(),
                        Text(
                          state.data?[index].diff ?? 'null',
                          style: TextStyle(
                            fontFamily: 'PaynetB',
                            color: double.parse((state.data![index].diff == null
                                        ? "0.0"
                                        : state.data![index].diff!)) >=
                                    0.0
                                ? Colors.greenAccent
                                : Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          state.data?[index].nominal ?? 'null',
                          style: const TextStyle(
                              fontFamily: 'PaynetB', fontSize: 14),
                        ),
                        Text(state.data?[index].ccy ?? 'null',
                            style: const TextStyle(
                                fontFamily: 'PaynetB', fontSize: 14)),
                        Text(" =>${state.data?[index].rate ?? 'null'} UZS|",
                            style: const TextStyle(
                                fontFamily: 'PaynetB', fontSize: 14)),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Image.asset(
                            "assets/images/date.png",
                            width: 20,
                            height: 20,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(state.data?[index].date ?? 'null',
                              style: const TextStyle(
                                  fontFamily: 'PaynetB', fontSize: 14)),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ]),
                  children: [
                    if (isAdLoaded)
                      Container(
                        decoration: const BoxDecoration(color: Colors.black),
                        height: _bannerAd.size.height.toDouble(),
                        width: _bannerAd.size.width.toDouble(),
                        child: AdWidget(ad: _bannerAd),
                      ),
                    Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 18.0),
                          child: buildCard(state.data?[index]),
                        )),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Container buildCard(CurrencyModel? data) {
    TextEditingController _controller = TextEditingController();
    if (_controller.text.isEmpty) {
      _controller.text = data!.rate!;
    }
    return Container(
      decoration: BoxDecoration(
          color: Colors.deepPurple, borderRadius: BorderRadius.circular(8)),
      child: SizedBox(
        height: 30,
        width: 130,
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: InkWell(
            onTap: () {
              double count = 1;
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: Container(
                          height: 250,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                height: 10,
                                width: 50,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "${data?.ccyNmUz}",
                                  style: const TextStyle(
                                      fontFamily: 'PaynetB',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 18.0, right: 18, top: 20),
                                child: TextField(
                                  // controller: _controller,
                                  onChanged: (text) {
                                    setState(() {
                                      _controller.text = (double.parse(text) *
                                              double.parse(data!.rate!))
                                          .toString();
                                    });
                                  },
                                  maxLength: 20,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintStyle:
                                        const TextStyle(fontFamily: 'PaynetB'),
                                    labelText: data?.ccyNmUz,
                                    counterText: "",
                                    hintText: 'Enter a number',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  style: const TextStyle(fontFamily: 'PaynetB'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 18.0, right: 18, top: 15),
                                child: TextField(
                                    readOnly: true,
                                    controller: _controller,
                                    decoration: InputDecoration(
                                      labelText: "UZS",
                                      hintText: _controller.text.isEmpty
                                          ? ""
                                          : _controller.text,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ));
              setState(() {});
            },
            child: const Row(
              children: [
                Icon(Iconsax.calculator5, color: Colors.white),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Hisoblash",
                    style:
                        TextStyle(fontFamily: 'PaynetB', color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
