# Bil395_HW1

kodları çalıştırmak için sırasıyla aşağıdaki commandları yazıp

$ flex calculator.l
$ yacc -d calculator.y
$ gcc lex.yy.c y.tab.c -o calculator -lfl
$ ./calculator
$ (3 + 5) * (2 - 1) / 4

>> result = 2

şeklinde çalıştırıyoruz.

calculator.l dosyası:
    yylval değişkenini yacc' a göndermek için kullanıyorum

    [0-9]+ ile gelen çok basamaklı sayıyı string den int e çeviriyorum (atoi fonksiyonu ile)

    gelen inputu PLUS MINUS vb ödev dosyasında yazan tokenlara ayırıyorum.

    ayrıca [\t ] ifadesi ile boşluk yada tab değerlerini görmezden geliyorum.

    \n ifadesi gelirse de o işlemi bitiriyorum

calculator.y dosyası:
    flag değişkeni hata durumunu kontrol etmek için var. eğer flag 0 değilse hata vardır o sebeple result değişkenine değer atanmaz. 

    yyerror fonksiyonu hata durumunda flag = 1 yapar

    %left PlUS gibi ifadelerle işlem önceliğini ayarlıyoruz.
    yukarıdan aşağıya öncelik artıyor, yan yana yazılanlar eşit öncelikli

    %token NUMBER vb. calculator.l den gelen tokenlar

    $$ sonuç değişkenini tutuyor

    $3 != 0 bu kontrol ile divide by zero işlemini de engellmiş oluyoruz

