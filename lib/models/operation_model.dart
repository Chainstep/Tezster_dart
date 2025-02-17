import 'package:tezster_dart/helper/constants.dart';

class OperationModel {
  String destination;
  String amount;
  int storageLimit;
  int gasLimit;
  int counter;
  String fee;
  String source;
  String kind;
  String publicKey;
  String delegate;
  Map<String, Object> script;

  Map<String, dynamic> parameters;

  String pkh;
  String secret;

  static const Map<String, Object> EMPTY_MAP = {};

  OperationModel({
    this.destination = '',
    this.amount = '',
    this.counter = 0,
    this.fee = '',
    this.source = '',
    this.kind = 'transaction',
    this.gasLimit = TezosConstants.DefaultTransactionGasLimit,
    this.storageLimit = TezosConstants.DefaultTransactionStorageLimit,
    this.publicKey = '',
    this.delegate = '',
    this.script = EMPTY_MAP,
    this.pkh = '',
    this.secret = '',
  }) : parameters = {} {
    if (kind == 'delegation') {
      gasLimit = TezosConstants.DefaultDelegationGasLimit;
      storageLimit = TezosConstants.DefaultDelegationStorageLimit;
    }
  }

  Map<String, dynamic> toJson() => kind == 'delegation'
      ? {
          'counter': counter.toString(),
          'delegate': delegate,
          'fee': fee.toString(),
          'gas_limit': TezosConstants.DefaultDelegationGasLimit.toString(),
          'kind': kind,
          'source': source,
          'storage_limit':
              TezosConstants.DefaultDelegationStorageLimit.toString(),
        }
      : kind == 'reveal'
          ? {
              'kind': kind,
              'source': source,
              'fee': fee,
              'counter': counter.toString(),
              'gas_limit': gasLimit.toString(),
              'storage_limit': storageLimit.toString(),
              'public_key': publicKey
            }
          : kind == "origination"
              ? delegate == null
                  ? {
                      'kind': 'origination',
                      'source': source,
                      'fee': fee.toString(),
                      'counter': counter.toString(),
                      'gas_limit': gasLimit.toString(),
                      'storage_limit': storageLimit.toString(),
                      'balance': amount.toString(),
                      'script': script
                    }
                  : {
                      'kind': 'origination',
                      'source': source,
                      'fee': fee.toString(),
                      'counter': counter.toString(),
                      'gas_limit': gasLimit.toString(),
                      'storage_limit': storageLimit.toString(),
                      'balance': amount.toString(),
                      'delegate': delegate,
                      'script': script
                    }
              : kind == "activate_account"
                  ? {
                      'kind': kind,
                      'pkh': pkh,
                      'secret': secret,
                    }
                  : parameters == null
                      ? {
                          'destination': destination,
                          'amount': amount,
                          'storage_limit': storageLimit.toString(),
                          'gas_limit': gasLimit.toString(),
                          'counter': counter.toString(),
                          'fee': fee,
                          'source': source,
                          'kind': kind,
                        }
                      : {
                          'destination': destination,
                          'amount': amount,
                          'storage_limit': storageLimit.toString(),
                          'gas_limit': gasLimit.toString(),
                          'counter': counter.toString(),
                          'fee': fee,
                          'source': source,
                          'kind': kind,
                          'parameters': parameters,
                        };
}
