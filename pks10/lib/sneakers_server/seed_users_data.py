import asyncio
import asyncpg

# Данные для добавления в таблицу users
users_data = [
    {"id": 1, "username": "user1", "password": "password1", "email": "user1@gmail.com"},
    {"id": 2, "username": "user2", "password": "password2", "email": "user2@gmail.com"},
    {"id": 3, "username": "user3", "password": "password3", "email": "user3@gmail.com"},
]

# Подключение к базе данных
DATABASE_URL = "postgresql://postgres:Alex-2022@localhost/pks"

async def seed_users_data():
    conn = await asyncpg.connect(DATABASE_URL)
    try:
        for user in users_data:
            await conn.execute(
                """
                INSERT INTO users (id, username, password, email)
                VALUES ($1, $2, $3, $4)
                ON CONFLICT (id) DO NOTHING
                """,
                user["id"],
                user["username"],
                user["password"],
                user["email"],
            )
        print("Данные пользователей успешно добавлены!")
    finally:
        await conn.close()

# Запуск скрипта
if __name__ == "__main__":
    asyncio.run(seed_users_data())