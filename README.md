# case
Bu proje, yalnızca belirli karakterlerden oluşan 8 haneli promosyon kodları üretmek ve bu kodların doğruluğunu algoritmik olarak kontrol etmek amacıyla geliştirilmiştir. Kodlar sistematik olarak oluşturulur ve son karakter, doğrulama için bir kontrol karakteridir.

1. generate_codes
  Amaç: Rastgele ama kontrol karakteri içeren geçerli promo kodlar üretir.
Algoritma Özeti:
  Kodda kullanılacak karakterler ACDEFGHKLMNPRTXYZ234579 setinden seçilir.
  7 karakterlik bir kod gövdesi oluşturulur.
  Her karakterin listedeki sırası ve pozisyonuna özel bir ağırlık değeriyle çarpılarak toplanır (3, 5, 7, ..., 17).
  Bu toplam değer (HashSeed), 23 karakterlik havuza mod alarak indirgenir.
  Bu değere karşılık gelen karakter, kontrol karakteri olarak sona eklenir.
  Toplamda 8 haneli bir promo kod elde edilir.
  Bu işlem istenilen sayıda tekrar edilerek çoklu kod üretilebilir.

2. check_code
  Amaç: Verilen bir promo kodunun geçerli olup olmadığını kontrol eder.
Algoritma Özeti:
  Kodun uzunluğu 8 karakter mi kontrol edilir.
  İlk 7 karakterin listedeki sıraları bulunur.
  Aynı ağırlıklı çarpım algoritması uygulanarak HashSeed değeri hesaplanır.
  Bu değerden kontrol karakteri yeniden üretilir.
  Koddaki 8. karakter ile bu kontrol karakteri karşılaştırılır.
  Eğer uyuşuyorsa kod geçerlidir, değilse geçersizdir.

Sp'leri oluşturduktan sonra aşağıdaki komutları kullanarak oluşan kodların içinden isterseniz örnek kod olarak koyduğum "3TC2GDY4" değerinin yerine doğru kodlardan birini yazarak test edebilirsiniz.

EXEC generate_codes

Declare @valid int
EXEC check_code '3TC2GDY4', @valid OUTPUT

Select @valid
