# Final_Project_MVP

Приложение написано по MVP архитектуре, с юнит тестами (еще не в полной мере). CocoaPods необходим, чтобы установить библиотеку OCMock для тестирования.  

# Основной функционал
При работе с изображениями, возможны 4 действия: 
1) Узнать тэги изображения: отображается в таблицу вида тэг - точность.
2) Классифицировать изображение: аналогично тэгам.
3) Интеллектульная обрезка - мы отсылаем API изображение в base64 формате, а она отвечает прямоугольником, который представляет из себя наилучшею обрезку для фото. После обрезки, полученную фотографию можно сохранить в CoreData.
4) Цвета - позволяет узнать цвета переднего, заднего плана и самого изображения. Каждая ячейка в таблице окрашивается в свой цвет, при нажатии на конкретную ячейку - высвечивается HTML код цвета, родительский цвет и HTML код родительского цвета.

# Дополнительный функционал
Это дополнительная часть приложения(хотелось просто поразбираться в этом, поэтому она выполнена без архитектуры и тестов). Позволяет работать с камерой в режиме реального времени (происходит захват изображения с камеры и каждый раз, когда происхит обновление кадра в методе делегата отрисовываются фигуры на слое). Для распознования лиц, текста и QR-кодов используется библиотека GoogleMobileVision. На гитхаб бинарники библиотек не загружаются, т.к. их размер > 100Мб. Ссылка на загрузку:  https://yadi.sk/d/CSRdl370sZ6SGg
