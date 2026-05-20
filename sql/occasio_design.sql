-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 19, 2026 at 08:53 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

-- Admin: bhugaivinisha@gmail.com
-- Password: Binisha@123
-- User: binisha@gmail.com
-- Password: Binisha@123
-- --------------------------------------------------------
-- --------------------------------------------------------
-- Database: `occasio_design`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `booking_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `theme_id` int(11) NOT NULL,
  `event_date` date NOT NULL,
  `booking_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `event_location` varchar(255) NOT NULL,
  `number_of_guests` int(11) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'pending',
  `special_request` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`booking_id`, `user_id`, `event_id`, `theme_id`, `event_date`, `booking_date`, `event_location`, `number_of_guests`, `total_price`, `status`, `special_request`) VALUES
(3, 3, 3, 3, '2026-05-18', '2026-04-16 18:46:00', 'Lalitpur Grand Hall', 200, 47000.00, 'confirmed', 'Need a luxury stage and welcome board.'),
(4, 4, 4, 4, '2026-05-22', '2026-04-16 18:46:00', 'Bhaktapur Family Home', 40, 25000.00, 'pending', 'Add baby boy theme items and pastel balloons.'),
(5, 5, 5, 5, '2026-06-01', '2026-04-16 18:46:00', 'Butwal Event Center', 60, 19500.00, 'confirmed', 'Need a photo wall with graduation caps.'),
(6, 6, 6, 6, '2026-06-08', '2026-04-16 18:46:00', 'Chitwan Conference Hall', 120, 30000.00, 'confirmed', 'Set up a brand color stage and microphone area.'),
(7, 7, 7, 7, '2026-06-15', '2026-04-16 18:46:00', 'Dharan Community Hall', 100, 22000.00, 'pending', 'Include diya decoration and rangoli corner.'),
(8, 8, 8, 8, '2026-06-25', '2026-04-16 18:46:00', 'Nepalgunj Royal Hall', 110, 34000.00, 'confirmed', 'Add a heart-shaped stage with red flowers.'),
(9, 9, 9, 9, '2026-07-02', '2026-04-16 18:46:00', 'Hetauda School Hall', 70, 17500.00, 'confirmed', 'Make a memory wall for photos and notes.'),
(10, 10, 10, 10, '2026-12-31', '2026-04-16 18:46:00', 'Pokhara Rooftop Venue', 140, 27500.00, 'confirmed', 'Need countdown numbers, lights, and confetti.'),
(11, 11, 5, 10, '2026-05-20', '2026-05-15 01:40:10', 'Pokhara Hall, Simpani, Pokhara', 200, 21500.00, 'cancelled', 'thank you !'),
(12, 11, 5, 9, '2026-05-21', '2026-05-15 02:14:08', 'Pokhara Hall, Simpani, Pokhara', 99, 18500.00, 'pending', 'Thank You !'),
(13, 12, 7, 10, '2026-06-17', '2026-05-15 04:24:19', 'Pokhara Hall, Simpani, Pokhara', 200, 23500.00, 'pending', 'Thank you !'),
(14, 12, 4, 10, '2026-06-12', '2026-05-15 20:33:35', 'Pokhara Hall, Simpani, Pokhara', 200, 25500.00, 'pending', ''),
(15, 12, 4, 10, '2026-06-12', '2026-05-15 20:33:37', 'Pokhara Hall, Simpani, Pokhara', 200, 25500.00, 'cancelled', '');

-- --------------------------------------------------------

--
-- Table structure for table `event_types`
--

