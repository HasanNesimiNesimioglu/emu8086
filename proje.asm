title sorular ve animasyonlar

;-------------------------------

.model small

;-------------------------------

org 100h

;-------veri tanimlamalari
.data
    
    ;kullanici adinin tutuldugu yer
    ad          db 6 dup(00)                                 
        
    ;--kullaniciya belirli mesajlar vermek icin tanimlamalar
    adisor      db "adiniz: $"
    ilkmesaj    db "hosgeldiniz, asagidaki sorulari cozunuz$" 
    tebrikler   db ", tebrikler tum sorulari cozdun$"        
    devam       db "devam etmek icin bir tusa bas$"          
    dogrucevap  db " dogru cevap siradaki soru$"
    yanliscevap db " cevap yanlis tekrar girin$"
    
    ;4 islem soru mesaj tanimlamlari 
    toplama db "3 + 6 = $"
    cikarma db "8 - 3 = $"
    carpma  db "1 * 7 = $"
    bolme   db "8 % 4 = $"
    
    ;sorularin cevaplarini karsilastirmak icin veriler
    toplamasonuc db 9
    cikarmasonuc db 5
    carpmasonuc  db 7
    bolmesonuc   db 2
    
    ;cursor konumunu kaydetmek icin tanimlanan veri
    cursorkonum db 0

    
    ;kod bolumu
.code

main proc
    
    lea si,ad       ;ad adresi aliniyor
    mov cx,6        ;6lik dongu icin tanimalama
 
    lea dx,adisor   ;mesaj icin adres bilgisi atamasi
    mov ah,09h      ;ah,09h ekrana mesaj yazdirmak icin
    int 21h         ;int 21h ile fonksiyon cagriliyor
    
    diziyeyaz:
    mov ah,01h      ;01h-int 21h ile basilan tus bilgisi
    int 21h 
    mov [si],al     ;basilan tus ASCII bilgisi al'den aliniyor
    inc si          ;ad degiskeninin yerlerine sirasiyla ataniyor
    loop diziyeyaz  ;donguyle tum karakterlerin ASCII bilgisi aliniyor
    
    call cursor

;hosgeldiniz,sorulari coz mesaji
         
    mov ah,09h     ;ah,09h degeri atiliyor
    lea dx,ilkmesaj;ilk mesaj adresi dx'e atiliyor
    int 21h        ;int 21h fonksiyonu cagiriliyor
    jmp toplama1


;cevap yanlis mesaji yazdirmak icin
cevapyanlis1:
    mov ah,09h
    lea dx,yanliscevap
    int 21h

;toplama islemi
toplama1:
    call cursor
    
    mov ah,09h          ;soru ekrana
    lea dx,toplama      ;yazdiriliyor
    int 21h

    mov ah,01h          ;kullanicinin verdigi
    int 21h             ;cevap aliniyor
    sub al,30h          ;alinan deger ascii oldugu icin
                        ;30 cikarilip alinan degere esitleniyor
    cmp toplamasonuc,al ;alinan deger karsilastiriliyor
    jne cevapyanlis1    ;cevap yanlis ise uyari etiketine gidilir
    
    ;sonuc dogru olursa ekrana dogru cevap mesaji yazdirilir.
    mov ah,09h
    lea dx,dogrucevap
    int 21h
    
    jmp cikarma1
    
;cevap yanlis mesaji yazdirmak icin
cevapyanlis2:
    mov ah,09h
    lea dx,yanliscevap
    int 21h

;cikarma islemi
cikarma1:
    call cursor

    mov ah,09h          ;soru ekrana
    lea dx,cikarma      ;yazdiriliyor
    int 21h

    mov ah,01h          ;kullanicinin verdigi
    int 21h             ;cevap aliniyor
    sub al,30h          ;alinan deger ascii oldugu icin
    cmp cikarmasonuc,al ;30 cikarilip alinan degere esitleniyor
    jne cevapyanlis2    ;cevap yanlis ise uyari etiketine gidilir
    
    ;sonuc dogru olursa ekrana dogru cevap mesaji yazdirilir.
    mov ah,09h
    lea dx,dogrucevap
    int 21h
    
    jmp carpma1
    

