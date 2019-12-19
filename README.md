# Зберігання службових документів

![ER diagram](ER_diagram.png)

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

Таблиця "Категорії" містить: 
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

...Таблиця "Стани" містить наступні дані:
... + ідентифікаційний номер стану;
... + ім'я стану.

  |     |States        | 
  |-----|--------------|
  | PK  | state_id     |
  |     | state_name   |
  
# SQL запити на прикладі даної бази даних.

## Обрати

```
SELECT documents.name ,authors.author_name, documents_in_process.register_id,documents_in_process.current_state
FROM documents_in_process JOIN documents ON documents.id = documents_in_process.document_id JOIN authors ON authors.author_id = documents.author_id WHERE documents_in_process.current_state = 3;

```