CREATE TABLE `event_types` (
  `event_id` int(11) NOT NULL,
  `event_name` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `category` varchar(50) NOT NULL,
  `base_price` decimal(10,2) NOT NULL,
  `max_guests` int(11) NOT NULL,
  `location` varchar(100) NOT NULL,
  `duration_hours` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` varchar(20) NOT NULL DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `event_types`
--

INSERT INTO `event_types` (`event_id`, `event_name`, `description`, `category`, `base_price`, `max_guests`, `location`, `duration_hours`, `created_at`, `status`) VALUES
(1, 'Birthday Party', 'Decorated birthday setup for kids, teens, or adults with balloons, cake table, and backdrop.', 'Celebration', 12000.00, 80, 'Indoor / Outdoor Venue', 4, '2026-04-16 18:46:00', 'active'),
(2, 'Wedding Anniversary', 'Elegant anniversary decoration with flowers, candles, lights, and romantic theme styling.', 'Celebration', 15000.00, 100, 'Banquet Hall', 5, '2026-04-16 18:46:00', 'active'),
(3, 'Wedding Reception', 'Premium reception decoration with stage backdrop, floral arches, lighting, and guest seating.', 'Wedding', 35000.00, 250, 'Reception Hall', 8, '2026-04-16 18:46:00', 'active'),
(4, 'Baby Shower', 'Soft pastel themed baby shower setup with balloons, props, and welcome board.', 'Family', 18000.00, 60, 'Home / Hall', 4, '2026-04-16 18:46:00', 'active'),
(5, 'Graduation Party', 'Modern graduation celebration with cap, gown colors, photo zone, and table decoration.', 'Achievement', 14000.00, 70, 'Event Space', 4, '2026-04-16 18:46:00', 'active'),
(6, 'Corporate Event', 'Professional event styling for office meetings, product launches, and company gatherings.', 'Business', 22000.00, 150, 'Conference Hall', 6, '2026-04-16 18:46:00', 'active'),
(7, 'Festival Decoration', 'Festival-themed decoration for Dashain, Tihar, Holi, and other cultural events.', 'Festival', 16000.00, 120, 'Temple / Community Hall', 5, '2026-04-16 18:46:00', 'active'),
(8, 'Engagement Ceremony', 'Stylish engagement decoration with ring stage, flower decor, and photo corner.', 'Celebration', 25000.00, 120, 'Banquet Hall', 6, '2026-04-16 18:46:00', 'active'),
(9, 'Farewell Party', 'Warm farewell setup with memory wall, balloons, and celebration stage decoration.', 'Social', 13000.00, 90, 'School / College Hall', 4, '2026-04-16 18:46:00', 'active'),
(10, 'New Year Party', 'Colorful new year countdown decoration with lights, confetti, and party backdrop.', 'Celebration', 20000.00, 150, 'Rooftop Venue', 6, '2026-04-16 18:46:00', 'active'),
(11, 'Surprise Party', 'Turn an ordinary day into an unforgettable memory with secret planning and pure joy on reveal day.', 'General', 10000.00, 1000, 'Kathmandu', 4, '2026-05-15 03:13:26', 'inactive');

-- --------------------------------------------------------

--
-- Table structure for table `themes`
--

CREATE TABLE `themes` (
  `theme_id` int(11) NOT NULL,
  `theme_name` varchar(100) NOT NULL,
  `event_id` int(11) NOT NULL,
  `color_scheme` varchar(50) NOT NULL,
  `decoration_type` varchar(100) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `availability_status` varchar(20) NOT NULL,
  `description` text NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `themes`
--

INSERT INTO `themes` (`theme_id`, `theme_name`, `event_id`, `color_scheme`, `decoration_type`, `price`, `availability_status`, `description`, `image_path`, `created_at`) VALUES
(1, 'Rainbow Birthday', 1, 'Multi-color', 'Balloon Arch', 5000.00, 'available', 'Bright birthday theme with rainbow balloons, number stand, and cake table styling.', 'images/themes/birthday.jpg', '2026-04-16 18:46:00'),
(2, 'Golden Anniversary', 2, 'Gold and White', 'Flower Stage', 6500.00, 'available', 'Elegant anniversary theme with gold lights, white drapes, and floral accents.', 'images/themes/anniversary.jpg', '2026-04-16 18:46:00'),
(3, 'Royal Reception', 3, 'Maroon and Gold', 'Luxury Backdrop', 12000.00, 'available', 'Premium wedding reception theme with luxury backdrop and stage decor.', 'images/themes/reception.jpg', '2026-04-16 18:46:00'),
(4, 'Pastel Baby Joy', 4, 'Pink, Blue and Cream', 'Soft Balloon Setup', 7000.00, 'available', 'Soft pastel baby shower theme with cute props and balloon clusters.', 'images/themes/babyshower.jpg', '2026-04-16 18:46:00'),
(5, 'Graduation Glow', 5, 'Black and Gold', 'Photo Wall', 5500.00, 'available', 'Stylish graduation theme with cap motifs, gold accents, and photo backdrop.', 'images/themes/graduation.jpg', '2026-04-16 18:46:00'),
(6, 'Corporate Minimal', 6, 'Blue and White', 'Clean Stage Setup', 8000.00, 'available', 'Modern corporate styling with minimal decor, branding board, and stage lights.', 'images/themes/corporate.jpg', '2026-04-16 18:46:00'),
(7, 'Festive Glow', 7, 'Red, Yellow and Orange', 'Traditional Decor', 6000.00, 'available', 'Festival decoration with traditional colors, diyas, banners, and rangoli corner.', 'images/themes/festival.jpg', '2026-04-16 18:46:00'),
(8, 'Elegant Proposal', 8, 'Red and White', 'Heart Stage', 9000.00, 'available', 'Romantic engagement theme with heart backdrop, candles, and floral setup.', 'images/themes/engagement.jpg', '2026-04-16 18:46:00'),
(9, 'Memory Lane', 9, 'Blue and Silver', 'Memory Board', 4500.00, 'available', 'Farewell theme with memory board, balloon decor, and farewell message display.', 'images/themes/farewell.jpg', '2026-04-16 18:46:00'),
(10, 'Midnight Countdown', 10, 'Black, Gold and Silver', 'Party Lights', 7500.00, 'available', 'New year theme with countdown stage, glitter lights, and confetti decoration.', 'images/themes/newyear.jpg', '2026-04-16 18:46:00');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `password` varchar(255) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `role` varchar(10) NOT NULL DEFAULT 'user',
  `address` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `full_name`, `email`, `phone`, `password`, `gender`, `date_of_birth`, `role`, `address`, `created_at`) VALUES
(3, 'Sujata Shrestha', 'sujata.shrestha@example.com', '9810000003', '$2a$10$GUbQrqzbnCqA3lw6pu1ZKeBn1ZqSatg3T5kPjrvhIi7kPjv23P/xO', 'Female', '2004-11-09', 'user', 'Lalitpur, Nepal', '2026-04-16 18:46:00'),
(4, 'Rohan Thapa', 'rohan.thapa@example.com', '9810000004', '$2a$10$GUbQrqzbnCqA3lw6pu1ZKeBn1ZqSatg3T5kPjrvhIi7kPjv23P/xO', 'Male', '2003-06-30', 'user', 'Bhaktapur, Nepal', '2026-04-16 18:46:00'),
(5, 'Mina Gurung', 'mina.gurung@example.com', '9810000005', '$2a$10$GUbQrqzbnCqA3lw6pu1ZKeBn1ZqSatg3T5kPjrvhIi7kPjv23P/xO', 'Female', '2002-02-14', 'user', 'Butwal, Nepal', '2026-04-16 18:46:00'),
(6, 'Prakash Adhikari', 'prakash.adhikari@example.com', '9810000006', '$2a$10$GUbQrqzbnCqA3lw6pu1ZKeBn1ZqSatg3T5kPjrvhIi7kPjv23P/xO', 'Male', '2001-09-18', 'user', 'Chitwan, Nepal', '2026-04-16 18:46:00'),
(7, 'Nisha Rai', 'nisha.rai@example.com', '9810000007', '$2a$10$GUbQrqzbnCqA3lw6pu1ZKeBn1ZqSatg3T5kPjrvhIi7kPjv23P/xO', 'Female', '2005-12-03', 'user', 'Dharan, Nepal', '2026-04-16 18:46:00'),
(8, 'Sanjay BC', 'sanjay.bc@example.com', '9810000008', '$2a$10$GUbQrqzbnCqA3lw6pu1ZKeBn1ZqSatg3T5kPjrvhIi7kPjv23P/xO', 'Male', '2000-04-25', 'user', 'Nepalgunj, Nepal', '2026-04-16 18:46:00'),
(9, 'Anita Sharma', 'anita.sharma@example.com', '9810000009', '$2a$10$GUbQrqzbnCqA3lw6pu1ZKeBn1ZqSatg3T5kPjrvhIi7kPjv23P/xO', 'Female', '2004-07-11', 'user', 'Hetauda, Nepal', '2026-04-16 18:46:00'),
(10, 'Kiran Lama', 'kiran.lama@example.com', '9810000010', '$2a$10$GUbQrqzbnCqA3lw6pu1ZKeBn1ZqSatg3T5kPjrvhIi7kPjv23P/xO', 'Male', '2003-10-05', 'admin', 'Pokhara, Nepal', '2026-04-16 18:46:00'),
(11, 'Binisha Bhugai', 'bhugaivinisha@gmail.com', '9806585567', '$2a$10$GUbQrqzbnCqA3lw6pu1ZKeBn1ZqSatg3T5kPjrvhIi7kPjv23P/xO', 'Female', '2010-01-05', 'admin', 'Simpani', '2026-05-02 04:14:55'),
(12, 'Bhugai', 'binisha@gmail.com', '9820000000', '$2a$10$6VSu32l6B4nRqsTvGIOf5OMXOdo7.uPJRTIfgTvMuaa7L1wiouD6.', 'Female', '2006-05-10', 'user', 'Kathmandu', '2026-05-15 04:03:40'),
(13, 'Siruta Ale', 'siruta123@gmail.com', '9811111111', '$2a$10$aKsjYHsBtYElIobHfRt74.0eXBH8eOz4efslSfd2hO6m.5s6bTBjO', 'Female', '2005-04-14', 'user', 'Pokhara', '2026-05-19 17:58:19');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `event_id` (`event_id`),
  ADD KEY `theme_id` (`theme_id`);

--
-- Indexes for table `event_types`
--
ALTER TABLE `event_types`
  ADD PRIMARY KEY (`event_id`);

--
-- Indexes for table `themes`
--
ALTER TABLE `themes`
  ADD PRIMARY KEY (`theme_id`),
  ADD KEY `event_id` (`event_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone` (`phone`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `booking_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `event_types`
--
ALTER TABLE `event_types`
  MODIFY `event_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `themes`
--
ALTER TABLE `themes`
  MODIFY `theme_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `event_types` (`event_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bookings_ibfk_3` FOREIGN KEY (`theme_id`) REFERENCES `themes` (`theme_id`) ON DELETE CASCADE;

--
-- Constraints for table `themes`
--
ALTER TABLE `themes`
  ADD CONSTRAINT `themes_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `event_types` (`event_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
