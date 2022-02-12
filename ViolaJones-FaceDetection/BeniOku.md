# Viola-Jones ile Yüz Tespiti

# version 1.0.0
Çoğu yüzde, gözlerin üst kısmında koyu bir bölge bulunurken, burun ve elmacık kemikleri daha parlak görünür. Bu özellikleri gören algoritma bunun bir yüz olduğuna karar verir. Özellik tespiti için dikdörtgen doğrusal filtreler kullanılır. Özellikleri hızlı bir şekilde değerlendirmek için integral görüntüler kullanır.. Değişiklik Kayıt: 01.01.2014

Tasarımcı | Konu  |
---| --- |
Sercan SATICI | Viola-Jones ile Yüz Tespiti |


Method | Tanım  |
---| --- |
Viola-Jones ile Yüz Tespiti | Gerçek zamanlı nesne tespiti amacıyla geliştirilmiş bu yöntemde, eğitim aşaması yavaş, tespit aşaması ise hızlıdır. Sınııflandırma görevi için yüz hatlarını içerene resimden tespit edilmek istenen yüzler  alınır. Daha sonra kırpma işlemiyle yüzün maskesi oluşturulur. Eğitim aşamasında yaklaşık 5000 yüz ile maskelemenin gerçekleştirildiği Viola-Jones methodunda proje kapsamında iki adet yüz prototipine yer verilmiştir. Bu yüz prototipleri maskenin siyah olduğu yerdeki piksellerle resimde bu piksellerin aynı konumunda olan pikseller -1 ile maskenin beyaz olduğu yerlerdeki piksellerle aynı konumdaki pikseller +1 ile çapılarak resmin bir eşik değeri bulunur. Bu bulunan eşik değere sahip maske ile yüz resmi mantıksal işlem komutlarından And işlemine tabi tutulur. Oluşan resim orijinal resim üzerinde gezdirilerek resim üzerinde yüz olan yerleri tespit eder. |
Input |  "ViolaJones.m", "testimage.JPG" |
Output | Yüz tespiti yapılmış imge |
