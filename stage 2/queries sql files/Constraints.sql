-- Constraint: chck_pricePositive on PRODUCT table
-- Ensures that the Price of a product is positive.
ALTER TABLE PRODUCT
ADD CONSTRAINT chck_pricePositive CHECK (Price > 0);

-- Constraint: DEFAULT 'Credit Card' on PAYMENT table
-- Sets a default value of 'Credit Card' for the PaymentMethod column.
ALTER TABLE PAYMENT
MODIFY (PaymentMethod DEFAULT 'Credit Card');

-- Constraint: chck_total_amount on AIR_ORDER table
-- Ensures that the TotalAmount of an order is non-negative.
ALTER TABLE AIR_ORDER
ADD CONSTRAINT chck_total_amount CHECK (TotalAmount >= 0);

-- Constraint: chek_dates on SUPPORT_TICKET table
-- Ensures that if a ticket is resolved, ResolvedDate must be later than CreatedDate.
ALTER TABLE SUPPORT_TICKET
ADD CONSTRAINT chek_dates CHECK (ResolvedDate IS NULL OR ResolvedDate > CreatedDate);
