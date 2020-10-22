**Lilyum nedir?** \
\
Lilyum, içeriğinde çeşitli özelleştirmelerin bulunduğu bir openSUSE çatalamasıdır. \
OpenSUSE'ye kıyasla daha şık, daha kullanışlı ve daha hızlıdır. \
Kurulumu nispeten daha kolaydır, önceden yapılandırıldığı için kurulum sonrası fazla iş istemez. \

**Bu sayfadaki dosyalar neye yarar?** \
\
Bu sayfadaki dosyalar Lilyum'u Kiwi aracılığıyla sıfırdan derlemenizi sağlar.\
Derleme işlemi sisteminizin gücüne göre bir saat ila dört saat arasında gerçekleşebilir. \
Root, sistemin içeriğinde bulunan pek çok dosyayı barındırır. \
Config.xml, sistem hakkında pek çok veriyi ve paketi, Config.sh ise sistem derlenirken çalıştırılan komutları barındırır. 

**Nasıl derleyebilirim?** \
\
OpenSUSE sisteminize "python3-kiwi" paketini kurunuz. (Fedora ve CentOS için: https://software.opensuse.org/package/python-kiwi) \
Bu sayfaları dosyaları "Lilyum" isimli bir dizine ekleyin ve bu dizinin olduğu üst dizinde "cikti" isimli boş bir klasör daha oluşturun. \
Ardından şu komutu "Lilyum" ve "cikti" isimli dizinlerin olduğu dizinde çalıştırınız: \
"LANG=C sudo kiwi-ng --type iso system build --description lilyum --target-dir cikti" \
İşlem bittikten sonra "cikti" isimli dizinde bir ISO dosyası göreceksiniz. \
\
**Peki, kullanmak için illa ki derlemem mi gerekiyor?** \
\
Elbette ki gerekmiyor. Şuradan en son derlenmiş olan imaj dosyasını indirebilirsiniz:
https://sourceforge.net/projects/lilyum/files/latest/download
