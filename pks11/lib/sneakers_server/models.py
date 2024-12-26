from sqlalchemy import Column, Integer, String, Float, Text, DateTime, ForeignKey
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from database import Base

# Модель для пользователей
class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    username = Column(String(50), unique=True, nullable=False)
    password = Column(String(255), nullable=False)
    email = Column(String(100), unique=True, nullable=False)
    created_at = Column(DateTime(timezone=True), server_default=func.now())

# Модель для кроссовок
class Sneaker(Base):
    __tablename__ = "sneakers"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(100), nullable=False)
    brand = Column(String(50), nullable=False)
    image_url = Column(Text, nullable=False)
    price = Column(Float, nullable=False)
    description = Column(Text)
    created_at = Column(DateTime(timezone=True), server_default=func.now())

# Модель для корзины
class Cart(Base):
    __tablename__ = "cart"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    sneaker_id = Column(Integer, ForeignKey("sneakers.id"), nullable=False)
    quantity = Column(Integer, default=1)
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    user = relationship("User", backref="cart_items")
    sneaker = relationship("Sneaker", backref="cart_items")

# Модель для избранного
class Favorite(Base):
    __tablename__ = "favorites"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    sneaker_id = Column(Integer, ForeignKey("sneakers.id"), nullable=False)
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    user = relationship("User", backref="favorite_items")
    sneaker = relationship("Sneaker", backref="favorite_items")