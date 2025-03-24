# Bil395_HW1

Bonus olan floating point ve üs alma (3^5 gibi) işlemlerini ekledim

kodları çalıştırmak için sırasıyla aşağıdaki commandları yazıp

$ flex calculator.l
$ yacc -d calculator.y
$ gcc lex.yy.c y.tab.c -o calculator -lfl
$ ./calculator
$ (3 + 5) ^ (2 - 1) / 4

>> result = 2

veya 
$ (4.5 + 3.2) * 2.0

>> result = 15.40000

şeklinde çalıştırıyoruz.

calculator.l dosyası:
    yylval değişkenini yacc' a göndermek için kullanıyorum
    atoi ve atof ile değerleri okuyorum

    gelen inputu PLUS MINUS vb ödev dosyasında yazan tokenlara ayırıyorum.

    [\t ] ifadesi ile boşluk yada tab değerlerini görmezden geliyorum.

    \n ifadesi gelirse de o işlemi bitiriyorum

    ödev belgesindekine ek olarak EXPO token i oluşturdum

    ayrıca int ve double işlemlerini yapabilmek için INTEGER ve DOUBLE tokenları oluşturdum. bunların
    type değerleri de sırasıyla integer ve double.

calculator.y dosyası:
    flag değişkeni hata durumunu kontrol etmek için var. eğer flag 0 değilse hata vardır o sebeple result değişkenine değer atanmaz. 

    yyerror fonksiyonu hata durumunda flag = 1 yapar

    %left PlUS gibi ifadelerle işlem önceliğini ayarlıyoruz.
    yukarıdan aşağıya öncelik artıyor, yan yana yazılanlar eşit öncelikli

    %token INTEGER vb. calculator.l den gelen tokenlar

    $$ sonuç değişkenini tutuyor

    $3 != 0 bu kontrol ile divide by zero işlemini de engellmiş oluyoruz

    Expression ya I_ArithmeticExpression yada D_ArithmeticExpression oluşturuyor. bunlar da ya integer işlemi yada double işlemi yapıyorlar.

hata yönetimi:
    Geçersiz girdi durumunda "Invalid expression" mesajını görüntüler ve flag değişkenini ayarlar. Bu, sonraki hesaplamaların yapılmasını engeller.