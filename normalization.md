# Database Normalization — Property Booking System

## **Objective**

To ensure the Property Booking System database is normalized to **Third Normal Form (3NF)** — minimizing redundancy, improving data consistency, and maintaining referential integrity.



## **1. Understanding Normalization**

**Normalization** is the process of structuring a relational database to reduce data redundancy and improve data integrity.
It involves dividing large tables into smaller, related tables and defining clear relationships between them.

### **Normalization Forms**

| Normal Form | Definition                                                                              | Key Requirement                 |
| ----------- | --------------------------------------------------------------------------------------- | ------------------------------- |
| **1NF**     | Each column holds atomic (indivisible) values; each record is unique.                   | Eliminate repeating groups.     |
| **2NF**     | Achieves 1NF and ensures all non-key attributes are fully dependent on the primary key. | Remove partial dependencies.    |
| **3NF**     | Achieves 2NF and ensures all attributes depend **only** on the primary key.             | Remove transitive dependencies. |



## **2. Review of the Initial Schema**

### **Entities & Attributes**

#### **User**

| Attribute     | Type                      | Notes                |
| ------------- | ------------------------- | -------------------- |
| user_id       | UUID (PK)                 | Primary key          |
| first_name    | VARCHAR                   | Not null             |
| last_name     | VARCHAR                   | Not null             |
| email         | VARCHAR                   | Unique, not null     |
| password_hash | VARCHAR                   | Not null             |
| phone_number  | VARCHAR                   | Nullable             |
| role          | ENUM (guest, host, admin) | Not null             |
| created_at    | TIMESTAMP                 | Default current time |

#### **Property**

| Attribute     | Type                     | Notes                |
| ------------- | ------------------------ | -------------------- |
| property_id   | UUID (PK)                | Primary key          |
| host_id       | UUID (FK → User.user_id) | Links to host        |
| name          | VARCHAR                  | Not null             |
| description   | TEXT                     | Not null             |
| location      | VARCHAR                  | Not null             |
| pricepernight | DECIMAL                  | Not null             |
| created_at    | TIMESTAMP                | Default current time |
| updated_at    | TIMESTAMP                | Auto-updated         |

#### **Booking**

| Attribute   | Type                                | Notes                |
| ----------- | ----------------------------------- | -------------------- |
| booking_id  | UUID (PK)                           | Primary key          |
| property_id | UUID (FK → Property.property_id)    | Linked property      |
| user_id     | UUID (FK → User.user_id)            | Booking user         |
| start_date  | DATE                                | Not null             |
| end_date    | DATE                                | Not null             |
| total_price | DECIMAL                             | Not null             |
| status      | ENUM (pending, confirmed, canceled) | Not null             |
| created_at  | TIMESTAMP                           | Default current time |

#### **Payment**

| Attribute      | Type                               | Notes                |
| -------------- | ---------------------------------- | -------------------- |
| payment_id     | UUID (PK)                          | Primary key          |
| booking_id     | UUID (FK → Booking.booking_id)     | Linked booking       |
| amount         | DECIMAL                            | Not null             |
| payment_date   | TIMESTAMP                          | Default current time |
| payment_method | ENUM (credit_card, paypal, stripe) | Not null             |

#### **Review**

| Attribute   | Type                             | Notes                |
| ----------- | -------------------------------- | -------------------- |
| review_id   | UUID (PK)                        | Primary key          |
| property_id | UUID (FK → Property.property_id) | Linked property      |
| user_id     | UUID (FK → User.user_id)         | Reviewer             |
| rating      | INTEGER (1–5)                    | Not null             |
| comment     | TEXT                             | Not null             |
| created_at  | TIMESTAMP                        | Default current time |

#### **Message**

| Attribute    | Type                     | Notes                |
| ------------ | ------------------------ | -------------------- |
| message_id   | UUID (PK)                | Primary key          |
| sender_id    | UUID (FK → User.user_id) | Sender               |
| recipient_id | UUID (FK → User.user_id) | Recipient            |
| message_body | TEXT                     | Not null             |
| sent_at      | TIMESTAMP                | Default current time |



## **3. Normalization Steps**

### **Step 1 — First Normal Form (1NF)**

✅ **Applied Conditions:**

* Each field holds atomic (indivisible) values.
* Each record is unique via a **Primary Key** (UUID).
* No repeating groups or arrays.

**Result:**
All tables meet **1NF** — attributes are atomic, and every table has a defined primary key.



### **Step 2 — Second Normal Form (2NF)**

✅ **Applied Conditions:**

* Database is already in 1NF.
* All non-key attributes are fully functionally dependent on the **entire** primary key.

**Assessment:**

* All tables use a single-column primary key (`user_id`, `property_id`, etc.), so **no partial dependency exists**.
* Attributes like `first_name`, `email`, etc., depend solely on `user_id`.

**Result:**
All tables meet **2NF** — no attribute is partially dependent on a composite key.



### **Step 3 — Third Normal Form (3NF)**

✅ **Applied Conditions:**

* Database is already in 2NF.
* No transitive dependency (non-key attributes should not depend on other non-key attributes).

**Verification per Table:**

| Table        | Check                                                                                                      | 3NF Compliance |
| ------------ | ---------------------------------------------------------------------------------------------------------- | -------------- |
| **User**     | All attributes depend only on `user_id`. `role` and `email` are independent.                               | ✅              |
| **Property** | All attributes depend solely on `property_id`; `host_id` is a foreign key, not transitive.                 | ✅              |
| **Booking**  | `total_price` is derived from `pricepernight × duration`, but acceptable as a stored value for efficiency. | ✅              |
| **Payment**  | `amount`, `payment_method`, and `payment_date` depend on `payment_id` (not on booking attributes).         | ✅              |
| **Review**   | `rating` and `comment` depend only on `review_id`.                                                         | ✅              |
| **Message**  | `sender_id`, `recipient_id`, and `message_body` depend only on `message_id`.                               | ✅              |

**Result:**
All tables satisfy **3NF** — no transitive dependencies, and each non-key attribute depends only on its table’s primary key.



## **4. Final Schema (3NF-Compliant)**

No further decomposition is needed.
However, relationships are clearly defined to enforce referential integrity:

### **Relationships**

* `User (1) — (M) Property`
* `User (1) — (M) Booking`
* `Property (1) — (M) Booking`
* `Booking (1) — (1) Payment`
* `Property (1) — (M) Review`
* `User (1) — (M) Review`
* `User (1) — (M) Message (sent and received)`

### **Indexes**

* `email` in **User** table (for uniqueness & search).
* `property_id` in **Booking** table (for join optimization).
* `booking_id` in **Payment** table (for fast lookups).



## **5. Summary of Normalization**

| Normal Form | Achieved? | Description                        |
| ----------- | --------- | ---------------------------------- |
| **1NF**     | ✅         | Atomic values, unique primary keys |
| **2NF**     | ✅         | No partial dependency              |
| **3NF**     | ✅         | No transitive dependency           |

✅ **The Property Booking System is fully normalized to 3NF**, ensuring:

* Minimal redundancy
* Improved data integrity
* Efficient data retrieval and updates



## **6. Benefits of the Normalized Design**

* **Data Consistency:** Reduces duplication across tables.
* **Improved Integrity:** Foreign key constraints enforce valid references.
* **Scalability:** Schema supports future extensions (e.g., promotions, property types).
* **Performance:** Indexed keys ensure efficient query execution.
