-- FinanceTracker Supabase Schema

-- Transactions table
CREATE TABLE transactions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  type TEXT NOT NULL CHECK (type IN ('expense', 'income')),
  category TEXT NOT NULL,
  amount NUMERIC NOT NULL,
  date DATE NOT NULL,
  description TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- DPS Accounts table
CREATE TABLE dps_accounts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  bank_name TEXT NOT NULL,
  monthly_deposit NUMERIC NOT NULL,
  period_years NUMERIC NOT NULL,
  profit_percentage NUMERIC NOT NULL,
  start_date DATE NOT NULL,
  target_total NUMERIC NOT NULL,
  maturity_date DATE NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- DPS Deposits table
CREATE TABLE dps_deposits (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  account_id UUID REFERENCES dps_accounts(id) ON DELETE CASCADE,
  amount NUMERIC NOT NULL,
  date DATE NOT NULL,
  description TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Increment History table
CREATE TABLE increment_history (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  year TEXT NOT NULL,
  percent_increase NUMERIC NOT NULL,
  amount_plus NUMERIC NOT NULL,
  gross_total NUMERIC NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Leave Applications table
CREATE TABLE leaves (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  type TEXT NOT NULL,
  status TEXT NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  reason TEXT,
  applied_date TIMESTAMPTZ DEFAULT NOW(),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Bills table
CREATE TABLE bills (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  type TEXT NOT NULL,
  amount NUMERIC NOT NULL,
  month TEXT NOT NULL,
  year TEXT NOT NULL,
  date DATE NOT NULL,
  applied_date TIMESTAMPTZ DEFAULT NOW(),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Settings table for global app states
CREATE TABLE app_settings (
  key TEXT PRIMARY KEY,
  value TEXT NOT NULL,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Initial settings data
INSERT INTO app_settings (key, value) VALUES 
('grossSalary', '0'),
('baseDeduction', '0'),
('medical', '0'),
('conveyance', '0'),
('food', '0'),
('attendanceBonus', '0'),
('days', '0'),
('rate', '0'),
('casualLimit', '15'),
('medicalLimit', '15'),
('annualLimit', '20')
ON CONFLICT (key) DO NOTHING;