;cevap yanlis mesaji yazdirmak icin    
cevapyanlis3:
    mov ah,09h
    lea dx,yanliscevap
    int 21h

;carpma islemi
carpma1:
    call cursor
    
    mov ah,09h         ;soru ekrana
    lea dx,carpma      ;yazdiriliyor
    int 21h

    mov ah,01h         ;kullanicinin verdigi
    int 21h            ;cevap aliniyor
    sub al,30h         ;alinan deger ascii oldugu icin
    cmp carpmasonuc,al ;30 cikarilip alinan degere esitleniyor
    jne cevapyanlis3   ;cevap yanlis ise uyari etiketine gidilir
    
    ;sonuc dogru olursa ekrana dogru cevap mesaji yazdirilir.
    mov ah,09h
    lea dx,dogrucevap
    int 21h
    
    jmp bolme1
    
    
;cevap yanlis mesaji yazdirmak icin    
cevapyanlis4:
    mov ah,09h
    lea dx,yanliscevap
    int 21h

;bolme islemi
bolme1:
    call cursor
    
    mov ah,09h        ;soru ekrana
    lea dx,bolme      ;yazdiriliyor
    int 21h           

    mov ah,01h        ;kullanicinin verdigi
    int 21h           ;cevap aliniyor
    sub al,30h        ;alinan deger ascii oldugu icin
    cmp bolmesonuc,al ;30 cikarilip alinan degere esitleniyor
    jne cevapyanlis4  ;cevap yanlis ise uyari etiketine gidilir
    
    ;sonuc dogru olursa ekrana dogru cevap mesaji yazdirilir.
    mov ah,09h
    lea dx,dogrucevap
    int 21h
    
    
;ekrana adi yazdirma
    call cursor   
    
    mov cx,6    ;6 karakter yazilacagi icin 6'lik dongu
    lea si,ad   ;ad degiskeni baslangic adresi alinir
    bas:
    mov dl,[si]
    mov ah,02h  ;ah,02h ve int 21h ile 
    int 21h     ;ekrana karakter yazilir
    inc si      ;adres 1 arttilir diger karakteri yazdirmak icin
    loop bas    ;dongu 6 kez devam eder
    
    
;tebrikler mesaji    
    mov ah,09h
    lea dx,tebrikler
    int 21h
    
;tusa basin uyarisi
    call cursor
    
    lea dx,devam
    mov ah,09h  ;ekrana tusa basin mesaji yazdirilir.
    int 21h
    mov ah,00   ;uyarinin ekranda silinmemesi icin int16h ile
    int 16h     ;tus girdisi bekletmesi yapilir
    

    
;asagidaki kodlarda ekrana pixel ile gazi yazdiriliyor

    mov ah, 0   ;video modu 320x200
    mov al, 13h ;olarak ayarlaniyor
    int 10h

;G ust:

    mov cx, 30      ; sutun
    mov dx, 20      ; satir
    mov al, 14      ; sari renk    
u1: mov ah, 0ch     ; pixeli yerlestir
    int 10h    
    dec cx
    cmp cx, 10
    jae u1 
    
;G sol :
    mov cx, 10      ; sutun
    mov dx, 50      ; satir
    mov al, 14      ; sari
u3: mov ah, 0ch     ; pixeli yerlestir
    int 10h
    dec dx
    cmp dx, 20
    ja u3 
 
;G alt:
    mov cx, 30      ; sutun
    mov dx, 50      ; satir
    mov al, 14      ; white
u2: mov ah, 0ch     ; pixeli yerlestir
    int 10h
    dec cx
    cmp cx, 10
    ja u2
    
;G sag:
    mov cx, 30      ; sutun
    mov dx, 50      ; satir
    mov al, 14      ; white
