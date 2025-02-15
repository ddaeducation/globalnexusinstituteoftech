/*
  # Initial Schema Setup for Global Nexus Institute

  1. New Tables
    - `programs`
      - `id` (uuid, primary key)
      - `title` (text)
      - `description` (text)
      - `duration` (text)
      - `price` (decimal)
      - `level` (text)
      - `created_at` (timestamp)
      
    - `enrollments`
      - `id` (uuid, primary key)
      - `user_id` (uuid, foreign key)
      - `program_id` (uuid, foreign key)
      - `status` (text)
      - `payment_status` (text)
      - `created_at` (timestamp)
      
    - `contact_messages`
      - `id` (uuid, primary key)
      - `name` (text)
      - `email` (text)
      - `subject` (text)
      - `message` (text)
      - `created_at` (timestamp)

  2. Security
    - Enable RLS on all tables
    - Add policies for authenticated users
    - Add policies for admin users
*/

-- Programs table
CREATE TABLE programs (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title text NOT NULL,
  description text NOT NULL,
  duration text NOT NULL,
  price decimal NOT NULL,
  level text NOT NULL,
  created_at timestamptz DEFAULT now()
);

ALTER TABLE programs ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Programs are viewable by everyone"
  ON programs
  FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Programs are insertable by admin users only"
  ON programs
  FOR INSERT
  TO authenticated
  USING (auth.jwt() ->> 'email' IN (SELECT email FROM auth.users WHERE is_admin = true));

CREATE POLICY "Programs are updatable by admin users only"
  ON programs
  FOR UPDATE
  TO authenticated
  USING (auth.jwt() ->> 'email' IN (SELECT email FROM auth.users WHERE is_admin = true));

-- Enrollments table
CREATE TABLE enrollments (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES auth.users NOT NULL,
  program_id uuid REFERENCES programs NOT NULL,
  status text NOT NULL DEFAULT 'pending',
  payment_status text NOT NULL DEFAULT 'pending',
  created_at timestamptz DEFAULT now(),
  UNIQUE(user_id, program_id)
);

ALTER TABLE enrollments ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view their own enrollments"
  ON enrollments
  FOR SELECT
  TO authenticated
  USING (auth.uid() = user_id);

CREATE POLICY "Users can create their own enrollments"
  ON enrollments
  FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own enrollments"
  ON enrollments
  FOR UPDATE
  TO authenticated
  USING (auth.uid() = user_id);

-- Contact messages table
CREATE TABLE contact_messages (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  email text NOT NULL,
  subject text NOT NULL,
  message text NOT NULL,
  created_at timestamptz DEFAULT now()
);

ALTER TABLE contact_messages ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can create contact messages"
  ON contact_messages
  FOR INSERT
  TO public
  WITH CHECK (true);

CREATE POLICY "Only admin users can view contact messages"
  ON contact_messages
  FOR SELECT
  TO authenticated
  USING (auth.jwt() ->> 'email' IN (SELECT email FROM auth.users WHERE is_admin = true));