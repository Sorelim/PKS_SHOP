from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import List
import uvicorn
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class Sneaker(BaseModel):
    id: int
    name: str
    price: float
    description: str
    image_url: str

sneakers_db = [
    Sneaker(
        id=1,
        name='Мужские кроссовки New Balance 2002R',
        description='Модель New Balance 2002R доказывает, что «классика» может быть удобной. Верх пары изготовлен из сетчатого текстиля и кожи. Силуэт вдохновлен беговыми кроссовками 2000-х годов. Промежуточная подошва ABZORB и специальная амортизационная вставка на пятке ABZORB SBS создают особый комфорт, смягчая каждый шаг. Подошва Stability Web и N-ergy обеспечивают поддержку свода и отвечают за уверенное сцепление с поверхностью. Настоящая ретро-эстетика, которую можно носить каждый день.',
        image_url='https://static.street-beat.ru/upload/resize_cache/iblock/a52/500_500_1/uuo0c23wiu8p22syk4qgo5e8hbx398ju.jpg',
        price=100.0,
    ),
    Sneaker(
        id=2,
        name='Кроссовки PUMA Palermo Leather',
        description='Кроссовки PUMA Palermo Leather дебютировали в 80-х годах, став частью дресс-кода британских болельщиков. Верх модели имеет T-образную конструкцию, дополнен прямой шнуровкой и вставками из натуральной замши для большей мягкости и комфорта. Резиновая подошва с протектором и точкой стабилизации создает надежное сцепление с поверхностью.',
        image_url='https://static.street-beat.ru/upload/resize_cache/iblock/ba4/500_500_1/tc9l4qtb6ad2gss6o2pwlnrtai4tkna0.jpg',
        price=200.0,
    ),
    Sneaker(
        id=3,
        name='Кроссовки adidas Ozelia',
        description='Смелый силуэт кроссовок adidas Ozelia, вдохновленный бунтарскими 90-ми, идеально вписывается в современный гардероб. Верх пары создан из текстиля и искусственной кожи. Материал хорошо облегает стопы и пропускает воздух. Шнуровка с разноформатными люверсами обеспечивает плотную посадку. Технология adiPRENE® отвечает за амортизацию, активно поглощая ударные нагрузки и придавая каждому шагу особый комфорт.',
        image_url='https://static.street-beat.ru/upload/resize_cache/iblock/89b/500_500_1/nhppkycred83o6dq3oijkt83gp8mpmgr.JPG',
        price=150.0,
    ),
    Sneaker(
        id=4,
        name='Мужские кроссовки Nike Full Force Lo Cob',
        description='Кроссовки Nike Full Force Lo Cob отсылают нас к классической модели AF1 с добавлением стиля 80-х и ретро-отстрочкой, которая делает пару актуальной во все времена. Верх модели выполнен из сочетания натуральной и искусственной кожи. Перфорированный мысок создает дополнительную циркуляцию воздуха. Промежуточная подошва из пеноматериала обеспечивает мягкость и отзывчивость каждого шага. Подметка из резины отвечает за надежное сцепление на любой поверхности.',
        image_url='https://static.street-beat.ru/upload/resize_cache/iblock/20b/500_500_1/7f7tqlzv70r7gi15k40arivq2xkw4090.jpg',
        price=180.0,
    ),
    Sneaker(
        id=5,
        name='Кроссовки PUMA CA Pro Mid',
        description='Завышенный силуэт и лаконичный черный оттенок — не единственная причина заполучить пару PUMA CA Pro Mid в свой гардероб. Верх кроссовок изготовлен из натуральной и искусственной кожи, что повышает износостойкость модели, но сохраняет их подвижность и мягкость. Высокий борт дополнен шнуровкой с еще одним отверстием для более плотной посадки. Минималистичный дизайн в сочетании с акцентным золотым логотипом отлично смотрится, подходит к любому стилю и позволяет подбирать множество разных образов.',
        image_url='https://static.street-beat.ru/upload/resize_cache/iblock/668/500_500_1/8nr384qzm1b24nhlvah4c6ul9bvmk4uk.jpg',
        price=90.0,
    ),
    Sneaker(
        id=6,
        name='Кроссовки adidas Samba',
        description='Футбольная эстетика плотно вошла в уличный стритстайл. Это доказывают кроссовки с T-образным силуэтом adidas Samba. Пара создана из натуральной кожи. Ее легко интегрировать в разнообразные аутфиты. Модель дополнена замшевым мыском и подошвой «gumsole», популярность которой не уменьшается с каждым годом. Шнуровка с дополнительными отверстиями отвечает за комфортную посадку по стопе. Резиновая подметка с приводной точкой в стиле архивных футбольных моделей и цепкий протектор создают уверенность в каждом шаге.',
        image_url='https://static.street-beat.ru/upload/resize_cache/iblock/4cd/500_500_1/tse7krujnklhk0v8ln4dlnjx8kab27so.jpg',
        price=110.0,
    ),
    Sneaker(
        id=7,
        name='Мужские кроссовки New Balance 327',
        description='Культовый силуэт кроссовок New Balance 327, вдохновленный 1970-ми, с добавлением современных деталей в виде акцентного логотипа N на боковой стороне пары отлично смотрится с любым аутфитом. Текстильный верх с замшевыми вставками отвечает за воздухопроницаемость. Подошва в виде песочных часов обеспечивает усиленную амортизацию, а ярко выраженные протекторы — надежное сцепление с любой поверхностью.',
        image_url='https://static.street-beat.ru/upload/resize_cache/iblock/b3e/500_500_1/ljt5zjoesb0aq4iybw1ti1pc822cx64z.jpg',
        price=200.0,
    ),
    Sneaker(
        id=8,
        name='Мужские кроссовки Nike Air Max 270',
        description='В мужских кроссовках Nike Air Max 270 впервые была использована вставка Max Air, разработанная дизайнерами Nike Sportswear, и они обеспечивают легкость и амортизацию при каждом шаге. Обновленная модель обеспечивает современный уровень комфорта, а увеличенный верх язычка и ретро-логотип на язычке напоминает об оригинальной модели Air Max 180 1991 года.',
        image_url='https://static.street-beat.ru/upload/resize_cache/iblock/74f/500_500_1/2oozrxd80bjznamh6wvggxz0yk3tarpp.JPG',
        price=175.0,
    ),
    Sneaker(
        id=9,
        name='Кроссовки adidas Ozweego',
        description='Мужские кроссовки Ozweego от adidas представляют стиль конца 90-х — начала 2000-х в новом ключе, объединяя ретро-детали с футуристическим дизайном. Модель выполнена из кожи и замши. Специальные вставки поддерживают переднюю часть стопы и пятку. Кроссовки ощущаются невероятно комфортно в течение всего дня. Вставка из сверхупругого материала Adiprene+ в передней части стопы обеспечивает мягкость шага и увеличивает силу отталкивания, а вставка в пяточной части обеспечит превосходную амортизацию при ударных нагрузках.',
        image_url='https://static.street-beat.ru/upload/resize_cache/iblock/13f/500_500_1/f10kxsdpmoehcv00zyy1ss0xjq08ijuc.jpg',
        price=80.0,
    ),
    Sneaker(
        id=10,
        name='Мужские кроссовки Reebok Premier Road Plus VI',
        description='Модель Reebok Premier Road Plus VI, вдохновленная беговыми кроссовками 2009 года, возвращается в городские аутфиты в светлом бежевом оттенке. Текстильный верх со вставками из искусственной кожи хорошо пропускает воздух и позволяет носить пару каждый день. Конструкция подошвы с дополнительной амортизацией DMX поглощает удары и смягчает нагрузку на суставы. Изогнутую форму подошвы дополняют цепкие протекторы, которые минимизируют скольжение.',
        image_url='https://static.street-beat.ru/upload/resize_cache/iblock/11b/500_500_1/31vryxv9eabmqn70octq1ozbp49vfd8m.jpg',
        price=70.0,
    ),
]

favorites_db = []

@app.get("/")
async def root():
    return {"message": "Sneakers API работает"}

@app.get("/sneakers/", response_model=List[Sneaker])
async def get_sneakers():
    return sneakers_db

@app.get("/sneakers/{sneaker_id}", response_model=Sneaker)
async def get_sneaker(sneaker_id: int):
    sneaker = next((s for s in sneakers_db if s.id == sneaker_id), None)
    if not sneaker:
        raise HTTPException(status_code=404, detail="Обувь не найдена")
    return sneaker

@app.get("/favorites/", response_model=List[Sneaker])
async def get_favorites():
    return favorites_db

@app.post("/favorites/{sneaker_id}")
async def add_to_favorites(sneaker_id: int):
    sneaker = next((s for s in sneakers_db if s.id == sneaker_id), None)
    if not sneaker:
        raise HTTPException(status_code=404, detail="Кроссовки не найдены")
    if sneaker not in favorites_db:
        favorites_db.append(sneaker)
    return {"message": "Добавлено в избранное"}

@app.delete("/favorites/{sneaker_id}")
async def remove_from_favorites(sneaker_id: int):
    favorites_db[:] = [s for s in favorites_db if s.id != sneaker_id]
    return {"message": "Удалено из избранного"}

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)