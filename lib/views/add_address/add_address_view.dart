import 'package:flutter/material.dart';
import 'package:harmis_opencart/generated/i18n.dart';
import 'package:harmis_opencart/models/address.dart';
import 'package:harmis_opencart/models/country_master.dart';
import 'package:harmis_opencart/utils/common_colors.dart';
import 'package:harmis_opencart/utils/common_utils.dart';
import 'package:harmis_opencart/utils/constant.dart';
import 'package:harmis_opencart/widgets/button/rc_blue_button.dart';
import 'package:harmis_opencart/widgets/lables/drpdown_textview.dart';
import 'package:harmis_opencart/widgets/lables/textfield_lables.dart';
import 'package:harmis_opencart/widgets/shimmer_view/shimmer_single_address.dart';
import 'package:harmis_opencart/widgets/textfield/simple_textfield.dart';
import 'package:provider/provider.dart';

import 'add_address_view_model.dart';

class AddAddressView extends StatefulWidget {
  bool isEdit = false;
  AddressDetails addressDetails;

  AddAddressView({this.isEdit, this.addressDetails});

  @override
  _AddAddressViewState createState() => _AddAddressViewState();
}

class _AddAddressViewState extends State<AddAddressView> {
  var firstNameController = new TextEditingController();
  var lastNameController = new TextEditingController();
  var phoneController = new TextEditingController();
  var addressController = new TextEditingController();
  var cityController = new TextEditingController();
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  bool isFirstLoaded = true;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<AddAddressViewModel>(context).getCountries();
    });
  }

  @override
  Widget build(BuildContext context) {
    return initViews(context);
  }

  Widget initViews(BuildContext context) {
    final mViewModel = Provider.of<AddAddressViewModel>(context);

    if (isFirstLoaded && widget.isEdit && widget.addressDetails != null) {
      isFirstLoaded = false;
      firstNameController.text = widget.addressDetails?.firstName?? "";
      lastNameController.text = widget.addressDetails?.lastName?? "";
      phoneController.text = widget.addressDetails?.phone?? "";
      addressController.text = widget.addressDetails?.add1?? "";
      cityController.text = widget.addressDetails?.city?? "";
    }

    final appBar = AppBar(
      leading: InkWell(
          onTap: () {
            Navigator.of(context).pop(false);
          },
          child: Icon(Icons.arrow_back)),
      elevation: 0.0,
      title: Text(
        S.of(context).addAddress,
        style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18.0,
            color: Colors.white,
            fontFamily: AppConstants.FONT_FAMILY_GOTIK),
      ),
      centerTitle: true,
      backgroundColor: CommonColors.primaryColor,
      iconTheme: IconThemeData(color: Colors.white),
    );
    final padding50 = Padding(padding: EdgeInsets.only(top: 50.0));
    final padding20 = Padding(padding: EdgeInsets.only(top: 20.0));
    final padding80 = Padding(padding: EdgeInsets.only(top: 80.0));
    final lblWhere = new TextFieldLables(S.of(context).whereOrder);
    final etFirstName = SimpleTextField(
      controller: firstNameController,
      hintText: S.of(context).firstname,
      validator: (value) {
        if (value.isEmpty) {
          return S.of(context).firstname;
        }
      },
    );
    final etLastName = SimpleTextField(
      controller: lastNameController,
      hintText: S.of(context).lastName,
      validator: (value) {
        if (value.isEmpty) {
          return S.of(context).lastName;
        }
      },
    );
    final etMobile = SimpleTextField(
      controller: phoneController,
      keyboardType: TextInputType.phone,
      hintText: S.of(context).phone,
      validator: (value) {
        if (value.isEmpty) {
          return S.of(context).phone;
        }
      },
    );

    final etAddress = SimpleTextField(
      controller: addressController,
      hintText: S.of(context).address,
      validator: (value) {
        if (value.isEmpty) {
          return S.of(context).firstname;
        }
      },
    );

    final countryDropDown = mViewModel.countryList.length > 0
        ? Column(
            children: <Widget>[
              DropdownButton(
                isExpanded: true,
                value: mViewModel.selectedCountry,
                items: mViewModel.countryDropdownMenuItems,
                onChanged: mViewModel.onChangeDropdownItem,
                underline: Container(),
              ),
              Container(
                margin: EdgeInsets.only(top: 6.0),
                height: 1.0,
                color: Colors.black38,
              )
            ],
          )
        : Container();

    final stateDropDown = mViewModel.stateList.length > 0
        ? Column(
            children: <Widget>[
              DropdownButton(
                isExpanded: true,
                value: mViewModel.selectedState,
                items: mViewModel.stateDropdownMenuItems,
                onChanged: mViewModel.onChangeStateDropdownItem,
                underline: Container(),
              ),
              Container(
                margin: EdgeInsets.only(top: 6.0),
                height: 1.0,
                color: Colors.black38,
              )
            ],
          )
        : Container();

    final etCity = SimpleTextField(
      controller: cityController,
      hintText: S.of(context).city,
      validator: (value) {
        if (value.isEmpty) {
          return S.of(context).enter_city;
        }
      },
    );

    final btnAddAddress = new RCPrimaryButton(
      onPressed: () {
        // Add address api
        mViewModel.addAddressApi(
            firstname: firstNameController.text,
            lastname: lastNameController.text,
            phone: phoneController.text,
            address: addressController.text,
            city: cityController.text,
            success: (String message) {
              CommonUtils.showSnackBar(message, _globalKey);
              Navigator.pop(context, {
                AppConstants.ADDRESS_ADDED: "1",
              });
            },
            fail: (String message) {
              CommonUtils.showSnackBar(message, _globalKey);
            });
      },
      btnText: S.of(context).addAddress,
    );

    final sizedBox20 = SizedBox(
      height: 20.0,
    );

    final singleChildScrollView = new Form(
        child: Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            lblWhere,
            padding20,
            etFirstName,
            padding20,
            etLastName,
            padding20,
            etMobile,
            padding20,
            etAddress,
            padding20,
            !mViewModel.countryShimmer
                ? countryDropDown
                : ShimmerSingleAddress(),
            padding20,
            !mViewModel.stateShimmer ? stateDropDown : ShimmerSingleAddress(),
            padding20,
            etCity,
            padding50,
            btnAddAddress,
            sizedBox20
          ],
        ),
      ),
    ));

    return Scaffold(
      appBar: appBar,
      key: _globalKey,
      body: singleChildScrollView,
    );
  }
}