u4: mov ah, 0ch     ; pixeli yerlestir
    int 10h    
    dec dx
    cmp dx, 35
    ja u4
         
;G orta:
    mov cx, 30      ; sutun
    mov dx, 35      ; satir
    mov al, 14      ; white
u5: mov ah, 0ch     ; pixeli yerlestir
    int 10h
    dec cx
    cmp cx, 15
    ja u5   
    
;A ust:
    mov cx, 60      ; sutun
    mov dx, 20      ; satir
    mov al, 12      ; kirmizi    
u6: mov ah, 0ch     ; pixeli yerlestir
    int 10h    
    dec cx
    cmp cx, 40
    jae u6

;A sol :
    mov cx, 40      ; sutun
    mov dx, 50      ; satir
    mov al, 12      ; kirmizi
u7: mov ah, 0ch     ; pixeli yerlestir
    int 10h
    dec dx
    cmp dx, 20
    ja u7
    
;A sag :
    mov cx, 60      ; sutun
    mov dx, 50      ; satir
    mov al, 12      ; kirmizi
u8: mov ah, 0ch     ; pixeli yerlestir
    int 10h
    dec dx
    cmp dx, 20
    ja u8

;A orta:
    mov cx, 60      ; sutun
    mov dx, 35      ; satir
    mov al, 12      ; kirmizi    
u9: mov ah, 0ch     ; pixeli yerlestir
    int 10h    
    dec cx
    cmp cx, 40
    jae u9
    
;Z ust:
    mov cx, 90      ; sutun
    mov dx, 20      ; satir
    mov al, 10      ; yesil    
u10:mov ah, 0ch     ; pixeli yerlestir
    int 10h    
    dec cx
    cmp cx, 70
    jae u10
    
;Z sag:
    mov cx, 90      ; sutun
    mov dx, 35      ; satir
    mov al, 10      ; yesil
u11:mov ah, 0ch     ; pixeli yerlestir
    int 10h
    dec dx
    cmp dx, 20
    ja u11    
    
;Z orta:
    mov cx, 90      ; sutun
    mov dx, 35      ; satir
    mov al, 10      ; yesil    
u12:mov ah, 0ch     ; pixeli yerlestir
    int 10h    
    dec cx
    cmp cx, 70
    jae u12
    
;Z sol:
    mov cx, 70      ; sutun
    mov dx, 50      ; satir
    mov al, 10      ; yesil
u13:mov ah, 0ch     ; pixeli yerlestir
    int 10h
    dec dx
    cmp dx, 35
    ja u13 
    
;Z alt:
    mov cx, 90      ; sutun
    mov dx, 50      ; satir
    mov al, 10      ; yesil    
u14:mov ah, 0ch     ; pixeli yerlestir
    int 10h    
    dec cx
    cmp cx, 70
    jae u14
    
;I alt:
    mov cx, 100     ; sutun
    mov dx, 50      ; satir
    mov al, 3       ; mavi
u15:mov ah, 0ch     ; pixeli yerlestir
    int 10h
    dec dx
    cmp dx, 30
    ja u15
    
   ;I nokta:
    mov cx, 100     ; sutun
    mov dx, 25      ; satir
    mov al, 3       ; mavi
u16:mov ah, 0ch     ; pixeli yerlestir
    int 10h
    dec dx
    cmp dx, 19
    ja u16
ret
main endp

;cursor son konum kaydi ve
;cursoru alt satira kaydirma
cursor proc 
mov ah,03h          
int 10h            
mov cursorkonum,dh;cursorun satir bilgisi kaydediliyor

inc cursorkonum   ;alt satira gecmek icin arttirma

mov dh,cursorkonum;cursorun satir ayarlamasi
mov dl,0000       ;cursorun sutun ayarlamasi
mov ah,02h        
int 10h           ;int 10h ile cursor konumu ayarlaniyor

ret               ;cagirilan yere geri donmek icin     
cursor endp

mov dh, 10
mov dl, 20
mov bh, 0
mov ah, 03h
int 10h 


end



