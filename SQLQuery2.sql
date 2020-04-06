alter table Orders
add foreign key (ProductId) references Products(Pid)

alter table Orders
add foreign key (CustomerCNP) references Customers(CCNP)

alter table Products
add foreign key (DogId) references Dogs(Did)

alter table Dogs
add foreign key (OwnerCNP) references Owners(OCNP)

alter table Dogs
add foreign key (DoctorCNP) references Doctors(DCNP)

alter table Dogs
add foreign key (BreedId) references Breeds(Bid) 

alter table Eat
add foreign key (DogId) references Dogs(Did)

alter table Eat
add foreign key (FoodId) references Food(Fid);

alter table RejectedOrders
add foreign key (ProductId) references Products(Pid)

alter table RejectedOrders
add foreign key (CustomerCNP) references Customers(CCNP)