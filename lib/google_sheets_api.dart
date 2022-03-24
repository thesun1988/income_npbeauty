import 'package:gsheets/gsheets.dart';

class GoogleSheetsApi {
  // create credentials
  static const _credentials = r'''
  {
  "type": "service_account",
  "project_id": "np-beauty-income",
  "private_key_id": "840ea034d93421fbf77d096c8f41c5e97ffb1319",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDAtFNNuZkPJqmF\n7P0vo38Nexo6I+eObZhwiAksbNV1X49CzMMkf0qRthFcaANsz1OHof9iVMONJvbD\nAXi0Ifl6kqLIIqvcYg0XM7XYdhI+xdYzXrXb7g6zuG+jnN4G4ZdMW6rYIMzmLjGp\nma/5a2mhOvwdQ4ko/83zim3i2KVgcVY8tm0NYFwSX96L+I09hmbtmGi+vHMI3KTh\nKdKqoE54shBjJ5LIvIXDNi8puksHHuI8EFsY+oII7NDsFyqxbycCDL+Byg3krk0r\nMtUspFjWR5VvckXu8Y4BJFeAiFplBqv2guenz3RqFVXIkjDTi3XcnGdRFH6U8E5F\nFLzeKW5XAgMBAAECggEADyJ6gm8SYtq9/gs8DVrxa8J12l10iRP5dikbqKtkORjd\nZw6EQGBmSmW6x6pRo+Dv+1s79AyajoJMvMm89vojc77YMxC/X7UsYwdIKm0yMfpB\nav0Zb7cAMkRI3FhB0II06vsuGABnfKfhyvi2QJ1w3ogD7LEfsM0lGedkNFNLQHTd\n+UrVyslwGaws4v/vqjXZ07xGvfLT+K0ecRE9L4/iyGGkFAT15Qz2OTiMG3v8YZRz\nI2vzG7xWSi/jhGoRZf64n/qXOtO6vvQRwmcR8xDAnhNn8+q+FxfV+h++X/2H4oXN\nihIjvqymch0Ka2GHYIw8bt3eNP2PKKl7Qh8ijiaVtQKBgQDwqCKjPlEl5US2baXu\nMsopBY83CCalCn2oybXSZzaSIvP2fIVCjKbZhL5a1dsiKTkT1hKnap67dLnzOxDk\nfZrBG/cX3Vd97tVayUZXWK3bPQUfcNMuJPgrP4RnZTJ3Gy9Vc4Bp8tn9BESRhz3e\nybuUArBtdfnnY0oeABpMSXcVywKBgQDM/YnLonwD1Fi6IGujfGxH6EeKHcJdKKaI\nVHIKWmM2Hfejum7seMlSk8shHDy8i+ymkxBq8Oy41X5J9dBHRuXEPPq6nMxoL+6L\n61QIaS+cmeFRDKukhGOE5NXRmT9Dnccv7D4PJxvB2Qvidym5qOEIqkjUYwLXrJCh\nxThHHrDYJQKBgAzd8Hwp6MzN5U6brjN+I7Dtyyp2FRrd5LoRjtchDZnipIiZP8a/\nHmyi3EqfBIhfC94zo+uvl60OIKMQlWaiEJQimqN8AiGJk363JDunUiRWrt9veNsO\nvvYQ/1NH5drYaT94XXVMtrsAb2oYgQZYYt8XBbfUhvgIJv5ToxRRGTzhAoGAPD4W\njN3HjGiPWsPEXltmhwtgWtq8EByuNEp86UX++hx8doWHq78jiz0b6TMfNln4xktZ\n+9Op/ffgEWRIPWo8hBtXpBgIimXruPsDyyT+dQtUCDmtB8BQbvHBVMOwr/JiY1cO\nNe3MXn+m2nsirAlRePZySNiAMVnpd2E6VMxUNHECgYBLyhYsUQKle8z3STKSlDRt\nsKxIKhgsZeMu3STpK9RGaRLMlPB1ysDgYMGGPS3RByhVb6G8eTcsNbP7lCmnKLlF\nYGwGXPETtztSWq/da6wQ53fJfNv1HMyWg0SnApg5dx77aM8ENTlSRhIMoDAhgqyf\nUG1nzTvCIJNm7/KpITJdfg==\n-----END PRIVATE KEY-----\n",
  "client_email": "np-beauty-income@np-beauty-income.iam.gserviceaccount.com",
  "client_id": "101754710586598765533",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/np-beauty-income%40np-beauty-income.iam.gserviceaccount.com"
}
  ''';

