import asyncio
import asyncpg

# Данные о кроссовках
sneakers_data = [
    {
        "name": "Зимние кроссовки New Balance",
        "brand": "New Balance",
        "image_url": "https://static.street-beat.ru/upload/resize_cache/iblock/a52/500_500_1/uuo0c23wiu8p22syk4qgo5e8hbx398ju.jpg",
        "price": 100.0,
        "description": "Зимние кроссовки New Balance",
    },
    {
        "name": "Зимние кроссовки PUMA",
        "brand": "Puma",
        "image_url": "https://static.street-beat.ru/upload/resize_cache/iblock/ba4/500_500_1/tc9l4qtb6ad2gss6o2pwlnrtai4tkna0.jpg",
        "price": 200.0,
        "description": "Зимние кроссовки PUMA",
    },
    {
        "name": "Зимние кроссовки adidas Premium",
        "brand": "Adidas",
        "image_url": "https://static.street-beat.ru/upload/resize_cache/iblock/89b/500_500_1/nhppkycred83o6dq3oijkt83gp8mpmgr.JPG",
        "price": 150.0,
        "description": "Зимние кроссовки adidas Premium",
    },
    {
        "name": "Зимние кроссовки Nike",
        "brand": "Nike",
        "image_url": "https://static.street-beat.ru/upload/resize_cache/iblock/20b/500_500_1/7f7tqlzv70r7gi15k40arivq2xkw4090.jpg",
        "price": 180.0,
        "description": "Зимние кроссовки Nike",
    },
    {
        "name": "Зимние кроссовки PUMA Premium",
        "brand": "Puma",
        "image_url": "https://static.street-beat.ru/upload/resize_cache/iblock/668/500_500_1/8nr384qzm1b24nhlvah4c6ul9bvmk4uk.jpg",
        "price": 90.0,
        "description": "Зимние кроссовки PUMA Premium",
    },
    {
        "name": "Зимние кроссовки adidas Premium",
        "brand": "Adidas",
        "image_url": "https://static.street-beat.ru/upload/resize_cache/iblock/4cd/500_500_1/tse7krujnklhk0v8ln4dlnjx8kab27so.jpg",
        "price": 110.0,
        "description": "Зимние кроссовки adidas Premium",
    },
    {
        "name": "Зимние кроссовки New Balance Premier",
        "brand": "New Balance",
        "image_url": "https://static.street-beat.ru/upload/resize_cache/iblock/b3e/500_500_1/ljt5zjoesb0aq4iybw1ti1pc822cx64z.jpg",
        "price": 200.0,
        "description": "Зимние кроссовки New Balance Premier",
    },
    {
        "name": "Зимние кроссовки Nike Premier",
        "brand": "Nike",
        "image_url": "https://static.street-beat.ru/upload/resize_cache/iblock/74f/500_500_1/2oozrxd80bjznamh6wvggxz0yk3tarpp.JPG",
        "price": 175.0,
        "description": "Зимние кроссовки Nike Premier",
    },
    {
        "name": "Зимние кроссовки adidas Premier",
        "brand": "Adidas",
        "image_url": "https://static.street-beat.ru/upload/resize_cache/iblock/13f/500_500_1/f10kxsdpmoehcv00zyy1ss0xjq08ijuc.jpg",
        "price": 80.0,
        "description": "Зимние кроссовки adidas Premier",
    },
    {
        "name": "Зимние кроссовки Reebok Premier",
        "brand": "Reebok",
        "image_url": "https://static.street-beat.ru/upload/resize_cache/iblock/11b/500_500_1/31vryxv9eabmqn70octq1ozbp49vfd8m.jpg",
        "price": 70.0,
        "description": "Зимние кроссовки Reebok Premier",
    },
]

# Подключение к базе данных
DATABASE_URL = "postgresql://postgres:Alex-2022@localhost/pks"

async def seed_data():
    conn = await asyncpg.connect(DATABASE_URL)
    try:
        for sneaker in sneakers_data:
            await conn.execute(
                """
                INSERT INTO sneakers (name, brand, image_url, price, description)
                VALUES ($1, $2, $3, $4, $5)
                """,
                sneaker["name"],
                sneaker["brand"],
                sneaker["image_url"],
                sneaker["price"],
                sneaker["description"],
            )
        print("Данные о кроссовках успешно добавлены в базу данных!")
    finally:
        await conn.close()

# Запуск скрипта
if __name__ == "__main__":
    asyncio.run(seed_data())