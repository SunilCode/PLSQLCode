DECLARE
    l_business_parter VARCHAR2(100) := 'Distributor';
    l_lead_for VARCHAR2(100);
BEGIN
    l_lead_for := l_business_parter; 
    DBMS_OUTPUT.PUT_LINE(l_lead_for);
END;
