
import os, random
from faker import Faker
import pandas as pd
import numpy as np
fake=Faker("en_IN")
random.seed(42); np.random.seed(42)
out="../data/generated"; os.makedirs(out,exist_ok=True)

cats=["Electronics","Fashion","Home","Books","Sports","Beauty","Grocery","Toys","Furniture","Office"]
pd.DataFrame({"category_id":range(1,len(cats)+1),"category_name":cats}).to_csv(f"{out}/categories.csv",index=False)

cust=[]
for i in range(1,1001):
    cust.append([i,fake.first_name(),fake.last_name(),random.choice(["Male","Female"]),random.randint(18,65),fake.city(),fake.state(),"India",fake.date_between("-4y","today")])
pd.DataFrame(cust,columns=["customer_id","first_name","last_name","gender","age","city","state","country","join_date"]).to_csv(f"{out}/customers.csv",index=False)

wh=[]
for i,c in enumerate(["Bengaluru","Mumbai","Delhi","Hyderabad","Chennai"],1):
    wh.append([i,f"WH-{i}",c,c])
pd.DataFrame(wh,columns=["warehouse_id","warehouse_name","city","state"]).to_csv(f"{out}/warehouses.csv",index=False)

pro=[]
for i in range(1,201):
    cp=random.randint(100,5000); sp=round(cp*random.uniform(1.1,1.6),2)
    pro.append([i,random.randint(1,10),f"Product {i}",f"Brand {random.randint(1,20)}",cp,sp])
pd.DataFrame(pro,columns=["product_id","category_id","product_name","brand","cost_price","selling_price"]).to_csv(f"{out}/products.csv",index=False)

inv=[]
iid=1
for w in range(1,6):
    for p in range(1,201):
        inv.append([iid,w,p,random.randint(20,500),50]); iid+=1
pd.DataFrame(inv,columns=["inventory_id","warehouse_id","product_id","stock_quantity","reorder_level"]).to_csv(f"{out}/inventory.csv",index=False)

pay=[]; ship=[]; orders=[]; items=[]; rets=[]
methods=["UPI","Credit Card","Debit Card","COD","Wallet"]
partners=["Delhivery","Blue Dart","Ekart","DTDC"]
for i in range(1,5001):
    pay.append([i,random.choice(methods),"Paid"])
    ship.append([i,random.randint(1,5),random.choice(partners),random.randint(40,300),random.randint(1,7),"Delivered"])
    orders.append([i,random.randint(1,1000),i,i,fake.date_between("-2y","today")])
oi=1
for o in range(1,5001):
    for _ in range(random.randint(1,3)):
        pid=random.randint(1,200)
        prod=pro[pid-1]
        qty=random.randint(1,4)
        up=prod[5]; disc=round(random.uniform(0,20),2)
        sales=round(up*qty-disc,2)
        profit=round((up-prod[4])*qty-disc,2)
        items.append([oi,o,pid,qty,up,disc,sales,profit])
        if random.random()<0.1:
            rets.append([len(rets)+1,oi,"Damaged",fake.date_between("-1y","today"),sales])
        oi+=1
pd.DataFrame(pay,columns=["payment_id","payment_method","payment_status"]).to_csv(f"{out}/payments.csv",index=False)
pd.DataFrame(ship,columns=["shipping_id","warehouse_id","shipping_partner","shipping_cost","delivery_days","delivery_status"]).to_csv(f"{out}/shipping.csv",index=False)
pd.DataFrame(orders,columns=["order_id","customer_id","payment_id","shipping_id","order_date"]).to_csv(f"{out}/orders.csv",index=False)
pd.DataFrame(items,columns=["order_item_id","order_id","product_id","quantity","unit_price","discount","sales","profit"]).to_csv(f"{out}/order_items.csv",index=False)
pd.DataFrame(rets,columns=["return_id","order_item_id","return_reason","return_date","refund_amount"]).to_csv(f"{out}/returns.csv",index=False)
print("Done")
