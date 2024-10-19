-- Creating Table	
CREATE TABLE mobile_user_behaviour(
	UserId INT PRIMARY KEY,
	Device_Model VARCHAR(70),
	Operating_System VARCHAR(50),
	App_Usage_Time INT,
	Screen_On_Time FLOAT4,
	Battery_Drain INT,
	Number_of_Apps_Installed INT,
	Data_Usage INT,
	Age INT,
	Gender VARCHAR(10)
);

SELECT *
FROM mobile_user_behaviour;

