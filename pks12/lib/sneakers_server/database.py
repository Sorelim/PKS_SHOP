from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

# URL для асинхронного подключения к базе данных
DATABASE_URL = "postgresql+asyncpg://postgres:Alex-2022@localhost/pks"

# Создание асинхронного движка
engine = create_async_engine(DATABASE_URL, future=True)

# Создание асинхронной сессии
AsyncSessionLocal = sessionmaker(
    bind=engine,
    class_=AsyncSession,
    expire_on_commit=False,
)

# Базовая модель для ORM
Base = declarative_base()

# Функция для получения асинхронной сессии
async def get_db():
    async with AsyncSessionLocal() as db:
        yield db