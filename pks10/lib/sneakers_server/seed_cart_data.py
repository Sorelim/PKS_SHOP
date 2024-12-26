import asyncio
import asyncpg

# Данные для добавления в таблицу cart
cart_data = [
    {"user_id": 1, "sneaker_id": 1, "quantity": 2},
    {"user_id": 1, "sneaker_id": 2, "quantity": 1},
    {"user_id": 2, "sneaker_id": 3, "quantity": 3},
    {"user_id": 3, "sneaker_id": 4, "quantity": 1},
]

# Подключение к базе данных
DATABASE_URL = "postgresql://postgres:Alex-2022@localhost/pks"

async def seed_cart_data():
    conn = await asyncpg.connect(DATABASE_URL)
    try:
        for item in cart_data:
            await conn.execute(
                """
                INSERT INTO cart (user_id, sneaker_id, quantity)
                VALUES ($1, $2, $3)
                """,
                item["user_id"],
                item["sneaker_id"],
                item["quantity"],
            )
        print("Данные в корзину успешно добавлены!")
    finally:
        await conn.close()

# Запуск скрипта
if __name__ == "__main__":
    asyncio.run(seed_cart_data())