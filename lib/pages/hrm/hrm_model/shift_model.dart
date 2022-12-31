class ShiftModel{
  final int id;
  final String name;
  final String time;
  ShiftModel({required this.id, required this.name,required this.time});

  static ShiftModel getShiftModel(int kind){
    if(kind==1) {
      return ShiftModel(id: 1,name: 'Ca hành chính',time: '08:00 - 17:30');
    } else {
      return ShiftModel(id: 2,name: 'Ca chủ nhật',time: '08:00 - 12:00');
    }
  }
}