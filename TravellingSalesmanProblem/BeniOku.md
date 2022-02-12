# Genetik Algoritma ile Gezgin Satıcı Problemine Çözüm

# version 1.0.0
Bir ilaç temsilcisi Türkiye’deki her ili birer kez ziyaret ederek başladığı ile geri dönecektir. En kısa il sıralamasının genetik algoritma ile bulunması istenmektedir. Bu kapsamda genetik algoritma yapısının oluşturulmasında kullanılacak yaklaşım için seçim yöntemi, Sıralı seçim ve çaprazlama yöntemi ise Sıra çaprazlama (Order Crossover) ‘dır. Değişiklik Kayıt: 01.01.2016

Tasarımcı | Konu  |
---| --- |
Sercan SATICI | Genetik Algoritma ile Gezgin Satıcı Problemine Çözüm |


Method | Tanım  |
---| --- |
Genetik Algoritma ile Gezgin Satıcı Problemine Çözüm | 1- Arama uzayındaki tüm olası çözümlerden bir grup çözüm dizi olarak kodlanır. Burada genelde rassal işlem yapılır. Bir başlangıç popülasyonu oluşturulur. (P1, P2 ve P3 olmak üzere üç adet başlangıç popülasyonu oluşturulmuştur), 2- Her bir dizi için uygunluk değeri hesaplanır. Bulunan uygunluk değerleri dizilerin çözüm kalitesini gösterir.(Her populasyon için toplam mesafeler hesaplanmış uygunluk değeri olarak en az mesafeye sahip populasyon en uygunudur tanımı yapılmıştır), 3- Bir grup dizi belirli olasılık değerine göre rassal olarak seçilir. Seçilen diziler üzerinde çaprazlama ve mutasyon işlemleri gerçekleştirilir. (Olasılık değeri dizi uzunluğunun 3’te 1’i yani yaklaşık olarak 0.333 seçilmiştir. Çaprazlamanın yapılacağı diziler mesafenin en az olduğu yani en uygun iki popülasyondur ve Sıra Temelli Çaprazlama işlemi yapılmıştır), 4- Oluşan yeni populasyon eski populasyon ile yer değiştirir. (Sıra temelli çaprazlama ile çaprazlamanın yapıldığı iki populasyon P1,P2 sonucunda meydana gelen iki birey C1, C2 uygunluğu en düşük yani en yüksek mesafeye sahip iki popülasyon yerine yazılmıştır), 5- Durdurma ölçütü sağlanana dek yukarıdaki işlemlere devam edilir. (toplam mesafenin 55.000 km’ den az olması yeter  koşul olarak alınmıştır), 6- En uygun dizi çözüm olarak seçilir. |
Input |  "TravellingSalesman.m" "ilmesafe.xls" |
Output | Optimal yol (İller plaka numaraları ile temsil edilmiştir) |
