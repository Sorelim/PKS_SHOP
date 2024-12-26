from fastapi import FastAPI, Depends, HTTPException
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select
from sqlalchemy import delete, update
from database import get_db, engine, Base
from models import User, Sneaker, Cart, Favorite
from pydantic import BaseModel
from typing import List
import uvicorn
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

# Настройка CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Pydantic-модели для валидации данных
class SneakerCreate(BaseModel):
    name: str
    brand: str
    image_url: str
    price: float
    description: str

class UserCreate(BaseModel):
    username: str
    password: str
    email: str

class CartItem(BaseModel):
    user_id: int
    sneaker_id: int
    quantity: int

class FavoriteItem(BaseModel):
    user_id: int
    sneaker_id: int

# Создание таблиц в базе данных
@app.on_event("startup")
async def startup():
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)

# Маршрут для получения всех кроссовок
@app.get("/sneakers/", response_model=List[SneakerCreate])
async def get_sneakers(db: AsyncSession = Depends(get_db)):
    result = await db.execute(select(Sneaker))
    sneakers = result.scalars().all()
    return sneakers

# Маршрут для получения одной пары кроссовок по ID
@app.get("/sneakers/{sneaker_id}", response_model=SneakerCreate)
async def get_sneaker(sneaker_id: int, db: AsyncSession = Depends(get_db)):
    result = await db.execute(select(Sneaker).where(Sneaker.id == sneaker_id))
    sneaker = result.scalars().first()
    if not sneaker:
        raise HTTPException(status_code=404, detail="Кроссовки не найдены")
    return sneaker

# Маршрут для добавления новой пары кроссовок
@app.post("/sneakers/", response_model=SneakerCreate)
async def create_sneaker(sneaker: SneakerCreate, db: AsyncSession = Depends(get_db)):
    db_sneaker = Sneaker(**sneaker.dict())
    db.add(db_sneaker)
    await db.commit()
    await db.refresh(db_sneaker)
    return db_sneaker

# Маршрут для обновления информации о паре кроссовок
@app.put("/sneakers/{sneaker_id}", response_model=SneakerCreate)
async def update_sneaker(sneaker_id: int, sneaker: SneakerCreate, db: AsyncSession = Depends(get_db)):
    result = await db.execute(select(Sneaker).where(Sneaker.id == sneaker_id))
    db_sneaker = result.scalars().first()
    if not db_sneaker:
        raise HTTPException(status_code=404, detail="Кроссовки не найдены")
    for key, value in sneaker.dict().items():
        setattr(db_sneaker, key, value)
    await db.commit()
    await db.refresh(db_sneaker)
    return db_sneaker

# Маршрут для удаления пары кроссовок
@app.delete("/sneakers/{sneaker_id}")
async def delete_sneaker(sneaker_id: int, db: AsyncSession = Depends(get_db)):
    result = await db.execute(select(Sneaker).where(Sneaker.id == sneaker_id))
    db_sneaker = result.scalars().first()
    if not db_sneaker:
        raise HTTPException(status_code=404, detail="Кроссовки не найдены")
    await db.delete(db_sneaker)
    await db.commit()
    return {"message": "Кроссовки удалены"}

# Маршрут для получения корзины пользователя
@app.get("/cart/{user_id}", response_model=List[CartItem])
async def get_cart(user_id: int, db: AsyncSession = Depends(get_db)):
    result = await db.execute(select(Cart).where(Cart.user_id == user_id))
    cart_items = result.scalars().all()
    return cart_items

# Маршрут для добавления товара в корзину
@app.post("/cart/", response_model=CartItem)
async def add_to_cart(cart_item: CartItem, db: AsyncSession = Depends(get_db)):
    db_cart_item = Cart(**cart_item.dict())
    db.add(db_cart_item)
    await db.commit()
    await db.refresh(db_cart_item)
    return db_cart_item

# Маршрут для удаления товара из корзины
@app.delete("/cart/{cart_id}")
async def remove_from_cart(cart_id: int, db: AsyncSession = Depends(get_db)):
    result = await db.execute(select(Cart).where(Cart.id == cart_id))
    db_cart_item = result.scalars().first()
    if not db_cart_item:
        raise HTTPException(status_code=404, detail="Товар в корзине не найден")
    await db.delete(db_cart_item)
    await db.commit()
    return {"message": "Товар удален из корзины"}

# Маршрут для получения избранного пользователя
@app.get("/favorites/{user_id}", response_model=List[FavoriteItem])
async def get_favorites(user_id: int, db: AsyncSession = Depends(get_db)):
    result = await db.execute(select(Favorite).where(Favorite.user_id == user_id))
    favorite_items = result.scalars().all()
    return favorite_items

# Маршрут для добавления товара в избранное
@app.post("/favorites/", response_model=FavoriteItem)
async def add_to_favorites(favorite_item: FavoriteItem, db: AsyncSession = Depends(get_db)):
    db_favorite_item = Favorite(**favorite_item.dict())
    db.add(db_favorite_item)
    await db.commit()
    await db.refresh(db_favorite_item)
    return db_favorite_item

# Маршрут для удаления товара из избранного
@app.delete("/favorites/{favorite_id}")
async def remove_from_favorites(favorite_id: int, db: AsyncSession = Depends(get_db)):
    result = await db.execute(select(Favorite).where(Favorite.id == favorite_id))
    db_favorite_item = result.scalars().first()
    if not db_favorite_item:
        raise HTTPException(status_code=404, detail="Товар в избранном не найден")
    await db.delete(db_favorite_item)
    await db.commit()
    return {"message": "Товар удален из избранного"}

# Запуск сервера
if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)