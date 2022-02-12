# Toonify-Gerçek resimden çizgi resim oluşturma

# version 1.0.0
Gerçek görüntüleri sanal/çizgi film görüntülerine dönüştürme projesidir. Algoritma, filtrelenmiş görüntünün iki aşamada birleştirilmesiyle sağlanır.. Değişiklik Kayıt: 01.06.2013

Tasarımcı | Konu  |
---| --- |
Sercan SATICI | Toonify-Gerçek resimden çizgi resim oluşturma |


Method | Tanım  |
---| --- |
Toonify-Gerçek resimden çizgi resim oluşturma | Giriş imgesi median filtreleme, kenar tesipti, kenar genişletme ve filtreleme ile elde edilen ilk görüntü ile, bilateral filtreleme, median filtreleme, renk nicemleme ve tekrar median filtreleme ile elde edilen ikinci görüntü birleştirilerek çıkış görüntüsü elde edilir.. |
Input |  "TransformedReality.m", "toonifys.bmp, toonifys2.bmp" |
Output | Sanal resim çıktısı |
Input |  "Toonify.m", "bfilter2.m", "toonifys.bmp, toonifys2.bmp"|
Output | Filtrelenmiş imgeler ve Sanal resim çıktısı |
