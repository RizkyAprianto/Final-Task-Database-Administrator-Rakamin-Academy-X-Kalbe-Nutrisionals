select *from delivery;

insert into delivery( delivery_id, product_id, store_id, shipment_id ,sending_time ,delivered_time ,received_by  ) 
values (1,1,1,null,'2023-05-01 10:00','2023-05-01 13:30:','Dian Ayu');

insert into delivery( delivery_id, product_id, store_id, shipment_id ,sending_time ,delivered_time ,received_by  ) 
values 
(2,5,1,null,'2023-05-01 10:00','2023-05-01 13:30','Dian Ayu'),
(3,11,1,null,'2023-05-01 10:00','2023-05-01 13:30','Dian Ayu'),
(4,1,2,null,'2023-05-01 11:00','2023-05-01 13:00','Eriawan'),
(5,2,2,null,'2023-05-01 11:00','2023-05-01 13:00','Eriawan'),
(6,52,2,null,'2023-05-01 11:00','2023-05-01 13:00','Eriawan'),
(7,35,3,null,'2023-05-02 9:00','2023-05-02 12:00','Aji'),
(8,36,3,null,'2023-05-02 9:00','2023-05-02 12:00','Aji'),
(9,42,3,null,'2023-05-02 9:00','2023-05-02 12:00','Aji'),
(10,24,3,null,'2023-05-02 9:00','2023-05-02 12:00','Aji'),
(11,49,4,null,'2023-05-02 9:00','2023-05-02 14:00','Jamal'),
(12,52,4,null,'2023-05-02 9:00','2023-05-02 14:00','Jamal'),
(13,53,4,null,'2023-05-02 9:00','2023-05-02 14:00','Jamal');

select * from delivery;


alter table delivery add constraint fk_store foreign key (store_id) references app.store (store_id);

select * from delivery;

insert into delivery( delivery_id, product_id, store_id, shipment_id ,sending_time ,delivered_time ,received_by  ) 
values (14,4,1,null,'2023-05-03 09:00','2023-05-01 13:30:','Louis');


insert into delivery( delivery_id, product_id, store_id, shipment_id ,sending_time ,delivered_time ,received_by  ) 
values 
(15,15,2,null,'2023-05-13 09:00','2023-05-13 15:30:','Ryan'),
(16,23,2,null,'2023-05-14 09:30','2023-05-13 15:50:','Iqbal');
