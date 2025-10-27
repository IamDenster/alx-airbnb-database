-- ============================================================
-- PROPERTY BOOKING SYSTEM — SAMPLE DATA INSERTS
-- ============================================================

-- ================
-- 1. USER TABLE
-- ================
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
    ('u001', 'John', 'Doe', 'john.doe@example.com', 'hashed_pwd_123', '08012345678', 'host'),
    ('u002', 'Jane', 'Smith', 'jane.smith@example.com', 'hashed_pwd_456', '08098765432', 'guest'),
    ('u003', 'Michael', 'Brown', 'michael.brown@example.com', 'hashed_pwd_789', '08123456789', 'guest'),
    ('u004', 'Sarah', 'Johnson', 'sarah.johnson@example.com', 'hashed_pwd_234', '08111222333', 'host'),
    ('u005', 'Admin', 'User', 'admin@bookingapp.com', 'admin_hashed_pwd', NULL, 'admin');


-- =================
-- 2. PROPERTY TABLE
-- =================
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight)
VALUES
    ('p001', 'u001', 'Sunny Apartment', 'A bright and cozy apartment in the city center.', 'Abuja', 25000.00),
    ('p002', 'u001', 'Hillview Villa', 'Luxury villa overlooking the green hills.', 'Jos', 60000.00),
    ('p003', 'u004', 'Urban Studio', 'Modern studio apartment close to restaurants.', 'Lagos', 30000.00),
    ('p004', 'u004', 'Palm Court Duplex', 'Spacious duplex in a quiet neighborhood.', 'Abuja', 45000.00);


-- =================
-- 3. BOOKING TABLE
-- =================
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
    ('b001', 'p001', 'u002', '2025-10-10', '2025-10-15', 125000.00, 'confirmed'),
    ('b002', 'p002', 'u002', '2025-09-20', '2025-09-25', 300000.00, 'canceled'),
    ('b003', 'p003', 'u003', '2025-11-01', '2025-11-04', 90000.00, 'pending'),
    ('b004', 'p004', 'u003', '2025-10-05', '2025-10-08', 135000.00, 'confirmed');


-- =================
-- 4. PAYMENT TABLE
-- =================
INSERT INTO Payment (payment_id, booking_id, amount, payment_method)
VALUES
    ('pay001', 'b001', 125000.00, 'credit_card'),
    ('pay002', 'b004', 135000.00, 'paypal');


-- =================
-- 5. REVIEW TABLE
-- =================
INSERT INTO Review (review_id, property_id, user_id, rating, comment)
VALUES
    ('r001', 'p001', 'u002', 5, 'Amazing stay! Clean apartment and great location.'),
    ('r002', 'p004', 'u003', 4, 'Spacious and comfortable, but Wi-Fi could be faster.'),
    ('r003', 'p002', 'u002', 3, 'Beautiful view but the trip got canceled before check-in.');


-- =================
-- 6. MESSAGE TABLE
-- =================
INSERT INTO Message (message_id, sender_id, recipient_id, message_body)
VALUES
    ('m001', 'u002', 'u001', 'Hello, John! I would like to confirm my stay at Sunny Apartment.'),
    ('m002', 'u001', 'u002', 'Hi Jane! Your booking has been confirmed. Welcome aboard!'),
    ('m003', 'u003', 'u004', 'Hey Sarah, is the Urban Studio available for early check-in?'),
    ('m004', 'u004', 'u003', 'Hi Michael! Yes, you can check in from 10 AM tomorrow.');

-- ============================================================
-- END OF SAMPLE DATA
-- ============================================================
