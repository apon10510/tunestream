from fastapi import FastAPI ,Request
from pydantic import BaseModel
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
app = FastAPI()
DATABASE_URL = 'postgresql://postgres:apon017788@localhost:5433/fluttermusicapp'
engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit =  False , autoFlush = False , bind = engine)
db = SessionLocal()
class UserCreate(BaseModel):
    name:str
    email:str
    password:str

@app.post('/signup')
def signup_user(user:UserCreate):
    print(user.name)
    print(user.email)
    print(user.password)


    pass