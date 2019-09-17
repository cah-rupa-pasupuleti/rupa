function main(Data)
   -- Parse the JSON message
   local Msg = xml.parse(Data)  
   local Conn = db.connect{
         api=db.SQL_SERVER,
         name='sql servr',       
      user='',
         password='',
      use_unicode=true,
         live=true
         }

   
 local SqlInsert =
   [[
   INSERT INTO patient
   (
   Id,
   LastName,
   GivenName,
   Ssn
   )
   VALUES
   (
   ]]..
   "'"..Msg.patients.patient.id.."',"..
   "\n   '"..Msg.patients.patient["first-name"][1].."',"..
   "\n   '"..Msg.patients.patient["last-name"][1].."',"..
   "\n   '"..Msg.patients.patient["social-security-no"][1].."'"..
   '\n   )'  
   -- Insert data into database
   Conn:execute{sql=SqlInsert, live=true}
   
     local SqlUpdate =
   "   UPDATE patient SET"..
   "\n   LastName = '"..Msg.patients.patient["last-name"][1].."',"..
   "\n   GivenName = '"..Msg.patients.patient["first-name"][1].."',"..
   "\n   Ssn = '"..Msg.patients.patient["social-security-no"][1].."'"..
   "\n   WHERE Id = '"..Msg.patients.patient.id.."'"
         
   -- (3) Update database
   Conn:execute{sql=SqlUpdate, live=true}
   
   -- Check that the records were inserted
   Conn:query('SELECT * FROM patient')
   
   Conn:query('SELECT patient.Id,patient.LastName,patient.GivenName,patient.Ssn FROM   dbo.patient,dbo.patient1 WHERE patient1.Id = patient.Id AND patient1.LastName = patient.LastName AND patient.GivenName = patient1.GivenName AND patient.Ssn = patient1.Ssn ')

end