  // set up & connect to the spreadsheet
  static final _spreadsheetId = '1EiPzCzh-RcNhx_HLOLmTJ9kmFNFNCcT-xM0UY7EglXM';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _worksheet;

  // some variables to keep track of..
  static int numberOfTransactions = 0;
  static List<List<dynamic>> currentTransactions = [];
  static String thisMonth = '0';
  static int tempThisMonth = 0;
  static String income = '0';
  static int tempIncome = 0;
  static String lastMonth = '0';
  static bool loading = true;

  // initialise the spreadsheet!
  Future init() async {
    final ss = await _gsheets.spreadsheet(_spreadsheetId);
    _worksheet = ss.worksheetByTitle('Worksheet1');
    //await _worksheet!.values.insertValue('ok1', column: 1, row: 1);
    countRows();
    print("dem: " + numberOfTransactions.toString());
  }

  // count the number of notes
  static Future countRows() async {
    // while ((await _worksheet!.values
    //         .value(column: 1, row: numberOfTransactions + 1)) !=
    //     '') {
    //   numberOfTransactions++;
    // }
    numberOfTransactions =
        int.parse(await _worksheet!.values.value(column: 7, row: 4));
    //print(numberOfTransactions);
    // now we know how many notes to load, now let's load them!
    load5Transactions();
  }

  static Future updateIncome() async {
    await new Future.delayed(const Duration(seconds: 3));
    income = await _worksheet!.values.value(column: 9, row: 2);
    print(income);
    return income;
  }

  static Future<String> updateThisMonth() async {
    await new Future.delayed(const Duration(seconds: 3));
    thisMonth = await _worksheet!.values.value(column: 7, row: 2);
    return thisMonth;
  }

  // // load existing notes from the spreadsheet
  // static Future loadTransactions() async {
  //   if (_worksheet == null) return;

  //   for (int i = 1; i < numberOfTransactions; i++) {
  //     final String transactionName =
  //         await _worksheet!.values.value(column: 1, row: i + 1);
  //     final String transactionAmount =
  //         await _worksheet!.values.value(column: 2, row: i + 1);
  //     final String transactionDate =
  //         await _worksheet!.values.value(column: 3, row: i + 1);
  //     final String transactionDateCopy =
  //         await _worksheet!.values.value(column: 4, row: i + 1);

