CREATE TABLE Roles(
    Id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    Name VARCHAR(30)
);

CREATE TABLE Users(
    Id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    Email varchar(40) UNIQUE,
    Salt varchar(16),
    PasswordHash varchar(32),
    RoleId INTEGER NOT NULL
        REFERENCES Roles (Id),
    FOREIGN KEY (RoleId)
        REFERENCES Roles (Id) 
);

CREATE TABLE Apis(
    Id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    Route vrchar(100) NOT NULL,
    Name varchar(40),
    ApiKey varchar(100),
    Host varchar(100)
);

CREATE TABLE ApiTasks(
    Id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    ApiId INTEGER NOT NULL,
    QueryString varchar(100) NOT NULL,
    Description VARCHAR(100),
     FOREIGN KEY (APIId)
         REFERENCES APIs (Id) 
);

drop table UserTasks;

CREATE TABLE UserTasks(
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    Name VARCHAR(30) NOT NULL,
    UserId INTEGER NOT NULL,
    TaskId INTEGER NOT NULL,
    NextInvoke VARCHAR(20),
    DaysInterval INTEGER,
    TimeInterval VARCHAR(5),
     FOREIGN KEY (UserId)
         REFERENCES Users (Id),
     FOREIGN KEY (TaskID)
         REFERENCES APITasks (Id)
);

CREATE TABLE TaskParameters(
    Id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    TaskId INTEGER NOT NULL,
    Name varchar(50) NOT NULL,
    Description VARCHAR(100),
    DefaultValue VARCHAR(100),
     FOREIGN KEY (TaskId)
         REFERENCES APITasks (Id) 
);

CREATE TABLE UserTaskParameters(
    UserTaskId INTEGER NOT NULL,
    ParameterId INTEGER NOT NULL,
    Value VARCHAR(100),
     FOREIGN KEY (UserTaskId)
         REFERENCES UserTasks (Id),
     FOREIGN KEY (ParameterId)
         REFERENCES TaskParameters (Id) 
);


Insert into Roles(Name) Values(
"Admin");
Insert into Roles(Name) Values(
"User");

Insert into Users (Email, Salt, PasswordHash, RoleId)
VALUES('user1@example.com', 'tVFWYKb6HUs0173NbBi3cH/ufihoclkxl7tLUI3bUUc=', '3PYhiNdZpb78xs5eTL6QoMqmCICSh9HYlWveTNYap+o=',2);

insert into APIs(Name, Route, ApiKey, Host) values
('Weather api', 'https://community-open-weather-map.p.rapidapi.com/', 'e6af7dfd27msh63952ea2ca12587p1c4fb9jsn79ffc0573f2e', 'community-open-weather-map.p.rapidapi.com');
insert into APIs(Name, Route, ApiKey, Host) values
('COVID-19 api', 'https://covid-19-data.p.rapidapi.com/', 'e6af7dfd27msh63952ea2ca12587p1c4fb9jsn79ffc0573f2e', 'covid-19-data.p.rapidapi.com');


insert into APITasks(APIId, QueryString, Description) values
(1, 'climate/month', 'Get wather forecast for month ahead');
insert into APITasks(APIId, QueryString, Description) values
(1, 'weather', 'Get current weather');

insert into APITasks(APIId, QueryString, Description) values
(2, 'totals', 'Get latest data for whole world');
insert into APITasks(APIId, QueryString, Description) values
(2, 'country', 'Get latest data for cpecified country');


insert into TaskParameters(TaskId, Parameter, Description, DefaultValue) values
(1, 'q', 'Input name of the city and name of the country (optional) example: Minsk, Belarus', 'Minsk');
insert into TaskParameters(TaskId, Parameter, Description, DefaultValue) values
(1, 'units', 'Choose units for response (metric/imperial). Default metric.', 'metric');