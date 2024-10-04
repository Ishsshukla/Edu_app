import 'package:flutter/material.dart';
import 'package:upi_india/upi_india.dart';

class UpiScreen extends StatefulWidget {
  const UpiScreen({super.key});

  @override
  _UpiScreenState createState() => _UpiScreenState();
}

class _UpiScreenState extends State<UpiScreen> {
  Future<UpiResponse>? _transaction;
  final UpiIndia _upiIndia = UpiIndia();
  List<UpiApp>? apps;

  TextStyle header = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  TextStyle value = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  @override
  void initState() {
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        apps = value;
      });
    }).catchError((e) {
      print(e);
      apps = [];
    });
    super.initState();
  }

  Future<UpiResponse> initiateTransaction(UpiApp app) async {
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: 'ishs4873@oksbi',
      receiverName: 'ishika shukla',
      transactionRefId: 'TestingId',
      transactionNote: 'Not actual. Just an example.',
      amount: 1.00,
    );
  }

  Widget displayUpiApps() {
    if (apps == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (apps!.isEmpty) {
      return const Center(
        child: Text('No apps found to handle transaction.'),
      );
    } else {
      return Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Wrap(
            children: apps!.map<Widget>((UpiApp app) {
              return GestureDetector(
                onTap: () {
                  _transaction = initiateTransaction(app);
                  setState(() {});
                },
                child: Container(
                  height: 100,
                  width: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.memory(
                        app.icon,
                        height: 60,
                      ),
                      Text(app.name),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
    }
  }

  String _upiErrorHandler(error) {
    switch (error) {
      case UpiIndiaAppNotInstalledException:
        return 'Requested app not installed on device';
      case UpiIndiaUserCancelledException:
        return 'You cancelled the transaction';
      case UpiIndiaNullResponseException:
        return 'Requested app didn\'t return any response';
      case UpiIndiaInvalidParametersException:
        return 'Requested app cannot handle the transaction';
      default:
        return 'An Unknown error has occurred';
    }
  }

  void _checkTxnStatus(String status) {
    switch (status) {
      case UpiPaymentStatus.SUCCESS:
        print('Transaction Successful');
        break;
      case UpiPaymentStatus.FAILURE:
        print('Transaction Failed');
        break;
      case UpiPaymentStatus.SUBMITTED:
        print('Transaction Submitted');
        break;
      default:
        print('Recieved an Unknown transaction status');
    }
  }

  Widget displayTransactionData(title, body) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "$title",
            style: header,
          ),
          Flexible(
              child: Text(
            body,
            style: value,
          )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('UPI India '),
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: displayUpiApps()),
          Expanded(
              child: FutureBuilder(
            future: _transaction,
            builder:
                (BuildContext context, AsyncSnapshot<UpiResponse> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                      child: Text(
                    _upiErrorHandler(snapshot.error.runtimeType),
                    style: header,
                  ));
                }
                UpiResponse _upiResponse = snapshot.data!;

                String txnId = _upiResponse.transactionId ?? 'N/A';
                String resCode = _upiResponse.responseCode ?? 'N/A';
                String txnRef = _upiResponse.transactionRefId ?? 'N/A';
                String approvalRef = _upiResponse.approvalRefNo ?? 'N/A';
                String status = _upiResponse.status ?? 'N/A';
                _checkTxnStatus(status);

                return Padding(
                  padding: const EdgeInsets.all(8.0), 
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:<Widget> [
                    displayTransactionData('Transaction Id: ', txnId),
                    displayTransactionData('Response Code: ', resCode),
                    displayTransactionData('Reference Id: ', txnRef),
                    displayTransactionData('Approval No: ', approvalRef),
                    displayTransactionData('Status: ', status.toUpperCase()),
                  ],
                ));
              }
              else {
                return const Center(
                  child: Text(''),
                );
              }
            },
          )),
        ],
      ),
    );
  }
}