  //     if (currentTransactions.length < numberOfTransactions) {
  //       currentTransactions.add([
  //         transactionName,
  //         transactionAmount,
  //         transactionDate,
  //         transactionDateCopy,
  //       ]);
  //     }
  //   }
  //   thisMonth = await _worksheet!.values.value(column: 7, row: 2);
  //   tempThisMonth = int.parse(thisMonth);
  //   lastMonth = await _worksheet!.values.value(column: 8, row: 2);
  //   print(currentTransactions);
  //   // this will stop the circular loading indicator
  //   loading = false;
  // }
  // load existing notes from the spreadsheet
  static Future load5Transactions() async {
    if (_worksheet == null) return;
    if (numberOfTransactions < 6) {
      for (int i = 1; i < numberOfTransactions + 1; i++) {
        final String transactionName =
            await _worksheet!.values.value(column: 1, row: i + 1);
        final String transactionAmount =
            await _worksheet!.values.value(column: 2, row: i + 1);
        final String transactionDate =
            await _worksheet!.values.value(column: 3, row: i + 1);
        final String transactionDateCopy =
            await _worksheet!.values.value(column: 4, row: i + 1);

        if (currentTransactions.length < numberOfTransactions) {
          currentTransactions.add([
            transactionName,
            transactionAmount,
            transactionDate,
            transactionDateCopy,
          ]);
        }
      }
      income = await _worksheet!.values.value(column: 9, row: 2);
      thisMonth = await _worksheet!.values.value(column: 7, row: 2);
      //tempThisMonth = int.parse(thisMonth);
      lastMonth = await _worksheet!.values.value(column: 8, row: 2);
      print(currentTransactions);
      // this will stop the circular loading indicator
      loading = false;
    } else {
      for (int i = 1; i < 6; i++) {
        final String transactionName = await _worksheet!.values
            .value(column: 1, row: i + numberOfTransactions - 4);
        final String transactionAmount = await _worksheet!.values
            .value(column: 2, row: i + numberOfTransactions - 4);
        final String transactionDate = await _worksheet!.values
            .value(column: 3, row: i + numberOfTransactions - 4);
        final String transactionDateCopy = await _worksheet!.values
            .value(column: 4, row: i + numberOfTransactions - 4);

        if (currentTransactions.length < numberOfTransactions) {
          currentTransactions.add([
            transactionName,
            transactionAmount,
            transactionDate,
            transactionDateCopy,
          ]);
        }
      }
      income = await _worksheet!.values.value(column: 9, row: 2);
      thisMonth = await _worksheet!.values.value(column: 7, row: 2);
      //tempThisMonth = int.parse(thisMonth);
      lastMonth = await _worksheet!.values.value(column: 8, row: 2);
      print(currentTransactions);
      // this will stop the circular loading indicator
      loading = false;
    }
  }

  // insert a new transaction
  static Future insert(
      String name, String amount, String date, String dateCopy) async {
    if (_worksheet == null) return;
    numberOfTransactions++;
    currentTransactions.add([
      name,
      amount,
      date,
      dateCopy,
    ]);

    await _worksheet!.values.appendRow([
      name,
      amount,
      date,
      dateCopy,
    ]);
    print(currentTransactions);
  }

  // CALCULATE THE TOTAL INCOME this month
  static int calculateThisMonth() {
    // updateThisMonth();
    // tempThisMonth = int.parse(thisMonth);
    // return tempThisMonth;
    print("lengh: " + currentTransactions.length.toString()); 
    if (tempThisMonth == 0) {
      tempThisMonth = int.parse(thisMonth);
      return int.parse(thisMonth);
    } else {
      tempThisMonth +=
          int.parse(currentTransactions[currentTransactions.length - 1][1]);
      print(currentTransactions[currentTransactions.length - 1][1]);
      print("ThisMonth"+thisMonth);
    print("tempThisMonth"+ tempThisMonth.toString());
      return tempThisMonth;
    }
  }

  // CALCULATE THE TOTAL income last month
  static Future calculateLastMonth() async {
    String lastMonth = await _worksheet!.values.value(column: 8, row: 2);
    return lastMonth;
  }

  // static int calculateIncome() {
  //   int totalIncome = 0;
  //   for (int i = 0; i < currentTransactions.length; i++) {
  //     totalIncome += int.parse(currentTransactions[i][1]);
  //   }
  //   return totalIncome;
  // }
  static int calculateIncome() {
    
    if (tempIncome == 0) {
      tempIncome = int.parse(income);
      return int.parse(income);
    } else {
      tempIncome +=
          int.parse(currentTransactions[currentTransactions.length - 1][1]);
      print(currentTransactions[currentTransactions.length - 1][1]);
      //print("income temp:" + tempIncome.toString());
      print("lengh: " + currentTransactions.length.toString());
    print("Income"+income);
    print("tempIncome"+ tempIncome.toString());
      return tempIncome;
    }
  }
  //   updateIncome();
  //   tempIncome = int.parse(income);
  //   print("temp" + tempIncome.toString());
  //   return tempIncome;
  // }
}
