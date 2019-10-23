CREATE OR REPLACE TRIGGER "T_WF_CUROPT_TRIGGERYLS"
  before insert on workflow_currentoperator
  for each row

DECLARE
 minID NUMBER;
begin
  IF :new.GROUPID > 0 THEN
    select min(cc.ID)
      into minID
      from workflow_currentoperator cc
     WHERE cc.REQUESTID = :new.REQUESTID
       AND cc.GROUPID = 0;

        select cc.USERID
      into :new.USERID
      from workflow_currentoperator cc
     WHERE cc.id = minID;

  END IF;
end;
/
