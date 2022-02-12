# Yüksek Verimli Video Kodlamaya (HEVC) Hızlı Hareket Tahmini Algoritmasının Uygulanması

# version 1.0.0
Hareket kestirimi video kodlama tekniklerinin en önemli aşamalarından biri olmakla birlikte kodlama kısmında en fazla karmaşıklık ve işlem yükünün olduğu kısımdır. En yeni video kodlama tekniği olarak bilinen HEVC’de hareket kestirimi aşamasında Test Zone (TZ) algoritması standart olarak sunulmuştur. TZ, Diamond arama stratejisi ile birlikte Sekiz noktalı ve İki noktalı arama tekniklerinin yanı sıra Raster aramasını barındıran bir arama tekniğidir. Arama aşamasında daha az noktanın incelenmesiyle veya düşük bit gösterimi temelli yaklaşımlar ile hareket kestirimi hızlandırılabilmekte olup yüksek oranda kalite sağlanması da amaçlanmaktadır. Implementasyon aşamasında HM referans yazılımında standart olarak sunulan TZ hareket kestirim algoritması (xPatternSearch()) yerine hızlı hareket kesitirimi algoritması (xPatternSearchTGCBPM()) uygulanmıştır. Değişiklik Kayıt: 01.06.2016

Tasarımcı | Konu  |
---| --- |
Sercan SATICI | Yüksek Verimli Video Kodlamaya (HEVC) Hızlı Hareket Tahmini Algoritmasının Uygulanması |


Method | Tanım  |
---| --- |
Yüksek Verimli Video Kodlamaya (HEVC) Hızlı Hareket Tahmini Algoritmasının Uygulanması | HEVC ile hareket kestirimi yazılım bloğunda standart olarak sunulan Test Bölgesi (TZ) algoritması yerine daha az arama noktasının tarandığı hızlı hareket kestirimi algoritması (TGCBPM) hayata geçirilmiştir.. |
Input |  BasketballPass_416x240_50.yuv, football_cif.yuv, mobile_cif.yuv, stefan_cif.yuv |
Output | HEVC kodlanmış video |
