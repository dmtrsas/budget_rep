go

use Budget

CREATE TABLE TRANSACTIONS (
ID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
ACCOUNT_ID smallint foreign key references ACCOUNTS(ID) NOT NULL,
CARD_ID smallint foreign key references CARDS(ID) NOT NULL,
TXN_AMOUNT dec(10,2) CHECK (TXN_AMOUNT > 0) NOT NULL,
TXN_CURRENCY nchar(3) NOT NULL,
TXN_TYPE nvarchar(255) CHECK (TXN_TYPE in ('Spending','Income','Transfer','Cash withdrawal') ),
TXN_CATEGORY nvarchar(255) NOT NULL,
TXN_MCC smallint,
TXN_DESCR nvarchar (255) NOT NULL,
TXN_DATE date NOT NULL,
TRANSFER_FROM smallint,
TRANSFER_TO smallint,
);
