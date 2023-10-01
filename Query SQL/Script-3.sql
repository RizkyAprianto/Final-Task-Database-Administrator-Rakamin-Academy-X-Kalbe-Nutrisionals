create table Product (
Product_ID INT not null,
Product_Name VARCHAR(255),
constraint Product_pkey primary key (Product_ID)
); 

create table Store (
Store_ID INT not null,
Store_Destination VARCHAR(255),
constraint Store_pkey primary key (Store_ID)
); 

create table Operator (
Operator_ID INT not null,
Operator_Name VARCHAR(255),
constraint Operator_pkey primary key (Operator_ID)
);

create table Truck(
Truck_ID INT not null,
Shipping_Vehicle VARCHAR(255),
No_Police VARCHAR(255),
constraint Truck_pkey primary key (Truck_ID)
);

create table Driver(
Driver_ID INT not null,
Shipping_Driver VARCHAR(255),
Shipping_CoDriver VARCHAR(255),
constraint Driver_pkey primary key (Driver_ID)
);

create table Delivery(
Delivery_ID INT not null,
Product_ID INT not null,
Store_ID INT not null,
Shipment_ID VARCHAR(255),
Sending_Time TIMESTAMP,
Delivered_Time TIMESTAMP,
Received_By VARCHAR(255),
constraint Delivery_pkey primary key (Delivery_ID),
constraint fk_Product foreign key(Product_ID) references
Product(Product_ID),
constraint fk_Store foreign key(Store_ID) references
Store(Store_ID)
);

create table Detail_Delivery(
Detail_Delivery_ID INT not null,
Delivery_ID INT not null,
Driver_ID INT not null,
Truck_ID INT not null,
Qty INT ,
Unit VARCHAR(255),
constraint Detail_pkey primary key (Detail_Delivery_ID),
constraint fk_Delivery foreign key(Delivery_ID) references
Delivery(Delivery_ID),
constraint fk_Driver foreign key(Driver_ID) references
Driver(Driver_ID),
constraint fk_Truck foreign key(Truck_ID) references
Truck(Truck_ID)
);