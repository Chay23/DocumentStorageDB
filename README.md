# Зберігання службових документів

![ER diagram](ER_Diagram.png)

# Опис таблиць бази даних

## Автори

Таблиця "Автори" містить дані про авторів документів:
+ ідентифікаційний номер автора;
+ ім'я.

  |     |Authors     | 
  |-----|------------|
  | PK  | author_id  |
  |     | author_name|
  
## Категорії 

Таблиця "Категорії" поділяє журнали на категорії за кафедрами і містить такі поля: 
+ ідентифікаційний номер категорії журналу; 
+ назву журналу;
+ термін дії.

  |     |Categories     | 
  |-----|---------------|
  | PK  | caregory_id   |
  |     | category_name |
  |     | end_period    |
  
  ## Документи 
  
 Таблиця "Документи" містить дані про документи:
 + ідентифікаційний номер документа;
 + ім'я;
 + дата створення;
 + ідентифікаційний номер автора;
 + вид документа;
 + опис.
  
  |     |Documnets      | 
  |-----|---------------|
  | PK  | id            |
  |     | name          |
  |     | creation_date |
  | FK  | author_id     |
  | FK  | documnet_type |
  |     | description   |
  
  ## Документи в процесі
  
 Таблиця "Документи в процесі" містить інформацію про етапи обігу документів:
 + ідентифікаційний номер документа;
 + ідентифікаційний номер журналу;
 + особа, яка переглядає/підтверджує/відхиляє документ на даному етапі обігу документа; 
 + стан документа.
  
  |     |Documents_in_Process      | 
  |-----|--------------------------|
  | FK  | documnet_id              |
  | FK  | register_id              |
  |     | staff                    |
  | FK  | current_state            |
  
  ## Види документів 
  
 Таблиця "Типи документів" містить наступні поля:
 + ідентифікаційний номер виду документа;
 + назву виду.
  
  |     |Document_Types    | 
  |-----|------------------|
  | PK  | type_id          |
  |     | type_name        |
  
  ## Факультети
  
 Таблиця "Факультети" містить:
 + ідентифікаційний номер факультету;
 + назва факультету.
  
    
  |     |Faculties     | 
  |-----|--------------|
  | PK  | faculty_id   |
  |     | faculty_name |
  
## Журнали

Таблиця "Журнали" містить інформацію про всі журнали та пов'язані з ними документи і має такі поля:
+ ідентифікаційний номер журналу;
+ ідентифікаційний номер документу;
+ ідентифікаційний номер автора;
+ дату реєстрації;
+ ідентифікаційний номер стану;
+ ідентифікаційний номер факультету.

  |     |Register            | 
  |-----|--------------------|
  | FK  | register_id        |
  | FK  | document_id        |
  | FK  | document_author_id |
  |     | registration_date  |
  | FK  | document_state     |
  | FK  | faculty_id         |

## Стани

Таблиця "Стани" містить наступні дані:
+ ідентифікаційний номер стану;
+ ім'я стану.

  |     |States        | 
  |-----|--------------|
  | PK  | state_id     |
  |     | state_name   |
  
# SQL запити на прикладі даної бази даних.

+ ### Обрати всі документи які були погоджені. 

```
SELECT documents.name ,authors.author_name, registers.register_id,states.state_name
FROM registers JOIN documents ON documents.id = registers.document_id JOIN authors ON authors.author_id = documents.author_id JOIN states ON registers.document_state = states.state_id WHERE registers.document_state = 3;


```
#### Результат

| name | author_name | register_id |state_name |
|------|-------------|-------------|-----------|
| Заява на отримання соціальної стипендії | Дєєв Сергій Сергійович | 2 | Підтверджено |
| Заява на видачу дубліката залікової книжки | Зюбіна Анна Володимирівна | 1 | Підтверджено |
| Пояснювальна записка | Артюхов Роман Вячеславович | 5 | Підтверджено |
 
+ ### Обрати всі документи, вид яких - заява.

```
SELECT documents.name , documents.creation_date , document_types.type_name FROM documents
JOIN document_types on documents.document_type = document_types.type_id WHERE document_types.type_name = 'Заява';

```
#### Результат 

