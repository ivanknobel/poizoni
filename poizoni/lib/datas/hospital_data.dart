
class HospitalData{
  String nome;
  String endereco;
  double lat;
  double long;
  bool open_now;
  List<dynamic> images;
  double nota;

  HospitalData(String n, String e, double lt, double lng, bool open, List<dynamic> imgs, double nt)
  {
    nome = n;
    endereco = e;
    lat = lt;
    long = lng;
    open_now = open;
    images = imgs;
    nota = nt;
  }
}