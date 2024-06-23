-- ������ �����: ����� �������� calculate_discount ���������� escalate_unresolved_tickets
DECLARE
    customer_id NUMBER;
    total_discount NUMBER;
    days_threshold NUMBER;
BEGIN
    -- ��� ���� ������ �� �����
    DBMS_OUTPUT.PUT('Enter Customer ID: ');
    customer_id := TO_NUMBER('&customer_id_input'); -- ��� ���� ����� �������

    -- ����� �������� ������ ���� �����
    total_discount := calculate_discount(customer_id);
    DBMS_OUTPUT.PUT_LINE('Total discount for Customer ID ' || customer_id || ': ' || total_discount);

    -- ��� ���� ����� ��� �����
    DBMS_OUTPUT.PUT('Enter days threshold for ticket escalation: ');
    days_threshold := TO_NUMBER('&days_threshold_input'); -- ��� ���� ����� �������

    -- ����� ��������� ������ ������ ������ ��� �����
    escalate_unresolved_tickets(days_threshold);

    DBMS_OUTPUT.PUT_LINE('Unresolved tickets escalated for days threshold: ' || days_threshold);

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