| name | creation_date | type_name |
|---|---|---|
| Заява на отримання соціальної стипендії | 2019-09-20 | Заява |
| Заява на видачу дубліката залікової книжки | 2019-09-20 | Заява |
| Заява на відрахування із числа студентів за власним бажанням | 2019-12-17 | Заява |

+ #### Вивести назви журналів і документів, які належать до факультету математики та інформатики.

```
SELECT categories.category_name,documents.name,faculties.faculty_name from registers JOIN categories
ON registers.register_id = categories.category_id JOIN documents ON registers.document_id = documents.id JOIN faculties ON registers.faculty_id = faculties.faculty_id WHERE faculties.faculty_id = 1;

```
#### Результат

| category_name | name | faculty_name |
| --- | --- | --- |
| Журнал для заяв студентів 3-го курсу кафедри інформаційних технологій | Заява на видачу дубліката залікової книжки | Факультет математики та інформатики |
| Журнал для заяв студентів 3-го курсу кафедри інформаційних технологій | Заява на відрахування із числа студентів за власним бажанням | Факультет математики та інформатики |
| Журнал для заяв студентів 3-го курсу кафедри диференціальних рівнянь і прикладної математики | Заява на отримання соціальної стипендії | Факультет математики та інформатики |

+ #### Вивести документи, дата створення яких пізніше 01 грудня 2019 року.

```
SELECT * FROM documents WHERE documents.creation_date > '2019-12-01';
```
#### Результат 

| id | name | creation_date | author_id | documnet_type | description |
| --- | --- | --- | --- | --- | --- |
| 3 | Заява на відрахування із числа студентів за власним бажанням | 2019-12-17 |5 | 1 | група ІПЗ-3 |
| 4 | Доповідна записка про відрядження | 2019-12-18 | 8 | 5 | - |
| 5 | Пояснювальна записка | 2019-12-18 | 1 | 2 | група А-13 |

# Створення тригеру.

```
DELIMITER |
CREATE TRIGGER trigger_update_register BEFORE UPDATE ON documents_in_process
  FOR EACH ROW
BEGIN
    UPDATE registers SET registers.document_state = NEW.current_state WHERE NEW.document_id = registers.register_id;
  END
|
DELIMITER ;

```
Даний тригер буде реагувати на обновлення в таблиці "Documents_in_Process" і апдейтити стан документа з одинаковим ідентифікаційним номером в таблиці "Registers".

### Демонстрація 

Таблиці "Documents_in_Process" і "Registers" до виконання UPDATE.

+ ### Documents_in_Process

| document_id | register_id | staff | current_state|
| --- | --- | --- | --- |
| 4 | 5 | Венгринович Андрій Антонович | `1` |

+ ### Registers 

| register_id | document_id | document_author_id | registration_date | documnet_state |
| --- | --- | --- | --- | --- |
| 4 | 5 | 8 | 2019-12-20 | `1` | 2 |

Таблиці "Documents_in_Process" і "Registers" після виконання UPDATE.

```
UPDATE documents_in_process
SET documents_in_process.current_state = 2
WHERE document_id = 4;

```
+ ### Documents_in_Process

| document_id | register_id | staff | current_state|
| --- | --- | --- | --- |
| 4 | 5 | Венгринович Андрій Антонович | `2` |

+ ### Registers 

| register_id | document_id | document_author_id | registration_date | documnet_state |
| --- | --- | --- | --- | --- |
| 4 | 5 | 8 | 2019-12-20 | `2` | 2 |

# View

Створюємо VIEW де вибираємо назви документів, дату створення і їх вид:

```
CREATE VIEW show_name_creat_date_type AS
SELECT documents.name , documents.creation_date , document_types.type_name FROM documents
JOIN document_types on documents.document_type = document_types.type_id;

```

Виберемо із VIEW всі документи вид яких - заява:

```
SELECT * FROM show_name_creat_date_type WHERE type_name = 'Заява';
```

| name | creation_date | type_name |
|---|---|---|
| Заява на отримання соціальної стипендії | 2019-09-20 | Заява |
| Заява на видачу дубліката залікової книжки | 2019-09-20 | Заява |
| Заява на відрахування із числа студентів за власним бажанням | 2019-12-17 | Заява |
