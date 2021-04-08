TITLE Lab-2 
;------------------------------------------------------------------------------
;ЛР  №2
;------------------------------------------------------------------------------
; Архітектура комп'ютера.
; Завдання:     Основи розробки і налагодження
; ВУЗ:          НТУУ "КПІ"
; Факультет:    ФІОТ
; Курс:         1
; Група:        ІТ-01
;------------------------------------------------------------------------------
; Автор:        Трусов Сергей,
;				Колесник Роман,
;				Бойко Дарья
; Дата:         10/03/2021
;-----------------I.ЗАГОЛОВОК ПРОГРАМИ-----------------------
IDEAL
MODEL SMALL
STACK 512
;-----------------II.МАКРОСИ----------------------------------------
                    ; Макрос для ініціалізації
MACRO M_Init		; Початок макросу 
mov	ax, @data		; ax <- @data
mov	ds, ax			; ds <- ax
mov	es, ax			; es <- ax
ENDM M_Init			; Кінець макросу

;--------------------III.ПОЧАТОК СЕГМЕНТУ ДАНИХ
    DATASEG

exCode db 0                                     ; Код завершення роботи застосунку

rect_line dw 3f30h,3f30h,3f36h,3f30h,3f30h  ; Рядок, який буде надрукований 
		  dw 3f30h,3f30h,3f30h,3f30h,3f30h
		  dw 3f30h,3f30h,3f30h,3f30h,3f30h
		  dw 3f30h,3f30h,3f30h,3f30h,3f30h


rect_line_length = $-rect_line                  ; Довжина одного рядка 

;----------------------VI. ПОЧАТОК СЕГМЕНТУ КОДУ-----------------
CODESEG

Start:	
M_Init

    mov dx, 2440                     ; Зміщення лівого верхньго кутка у координати (40; 15)
    mov cx, 10                      ; Лічильник кіл-сті ітерацій циклу, який буде друкувати рядки

loopStart:                          ; Мітка початку циклу
                                    ; Регістр сх використовується з преф. rep у movsb, тому спочатку потрібно його знач. зберігти в іншр регістрі 
    mov bx, cx                      ; Запис сх до bx
    mov ax, 0B800h                  ; Cегментна адресса відеопам'яті
    mov es, ax                      ; es <- ax

    mov di, dx                      ; di <- dx, початок виведення на екран
    mov si, offset rect_line        ; si <- rect_line
    mov cx, rect_line_length        ; Число байтів
    cld                             ; df встановл. напрям вперед
    rep movsb                       ; Пересил.
    mov cx, bx                      ; Команда rep movsb завершилась і знач. сх можно поверн. з bx
    add dx, 160                     ; Зміщ. наступного рядка
loop loopStart                      ; Цикл виконуватиметься доки ліч. не буде 0


Exit:
     mov ah, 04ch
     mov al, [exCode]               ; Отрим. коду виходу
     int 21h                        ; Виклик переривання 21h для того, щоб призупинити виконання і  дочекатись доки користувач натисне якусь клавішу

END Start