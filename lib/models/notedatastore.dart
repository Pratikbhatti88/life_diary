class NoteDataStore {
  final String day;
  final String date;
  final String time;
  final String message;

  @override
  String toString() {
    return 'NoteDataStore{day: $day,date: $date,time: $time message: $message}';
  }

  NoteDataStore({required this.day,required this.date,required this.time, required this.message});

}

List<NoteDataStore> storeNoteData=[];
List dates = [];
List uniqueDate = [];
List<bool> uniqueValue = [];

// class Date{
//   final String date;
//   bool isselectdata;
//
//   Date(this.date,{this.isselectdata=false});
// }
//
// List<Date> dateData=[];
