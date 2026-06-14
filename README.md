# Football Ticket Booking System - Database Schema

A SQL database schema for managing football match tickets, user accounts, and bookings.

## Overview

This project sets up a relational database with three core tables to manage a football ticket booking system:

- **Users**: Store user profiles with roles (Football Fan, Ticket Manager)
- **Matches**: Store match/fixture details with pricing and availability status
- **Bookings**: Track ticket reservations linking users to matches

## Tables

### Users
- `user_id` (Primary Key)
- `full_name`, `email` (unique), `phone_number`
- `role`: Either "Football Fan" or "Ticket Manager"

### Matches
- `match_id` (Primary Key)
- `fixture`: Match description (e.g., "Real Madrid vs Barcelona")
- `tournament_category`: Competition type (Champions League, Premier League, etc.)
- `base_ticket_price`: Base price in decimal format
- `match_status`: Available, Selling Fast, Sold Out, or Postponed

### Bookings
- `booking_id` (Primary Key)
- `user_id`, `match_id` (Foreign Keys)
- `seat_number`: Assigned seat
- `payment_status`: Pending, Confirmed, Cancelled, or Refunded
- `total_cost`: Total booking amount

## Sample Queries

The file includes 7 example queries:

1. **Query 1**: Find available Champions League matches with pricing
2. **Query 2**: Search users by full name pattern
3. **Query 3**: Find bookings with missing payment status
4. **Query 4**: Join all three tables to display booking details
5. **Query 5**: Left join to show all users and their bookings
6. **Query 6**: Find bookings with above-average cost
7. **Query 7**: Get 2nd and 3rd most expensive matches

## Usage

Run this SQL file against a PostgreSQL database to initialize the schema with sample data:

```bash
psql -U username -d database_name -f query.sql
```
