go

use Budget

CREATE TABLE TRANSACTIONS (
TXN_DATE date NOT NULL,
TXN_TIME time NOT NULL,
TXN_DESCR nvarchar (255) NOT NULL,
TXN_AMOUNT dec(10,2) NOT NULL,
TXN_CURRENCY nvarchar(20) NOT NULL,
BILL_DATE date not null,
ACCOUNT_NO nvarchar(30),
BILL_AMOUNT dec(10,2) NOT NULL,
BILL_CURRENCY nvarchar(20) NOT NULL,
PAN nvarchar(10) NOT NULL,
TXN_CATEGORY nvarchar(255) NOT NULL,
TXN_TYPE nvarchar(255) CHECK (TXN_TYPE in ('Spending','Income','Transfer','Cash withdrawal') ),
TRANSFER_FROM smallint,
TRANSFER_TO smallint,
ID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
ACCOUNT_ID smallint foreign key references ACCOUNTS(ID) NOT NULL,
CARD_ID smallint foreign key references CARDS(ID) NOT NULL

);
