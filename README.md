# Корневой репозиторий ИИ-агента по анализу данных
<table>
<tr>
<td valign="middle"><b>Стек:</b></td>
<td valign="middle">

![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white)
![LangGraph](https://img.shields.io/badge/LangGraph-1C3C3C?style=flat&logo=langchain&logoColor=white)
![LangChain](https://img.shields.io/badge/LangChain-0B3D3B?style=flat&logo=chainlink&logoColor=white)
![FastAPI](https://img.shields.io/badge/FastAPI-009688?style=flat&logo=fastapi&logoColor=white)
![pandas](https://img.shields.io/badge/pandas-150458?style=flat&logo=pandas&logoColor=white)

</td>
</tr>

<tr>
<td valign="middle"><b>Механизмы:</b></td>
<td valign="middle">

![Human-in-the-Loop](https://img.shields.io/badge/Human--in--the--Loop-D32F2F?style=flat)
![Persistence](https://img.shields.io/badge/Persistence-F57C00?style=flat)
![Guardrails](https://img.shields.io/badge/Guardrails-1976D2?style=flat)
![LLM-as-a-Judge](https://img.shields.io/badge/LLM--as--a--Judge-8E24AA?style=flat)

</td>
</tr>
</table>

### [Backend](https://github.com/lowestate/ai_analyst_backend) | [Frontend](https://github.com/lowestate/ai_analyst_frontend)

Загружаете данные или заполняете креды к БД, пишете что хотите исследовать, агент визуализирует результат и дает понятное объяснение результатов.

Агент реализован с помощью supervisor-архитектуры: supervisor-агент маршрутизирует запрос на одного из сабагентов в зависимости от того, что хочет проанализировать пользователь. При этом в рамках одного чата можно пользоваться возможностями всех агентов и производить анализ всесторонне

### Работа с данными для анализа
- Данные получаются двумя вариантами (выбор при создании нового чата):
  1. Из файла (загружается файл)
  2. Из БД (предоставляются креды для подключения к БД). При запросе пользователем любого анализа сабагент формирует SQL запрос, который ему нужен для получения необходимых данных. Этот запрос может быть только SELECT'ом, а также он отправляется в чат, где пользователь может подтвердить / изменить / отклонить запрос
- Предобработка данных, анализ пропусков и дубликатов по результатам предобработки (автоматически при загрузке даннных)
- Чаты сохраняются между сессиями благодаря долгосрочной памяти агента, так что можно продолжить анализ по уже загруженными данным в любой момент
---

## Возможности агента

<table>
<tr>
<td valign="top" width="45%">

### Анализ данных

- Связи в данных:
  - корреляционная матрица
  - pairplot
  - дендрограмма признаков
  - подробная связь двух признаков

- Анализ признаков:
  - распределения
  - статистики
  - пропуски
  - аномалии

- Важность признаков

- Анализ трендов

</td>

<td width="10%"></td>

<td valign="top" width="45%">

### Финансовый анализ

- Cash Flow

- P&L

- Структура расходов

- ABC-анализ выручки

- Unit-экономика  
  ARPU / CAC

- Прогнозирование выручки

- Cohort & Retention Analysis

</td>
</tr>
</table>

По графикам чата можно построить дашборд с возможностью экспорта в .png / .pdf
