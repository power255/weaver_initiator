TRIGGER "T_WF_CUROPT_TRIGGERYLS "
  before insert on workflow_currentoperator
  for each row

DECLARE
 minID NUMBER;
begin
  select count(*) into minID from workflow_nodebase b where b.id=:new.NODEID and b.isend='1';
  IF minID=0 and :new.GROUPID > 0 THEN
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
